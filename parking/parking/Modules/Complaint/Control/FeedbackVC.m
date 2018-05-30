//
//  FeedbackVC.m
//  mat
//
//  Created by 柯思汉 on 17/7/10.
//  Copyright © 2017年 hfy. All rights reserved.
//

#import "FeedbackVC.h"
#import "GeneralCell.h"
//#import "PostUserFeedbackImageApi.h"

@interface FeedbackVC ()<UITextFieldDelegate,UITextViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate,UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) IBOutlet UIButton *img;
@property (strong, nonatomic) IBOutlet UIButton *img1;
@property (strong, nonatomic) IBOutlet UIButton *img2;
@property (strong, nonatomic) IBOutlet UIButton *chose;
@property (strong, nonatomic) IBOutlet UIButton *chose1;
@property (strong, nonatomic) IBOutlet UIButton *chose2;

@property (nonatomic,strong)NSMutableArray *img_url;
@property (strong, nonatomic)UIImage *image;
@property (nonatomic,assign)int indexs;
@property (nonatomic,strong)NSMutableArray *pickarry;
@property (strong, nonatomic) IBOutlet UITextView *textview;
@property (nonatomic,strong) UIButton *selectbtn;
@property (nonatomic,strong) NSString *contentType;
@end

@implementation FeedbackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
        // Do any additional setup after loading the view from its nib.
}
- (void)setUI
{
    self.navigationItem.title=@"意见反馈";
    _scrollView.showsVerticalScrollIndicator = FALSE;
    _scrollView.showsHorizontalScrollIndicator = FALSE;
    _img1.hidden=YES;
    _img2.hidden=YES;
    _chose.hidden=YES;
    _chose1.hidden=YES;
    _chose2.hidden=YES;
    _textview.delegate=self;
    _img_url =[[NSMutableArray alloc]initWithObjects:@"删除",@"删除",@"删除",@"删除",@"删除",@"删除", nil];
    _indexs=0;

}
#pragma mark- TextView代理
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView;
{
    _textview.text=@"";
    _textview.textColor=[UIColor blackColor];
    //    [textView resignFirstResponder];
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView;
{
    if (_textview.text.length>500) {
        _textview.text=[_textview.text substringToIndex:500];
    }
    _DescribeLe.text=[[NSString alloc]initWithFormat:@"%ld/500",textView.text.length];
    _viewhigh.constant =800;
}
- (void)textViewDidEndEditing:(UITextView *)textView;
{
    _viewhigh.constant =700;
}
#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;
{
    NSLog(@"info = %@",info);
    
    //    UIImagePickerControllerEditedImage 编辑图片
    //    UIImagePickerControllerOriginalImage 原始图片
    _image = [info objectForKey:UIImagePickerControllerEditedImage];
    _image =[self getSubImage:_image mCGRect:CGRectMake(0, 0,(DEVICE_WIDTH/190)*_image.size.height, _image.size.height) centerBool:YES];
    
    if (_indexs==0) {
        _chose.hidden=NO;
        [_img setImage:_image forState:UIControlStateNormal];
    }
    else if (_indexs==1) {
        _chose1.hidden=NO;
        [_img1 setImage:_image forState:UIControlStateNormal];
    }
    else if (_indexs==2) {
        _chose2 .hidden=NO;
        [_img2 setImage:_image forState:UIControlStateNormal];
    }
    NSLog(@"image =%@",_image);
    [self reloadPicture:_image];
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(UIImage*)getSubImage:(UIImage *)image mCGRect:(CGRect)mCGRect centerBool:(BOOL)centerBool
{
    
    /*如若centerBool为Yes则是由中心点取mCGRect范围的图片*/
    
    
    float imgwidth = image.size.width;
    float imgheight = image.size.height;
    float viewwidth = mCGRect.size.width;
    float viewheight = mCGRect.size.height;
    CGRect rect;
    if(centerBool)
        rect = CGRectMake((imgwidth-viewwidth)/2, (imgheight-viewheight)/2, viewwidth, viewheight);
    else{
        if (viewheight < viewwidth) {
            if (imgwidth <= imgheight) {
                rect = CGRectMake(0, 0, imgwidth, imgwidth*viewheight/viewwidth);
            }else {
                float width = viewwidth*imgheight/viewheight;
                float x = (imgwidth - width)/2 ;
                if (x > 0) {
                    rect = CGRectMake(x, 0, width, imgheight);
                }else {
                    rect = CGRectMake(0, 0, imgwidth, imgwidth*viewheight/viewwidth);
                }
            }
        }else {
            if (imgwidth <= imgheight) {
                float height = viewheight*imgwidth/viewwidth;
                if (height < imgheight) {
                    rect = CGRectMake(0, 0, imgwidth, height);
                }else {
                    rect = CGRectMake(0, 0, viewwidth*imgheight/viewheight, imgheight);
                }
            }else {
                float width = viewwidth*imgheight/viewheight;
                if (width < imgwidth) {
                    float x = (imgwidth - width)/2 ;
                    rect = CGRectMake(x, 0, width, imgheight);
                }else {
                    rect = CGRectMake(0, 0, imgwidth, imgheight);
                }
            }
        }
    }
    
    CGImageRef subImageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    
    return smallImage;
}

#pragma mark- UIUIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 888) {
        if (buttonIndex == 0)
        { //全部
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            //    [self.navigationController pushViewController:tag animated:YES];
            [self presentViewController:imagePicker animated:YES completion:^{
                
            }];
        }
        else if (buttonIndex ==1)
        {
            
            [self snapImage];
        }
    }
}
//拍照
- (void) snapImage{
    UIImagePickerController *ipc=[[UIImagePickerController alloc] init];
    ipc.sourceType=UIImagePickerControllerSourceTypeCamera;
    ipc.delegate=self;
    ipc.allowsEditing=YES;
    [self presentViewController:ipc animated:YES completion:^{
        
    }];
    
    //    [self presentModalViewController:ipc animated:YES];
    
}
#pragma mark 上传图片
- (IBAction)imgs:(UIButton *)sender {
    if ([_img_url[0] isEqualToString:@"删除"]==0) {
        return;
    }
    _indexs=0;
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册", @"拍照", nil];
    sheet.tag = 888;
    [sheet showInView:self.view];
}
- (IBAction)imgs1:(UIButton*)sender {
    if ([_img_url[1]isEqualToString:@"删除"]==0) {
        return;
    }
    
    _indexs=1;
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册", @"拍照", nil];
    sheet.tag = 888;
    [sheet showInView:self.view];
}
- (IBAction)imgs2:(UIButton*)sender {
    if ([_img_url[2]isEqualToString:@"删除"]==0) {
        return;
    }
    
    _indexs=2;
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册", @"拍照", nil];
    sheet.tag = 888;
    [sheet showInView:self.view];
}
- (IBAction)chos:(UIButton *)sender {
    sender.hidden=YES;

    [_img_url replaceObjectAtIndex:0 withObject:@"删除"];
    [self sort_image];
}
- (IBAction)chos1:(UIButton*)sender {
    sender.hidden=YES;
    //    [_img_btn setImage:[UIImage imageNamed:@"addPic"] forState:UIControlStateNormal];
    [_img_url replaceObjectAtIndex:1 withObject:@"删除"];
    [self sort_image];
}
- (IBAction)chos2:(UIButton *)sender {
    sender.hidden=YES;
    //    [_img_btn setImage:[UIImage imageNamed:@"addPic"] forState:UIControlStateNormal];
    [_img_url replaceObjectAtIndex:2 withObject:@"删除"];
    [self sort_image];
}
- (void)sort_image
{
    _chose1.hidden=YES;
    _chose2.hidden=YES;
    _chose.hidden=YES;
    _img1.hidden=YES;
    _img2.hidden=YES;
    NSMutableArray *img =[NSMutableArray array];
    for (int i=0; i<_img_url.count; i++) {
        if ([_img_url[i] isKindOfClass:[UIImage class]]) {
            if (i==0) {
                [img addObject:_img.imageView.image];
            }
            else if (i==1) {
                [img addObject:_img1.imageView.image];
            }
            else if (i==2) {
                [img addObject:_img2.imageView.image];
            }
        }
    }
    [_img_url removeObjectsInArray:@[@"删除"]];
    [_img_url addObject:@"删除"];
    [_img_url addObject:@"删除"];
    [_img_url addObject:@"删除"];
    [_img_url addObject:@"删除"];
    [_img_url addObject:@"删除"];
    [_img_url addObject:@"删除"];
    [_img_url addObject:@"删除"];
    [_img_url addObject:@"删除"];
    [_img setImage:[UIImage imageNamed:@"添加照片"] forState:UIControlStateNormal];
    [_img1 setImage:[UIImage imageNamed:@"添加照片"] forState:UIControlStateNormal];
    [_img2 setImage:[UIImage imageNamed:@"添加照片"] forState:UIControlStateNormal];
    for (int i=0; i<img.count; i++) {
        if (i==0) {
            [_img setImage:img[i] forState:UIControlStateNormal];
            _chose.hidden=NO;
            _img1.hidden=NO;
        }
        if (i==1) {
            [_img1 setImage:img[i] forState:UIControlStateNormal];
            _chose1.hidden=NO;
            _img2.hidden=NO;
        }
        if (i==3) {
            [_img2 setImage:img[i] forState:UIControlStateNormal];
            _chose2.hidden=NO;
        }
    }
}

- (void)reloadPicture:(UIImage *)img
{
    if (_indexs == 0) {
        
        _img.hidden = NO;
        _chose.hidden = NO;
        _img1.hidden = NO;
        [_img_url replaceObjectAtIndex:0 withObject:img];
        
    }
    else if (_indexs == 1) {
        _img.hidden = NO;
        _chose.hidden = NO;
        _img1.hidden = NO;
        _chose1.hidden = NO;
        _img2.hidden = NO;
        [_img_url replaceObjectAtIndex:1 withObject:img];
    }
    else if (_indexs == 2)
    {
        _img.hidden = NO;
        _chose.hidden = NO;
        _img1.hidden = NO;
        _chose1.hidden = NO;
        _img2.hidden = NO;
        _chose2.hidden = NO;
        [_img_url replaceObjectAtIndex:2 withObject:img];
    }

}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}
- (CGFloat)tableView:(UITableView* )tableView heightForRowAtIndexPath:(NSIndexPath* )indexPath{
    
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return cell.frame.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GeneralCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GeneralCell"];
    
    if (!cell)
    {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"GeneralCell" owner:self options:nil]lastObject];
    }
    if(indexPath.row==0)
    cell.lb_text.text =@"离场了还在计费";
    else if(indexPath.row==1)
        cell.lb_text.text =@"收费规则错误，多收取停车费";
    else if(indexPath.row==2)
        cell.lb_text.text =@"进出场时间错误";
    else if(indexPath.row==3)
        cell.lb_text.text =@"其他";
    [cell.btn setImage:nil forState:UIControlStateNormal];
    cell.btn.tag = 666+indexPath.row;
    [cell.btn setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateSelected];
    [cell.btn addTarget:self action:@selector(chose:) forControlEvents:UIControlEventTouchDown];
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return  cell;
    
}
- (void)chose:(UIButton *)sender
{
//    ‘other其他’,’scan扫描不启动问题’,’breakage护理损坏问题’,’improve用户建议’
    NSInteger row =sender.tag-666;
    if (row == 0 || row == 1 || row == 2 || row ==3) {
        self.contentType =@"improve用户建议";
    }
    else if (row == 4){
        self.contentType =@"breakage护理损坏问题";
    }
    else
        self.contentType = @"other其他";
    
    sender.selected=!sender.selected;
    
    self.selectbtn.selected = NO;
    
    self.selectbtn =sender;
}
- (IBAction)submit:(id)sender {
    
//    [self requestPostUserFeedbackImageApi];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//- (void)requestPostUserFeedbackImageApi
//{
//    if (self.contentType.length==0) {
//        [self showErrorWithMsg:@"请选择类型"];
//        return;
//    }
// 
//    
//    [_img_url removeObjectsInArray:@[@"删除"]];
//    
//    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
//    config.baseUrl = YTKUploadImageURL;
//    
//    PostUserFeedbackImageApi *post = [[PostUserFeedbackImageApi alloc] initWithImage:self.img_url userID:[UserData getUserInfo][@"id"] content:_textview.text contentType:self.contentType];
//
//    [post sk_startWithWithSuccessBlock:^(YTKBaseRequest *request) {
//        
//        NSLog(@"%@",request.responseJSONObject);
//        config.baseUrl = YTKBASEURL;
//        [self showSuccessWithMsg:@"成功提交反馈"];
//        [self.navigationController popViewControllerAnimated:YES];
//    } errorBlock:^(YTKBaseRequest *request) {
//        config.baseUrl = YTKBASEURL;
//       [self showSuccessWithMsg:@"提交反馈失败"];
//    } failureBlock:^(NSString *message) {
//        config.baseUrl = YTKBASEURL;
//
//    }];
//    
//}

- (UIButton *)selectbtn
{
    if (!_selectbtn) {
        _selectbtn =[[UIButton alloc]init];
    }
    return _selectbtn;
}
- (NSString *)contentType
{
    if (!_contentType) {
        _contentType =[[NSString alloc]init];
    }
    return _contentType;
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
