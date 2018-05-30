//
//  LogonController.m
//  parking
//
//  Created by Robert Xu on 2017/5/18.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "LogonController.h"

//Mediator
#import "COLMediator+Identity.h"
//Presenters
#import "LogonPresenter.h"

#import "UIImage+Helper.h"
#import "UITextField+Helper.h"
#import "JKCountDownButton.h"
#import "JFHttpRequestTool.h"
#import "JPUSHService.h"
#import "HomeController.h"
@interface LogonController () <LogonPresenterDelegate>

@property (strong, nonatomic) LogonPresenter *logonPresenter;

@property (weak, nonatomic) IBOutlet UITextField *phoneInput;
@property (weak, nonatomic) IBOutlet UITextField *verifyInput;
@property (weak, nonatomic) IBOutlet JKCountDownButton *verifyButton;

@end

@implementation LogonController

#pragma mark - IBOutlet

- (IBAction)loginAction:(id)sender {
    
    [self.logonPresenter loginWithMobile:_phoneInput.text verify:_verifyInput.text];
}

- (IBAction)countDownAction:(JKCountDownButton *)sender {
    sender.enabled = NO;
    //button type要 设置成custom 否则会闪动
    [sender startCountDownWithSecond:60];
    
    [sender countDownChanging:^NSString *(JKCountDownButton *countDownButton,NSUInteger second) {
        NSString *title = [NSString stringWithFormat:@"剩余%zd秒",second];
        return title;
    }];
    [sender countDownFinished:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
        countDownButton.enabled = YES;
        return @"获取验证码";
        
    }];
    
    [self.logonPresenter sendSMSToMobile:self.phoneInput.text];
}

#pragma mark - LogonPresenterDelegate

- (void)sendSMSSuccess:(BOOL)sucess {
    if (!sucess) {
        [COLToast showToast:@"服务器出错..."];
    }
}

- (void)logonSuccess:(BOOL)success message:(NSString *)message userModel:(UserModel *)userModel {
//    NSString *userID = [AccountService userModel].id
    if (success) {
        //存储用户信息并跳转
        [COLToast showToast:@"登录成功"];
        

        [self.navigationController popToRootViewControllerAnimated:YES];
        
        [self requestpushregister];
        
    } else {
        [COLToast showToast:@"发生错误了..."];
    }
}

//绑定极光推送
- (void)requestpushregister{
    //        [self showLoadingTipWithMsg:@"登录中"];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           [AccountService userModel].id,@"uid",
                           @"车",@"alias",
                           [JPUSHService registrationID],@"registrationID",
                           @"park",@"type",
                           @"118.2000",@"lng",
                           @"24.5",@"lat",
                           @"e94292ceafa88e6850ca32e3a936de1c",@"sign",
                           @"1505465177",@"ts",
                           @"ICETEST0-5F38-4A94-8F5F-78E38356557A",@"appID",
                           nil];
    NSLog(@"parm =%@",param);
    JF_WS(weakSelf);
    [JFHttpRequestTool postWithURL:@"https://ag.hfycloud.com/v1/push/register"  params:param success:^(id json) {
        if ([json[@"code"] intValue] == 0) {
            
            NSLog(@"json =%@",json);
            [weakSelf.navigationController pushViewController:[[COLMediator sharedInstance] identityController] animated:YES];
        }else {
//            [self showInfoWithMsg:json[@"message"]];
        }
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setWhiteTitleStyle];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self setDefaultTitleStyle];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_logonPresenter detachView];
}

#pragma mark - getter and setter



#pragma mark - setup {

- (void)setup {
    [self.phoneInput setPlaceholderColor:UIColorFromRGB(0xC4C3C3) font:COL_DefaultFont_Size(15.0f)];
    [self.verifyInput setPlaceholderColor:UIColorFromRGB(0xC4C3C3) font:COL_DefaultFont_Size(15.0f)];
    
    self.logonPresenter = [[LogonPresenter alloc] initWithService:[[AccountService alloc] init]];
    [self.logonPresenter attachView:self];
}

@end
