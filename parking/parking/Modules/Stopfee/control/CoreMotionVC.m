//
//  CoreMotionVC.m
//  Indoorpositioning
//
//  Created by 柯思汉 on 17/8/25.
//  Copyright © 2017年 KKK. All rights reserved.
//

#import "CoreMotionVC.h"
#import <CoreMotion/CoreMotion.h>
#import <AVFoundation/AVFoundation.h>
#import <AFNetworking.h>
#import "JFHttpRequestTool.h"
#import "SVProgressHUD.h"

//包含头文件
#import "iflyMSC/IFlyMSC.h"
//需要实现IFlySpeechSynthesizerDelegate合成会话的服务代理<IFlySpeechSynthesizerDelegate>
#define DEVICE_WIDTH ([UIScreen mainScreen].bounds.size.width)//设备宽
#define DEVICE_HEIGHT ([UIScreen mainScreen].bounds.size.height)//设备高
#define IMG_WIDTH 1020.8
#define IMG_HIGH 880.0
@interface CoreMotionVC ()<UIScrollViewDelegate,UIGestureRecognizerDelegate,IFlySpeechSynthesizerDelegate>
@property (strong, nonatomic) IBOutlet UILabel *LABEL;
@property(nonatomic,strong)CMMotionManager *manger;


@property(strong, nonatomic)AVAudioPlayer *mPlayer;

@property(assign, nonatomic)NSInteger mCount;
@property (strong, nonatomic) IBOutlet UIView *backview;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;
@property (strong, nonatomic) IBOutlet UIImageView *map;
@property(nonatomic,strong)UIView *point;
@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic,assign)float MAP_HIGH;
@property (nonatomic,assign)float MAP_WIDTH;
@property (nonatomic,assign)float distance;
@property (nonatomic,assign)float sum;
@property (nonatomic,assign)float scales;
@property (nonatomic,strong)NSArray *point_arr;
@property (nonatomic,assign)int hiddentime;
@property (nonatomic,assign)int branch_num;
@property (nonatomic, strong) IFlySpeechSynthesizer *iFlySpeechSynthesizer;
@end

@implementation CoreMotionVC
- (void)viewWillAppear:(BOOL)animated
{
    _hiddentime=0;
    _MAP_HIGH=DEVICE_WIDTH;
    _MAP_WIDTH=DEVICE_HEIGHT;
    _distance=10;
    [self interfaceOrientation:UIInterfaceOrientationLandscapeRight];
    _high.constant = DEVICE_WIDTH*(IMG_HIGH/IMG_WIDTH);
    
    NSLog(@"%f ,%f",IMG_HIGH,IMG_WIDTH);
    _mCount = 0;
  
//    //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
//

}
- (void)viewWillDisappear:(BOOL)animated
{
      [self interfaceOrientation:UIInterfaceOrientationPortrait];
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    1404/802 == DEVICE_WIDTH/DEVICE_HEIGHT
        _timer =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timers:) userInfo:nil repeats:YES];
    //关闭定时器
    [_timer setFireDate:[NSDate distantFuture]];
//
//    self.timer = [NSTimer timerWithTimeInterval:0.5 target:self selector:@selector(timers:) userInfo:nil repeats:YES];
//    // 添加到运行循环  NSRunLoopCommonModes:占位模式  主线程
//    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes]; // 如果不改变Mode模式在滑动屏幕的时候定时器就不起作用了
////    在子线程中定义定时器：
//    [NSThread detachNewThreadSelector:@selector(bannerStart)toTarget:self withObject:nil];
//    
    //设置最大伸缩比例
    _scrollview.maximumZoomScale=1.5;
    //设置最小伸缩比例
    _scrollview.minimumZoomScale=1.0;
    //设置代理scrollview的代理对象
    _scrollview.delegate=self;
    _scales=1;

    
    
    [self.backview addSubview:self.point];
    
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self.navigationController.view addGestureRecognizer:singleTap];//这个可以加到任何控件上,比如你只想响应WebView，我正好填满整个屏幕
    singleTap.delegate = self;
    singleTap.cancelsTouchesInView = NO;
   
    /*科大讯飞*/
     
     //获取语音合成单例
     _iFlySpeechSynthesizer = [IFlySpeechSynthesizer sharedInstance];
     //设置协议委托对象
     _iFlySpeechSynthesizer.delegate = self;
     //设置合成参数
     //设置在线工作方式
     [_iFlySpeechSynthesizer setParameter:[IFlySpeechConstant TYPE_CLOUD]
     forKey:[IFlySpeechConstant ENGINE_TYPE]];
     //设置音量，取值范围 0~100
     [_iFlySpeechSynthesizer setParameter:@"50"
     forKey: [IFlySpeechConstant VOLUME]];
     //发音人，默认为”xiaoyan”，可以设置的参数列表可参考“合成发音人列表”
     [_iFlySpeechSynthesizer setParameter:@" xiaoyan "
     forKey: [IFlySpeechConstant VOICE_NAME]];
     //保存合成文件名，如不再需要，设置为nil或者为空表示取消，默认目录位于library/cache下
     [_iFlySpeechSynthesizer setParameter:@" tts.pcm"
     forKey: [IFlySpeechConstant TTS_AUDIO_PATH]];
    
     
    
    
    // Do any additional setup after loading the view from its nib.
}
#pragma mark IFlySpeechSynthesizerDelegate 科大讯飞
//合成结束
- (void) onCompleted:(IFlySpeechError *) error {}
//合成开始
- (void) onSpeakBegin
{

}
//合成缓冲进度
- (void) onBufferProgress:(int) progress message:(NSString *)msg {}
//合成播放进度
- (void) onSpeakProgress:(int) progress beginPos:(int)beginPos endPos:(int)endPos
{
    
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

-(void)handleSingleTap:(UITapGestureRecognizer *)sender{
    CGPoint point = [sender locationInView:self.view];
    NSLog(@"handleSingleTap!pointx:%f,y:%f",point.x,point.y);
    
    NSString *x = [[NSString alloc]initWithFormat:@"%f",((point.x+_scrollview.contentOffset.x)/_backview.frame.size.width)*IMG_WIDTH];
    NSString *y = [[NSString alloc]initWithFormat:@"%f",((point.y+_scrollview.contentOffset.y)/_backview.frame.size.height)*IMG_HIGH];
    NSLog(@"%f , %f",_scrollview.contentOffset.x,_scrollview.contentOffset.y);
    NSLog(@"x= %@ , y= %@",x,y);
    [self requestnavigationpath:x locationY:y];
}

//当有一个或多个手指触摸事件在当前视图或window窗体中响应
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
    UITouch *touch = [allTouches anyObject];   //视图中的所有对象
    CGPoint point = [touch locationInView:[touch view]]; //返回触摸点在视图中的当前坐标
    int x = point.x;
    int y = point.y;
    NSLog(@"touch (x, y) is (%d, %d)", x, y);
    
    
}

- (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize {
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
      [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
       UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
       UIGraphicsEndImageContext();
        return scaledImage;
}
- (void)setChangePath:(NSArray *)pointArry
{
//    for (int i=0; i<pointArry.count-1; i++) {
//        
//        UIImageView *imageView = [self.backview viewWithTag:100+i];
//        imageView.frame = CGRectMake(0, 0, DEVICE_WIDTH*_scales, _high.constant*_scales);
//    }
}
- (void)setpath:(NSArray *)pointArry
{
    for (int i=0; i<_branch_num+1; i++) {
        UIImageView *img = [[UIImageView alloc]init];
        img = [self.backview viewWithTag:100+i];
        [img removeFromSuperview];
    }
    if (pointArry.count == 0) {
        return;
    }
//    self.backview.frame
    for (int i=0; i<pointArry.count-1; i++) {
        _branch_num =i;
        NSString *x = [[NSString alloc]initWithFormat:@"%@",pointArry[i][0]];
        NSString *y = [[NSString alloc]initWithFormat:@"%@",pointArry[i][1]];
        NSString *x1 = [[NSString alloc]initWithFormat:@"%@",pointArry[i+1][0]];
        NSString *y1 = [[NSString alloc]initWithFormat:@"%@",pointArry[i+1][1]];
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:self.backview.frame];
        imageView.tag =100+i;
        [self.backview addSubview:imageView];
         [self.backview bringSubviewToFront:_point];
        UIGraphicsBeginImageContext(imageView.frame.size);
        [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 10.0);  //线宽
        CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 40/255.0, 145/255.0, 250/255.0, 1.0);  //颜色
        CGContextBeginPath(UIGraphicsGetCurrentContext());
        
     
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), DEVICE_WIDTH*([x integerValue]/IMG_WIDTH)*1,_high.constant*([y integerValue]/IMG_HIGH)*1);  //起点坐标
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), DEVICE_WIDTH*([x1 integerValue]/IMG_WIDTH*1),_high.constant*([y1 integerValue]/IMG_HIGH)*1);   //终点坐标
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        imageView.image=UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
}
- (void)bannerStart{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] run];
}
- (void)updateTimer
{
    NSLog(@"当前线程：%@",[NSThread currentThread]);
    NSLog(@"启动RunLoop后--%@",[NSRunLoop currentRunLoop].currentMode);
    NSLog(@"currentRunLoop:%@",[NSRunLoop currentRunLoop]);
    dispatch_async(dispatch_get_main_queue(), ^{
//        NSLog(@"1");
    });
}
//告诉scrollview要缩放的是哪个子控件
 -(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
 return _backview;
}
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
{
    NSLog(@"%@",view);
    _point.hidden=YES;
}
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale
{
    _point.hidden=YES;
    NSLog(@"scale = %lf",scale);

    _scales = scale;
    //因为其始终以自身左上角为坐标原点，所以只能修改尺寸，修改位置不会改变
    CGRect tempBounds   = self.point.bounds;
    
    tempBounds.size.height=16*_scales;
    tempBounds.size.width=16*_scales;
    
    self.point.bounds=tempBounds;
//    self.point.layer.cornerRadius = 8*_scales;
    if(_point_arr.count)
    [self setChangePath:_point_arr];
    _hiddentime = 10000;
}

- (IBAction)start:(id)sender {
    _mCount=0;
//     self.point.layer.cornerRadius = 8*_scales;
    if (_point_arr.count == 0) {
        return;
    }
    //开启定时器
    [_timer setFireDate:[NSDate distantPast]];
//    self.map.transform = CGAffineTransformMakeRotation(M_PI_2);
}

- (void)timers:(NSTimer *)timer
{
  
   
    if (_point_arr.count == _mCount) {
        return;
    }
    
    NSArray *point = [[NSArray alloc]initWithArray:_point_arr[_mCount]];
    NSString *x =[[NSString alloc]initWithFormat:@"%@",point[0]];
    NSString *y =[[NSString alloc]initWithFormat:@"%@",point[1]];
    
    if ((_point_arr.count-1)>_mCount+2) {
        
        NSArray *point1 = [[NSArray alloc]initWithArray:_point_arr[_mCount+1]];
        NSString *x1 =[[NSString alloc]initWithFormat:@"%@",point1[0]];
        NSString *y1 =[[NSString alloc]initWithFormat:@"%@",point1[1]];
        
        NSArray *point2 = [[NSArray alloc]initWithArray:_point_arr[_mCount+2]];
        NSString *x2 =[[NSString alloc]initWithFormat:@"%@",point2[0]];
        NSString *y2 =[[NSString alloc]initWithFormat:@"%@",point2[1]];
        
        if ([x isEqualToString:x1] == 0 && [y1 isEqualToString:y2] == 0)
        {
            [SVProgressHUD dismiss];
            if ([x floatValue] < [x1 floatValue]) {
                if ([y1 floatValue] < [y2 floatValue]) {
                    NSLog(@"前方向右转");
                    //启动合成会话
                    [_iFlySpeechSynthesizer startSpeaking: @"前方向右转"];
                    [SVProgressHUD showImage:nil status:@"前方向右转"];
                }
                else
                {
                    NSLog(@"前方向左转");
                    [SVProgressHUD showImage:nil status:@"前方向左转"];
                    [_iFlySpeechSynthesizer startSpeaking: @"前方向左转"];
                }
            }
            else
            {
                if ([y1 floatValue] < [y2 floatValue]) {
                    NSLog(@"前方向左转");
                    [SVProgressHUD showImage:nil status:@"前方向左转"];
                    
                    [_iFlySpeechSynthesizer startSpeaking: @"前方向左转"];
                }
                else
                {
                    NSLog(@"前方向右转");
                    [SVProgressHUD showImage:nil status:@"前方向右转"];
                    
                    [_iFlySpeechSynthesizer startSpeaking: @"前方向右转"];
                }
            }
        }
        else if([x isEqualToString:x1] && [y1 isEqualToString:y2])
        {
            [SVProgressHUD dismiss];
            if ([y floatValue] < [y1 floatValue]) {
                if ([x1 floatValue] < [x2 floatValue]) {
                    NSLog(@"前方向左转");
                    [SVProgressHUD showImage:nil status:@"前方向左转"];
                    
                    [_iFlySpeechSynthesizer startSpeaking: @"前方向左转"];
                }
                else
                {
                    NSLog(@"前方向右转");
                    [SVProgressHUD showImage:nil status:@"前方向右转"];
                    
                    [_iFlySpeechSynthesizer startSpeaking: @"前方向右转"];
                }
            }
            else
            {
                if ([x1 floatValue] < [x2 floatValue]) {
                    NSLog(@"前方向右转");
                    [SVProgressHUD showImage:nil status:@"前方向右转"];
                    
                    [_iFlySpeechSynthesizer startSpeaking: @"前方向右转"];
                }
                else
                {
                    NSLog(@"前方向左转");
                    [SVProgressHUD showImage:nil status:@"前方向左转"];
                    
                    [_iFlySpeechSynthesizer startSpeaking: @"前方向左转"];
                }
            }

        }
    }
    
    CGPoint pointS = CGPointMake(DEVICE_WIDTH*([x integerValue]/IMG_WIDTH)*1,_high.constant*([y integerValue]/IMG_HIGH)*1);
    [self animateWith:pointS];
    _hiddentime++;
    if(_hiddentime == 10002)
    _point.hidden=NO;
    
    _mCount++;
}

//这里调用封装好的CABasic动画,传了一个参数用来指定position目的点
-(void)animateWith:(CGPoint )point {
    
    //NSNumber转化,可以将CGFloat等简单的数值转换成对象类型
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    //动画时间
    animation.duration = 1;
    //动画的起点和终点
    animation.fromValue = [NSValue valueWithCGPoint: self.point.layer.position];
    animation.toValue = [NSValue valueWithCGPoint:point];
    [self.point.layer addAnimation:animation forKey:@"动画名称"];
    //动画结束后把imageview的position改变到目的点
    self.point.layer.position = point;
    
    
}


//别忘了释放掉
-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

//获取路径
- (void)requestnavigationpath:(NSString*)locationX locationY:(NSString*)locationY{
    //        [self showLoadingTipWithMsg:@"登录中"];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           locationX,@"locationX",
                           locationY,@"locationY",
                           @"4c81a74e011cecad4262dba65c26960f",@"sign",
                           @"1504598086",@"ts",
                           @"ICETEST0-5F38-4A94-8F5F-78E38356557A",@"appID",
                           nil];
    NSLog(@"parm =%@",param);
    JF_WS(weakSelf);
    [JFHttpRequestTool getWithURL:@"https://ag.hfycloud.com/v1/navigation/path"  params:param success:^(id json) {
        if ([json[@"code"] intValue] == 0) {
            
            NSLog(@"json =%@",json);
            weakSelf.point_arr = [[NSArray alloc]initWithArray:json[@"content"]];
            weakSelf.mCount=0;
            weakSelf.point.frame =CGRectMake(0, 0, 16, 16);
            [weakSelf setpath:weakSelf.point_arr];
            //关闭定时器
            [weakSelf.timer setFireDate:[NSDate distantFuture]];
        }else {
            //            [self showInfoWithMsg:json[@"message"]];
        }
    } failure:^(NSError *error) {
        
    }];
}



- (UIView *)point
{
    if (!_point) {
        _point = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 16, 16)];
        _point.backgroundColor = [UIColor colorWithRed:31/255.0 green:195/255.0 blue:83/255.0 alpha:1];
        _point.layer.cornerRadius = 8;
        _point.layer.masksToBounds=YES;
    }
    return _point;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//强制转屏
- (void)interfaceOrientation:(UIInterfaceOrientation)orientation
{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector  = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = orientation;
        // 从2开始是因为0 1 两个参数已经被selector和target占用
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

//支持旋转
-(BOOL)shouldAutorotate{
    return YES;
}
//
//支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscapeLeft;
}

//一开始的方向  很重要
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationLandscapeLeft;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
