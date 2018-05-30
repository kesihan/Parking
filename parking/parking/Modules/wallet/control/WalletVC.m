//
//  WalletVC.m
//  parking
//
//  Created by 柯思汉 on 2018/2/24.
//  Copyright © 2018年 huafangcloud. All rights reserved.
//

#import "WalletVC.h"
#import "COLMediator+Credit.h"
#import "GotoprepaidVC.h"
#import "BalanceVC.h"
#import <AFNetworking.h>
#import "JFHttpRequestTool.h"

@interface WalletVC ()
@property (strong, nonatomic) IBOutlet UILabel *allmoney;
@property (strong, nonatomic) IBOutlet UILabel *score;

@end

@implementation WalletVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    // Do any additional setup after loading the view from its nib.
}
- (void)setUI
{
    [self setWhiteTitleStyle];
    self.navigationItem.title = @"我的钱包";
    [self requestAllmoney];
    [self getScore];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [self setDefaultTitleStyle];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)FindScore:(id)sender {
    BalanceVC *control = [[BalanceVC alloc]initWithNibName:@"BalanceVC" bundle:nil];
    [self.navigationController pushViewController:control animated:YES];
}
- (IBAction)points:(id)sender {
    [self.navigationController pushViewController:[[COLMediator sharedInstance] creditController] animated:YES];
}

- (IBAction)immediately:(id)sender {
    GotoprepaidVC *control = [[GotoprepaidVC alloc]initWithNibName:@"GotoprepaidVC" bundle:nil];
    [self.navigationController pushViewController:control animated:YES];
}
- (void)requestAllmoney;
{
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           [AccountService userModel].id,@"userID",
                           @"1520239994",@"ts",
                           @"17890fae0e09ed9197ee0f552c435c2a",@"sign",
                           COLAGRequestAppID,@"appID",
                           nil];
    
    NSLog(@"parm =%@",param);
//    JF_WS(weakSelf);
    [JFHttpRequestTool getWithURL:[[NSString alloc]initWithFormat:@"%@/v1/user/debugging/allmoney",COLAGBaseURL]  params:param success:^(id json) {
        NSLog(@"%@",json[@"message"]);
        if ([json[@"code"] intValue] == 0) {
            
            NSLog(@"json =%@",json);
            self.allmoney.text = [[NSString alloc]initWithFormat:@"¥%@",json[@"content"][0][@"money"]];
        }else {
            //         [self showInfoWithMsg:json[@"message"]];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)getScore
{
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           [AccountService userModel].id,@"userID",
                           @"1",@"pageIndex",
                           @"10",@"size",
                           @"1520239994",@"ts",
                           @"17890fae0e09ed9197ee0f552c435c2a",@"sign",
                           COLAGRequestAppID,@"appID",
                           nil];
    
    NSLog(@"parm =%@",param);
    //    JF_WS(weakSelf);
    [JFHttpRequestTool getWithURL:[[NSString alloc]initWithFormat:@"%@/v1/user/home/integral",COLAGBaseURL]  params:param success:^(id json) {
        NSLog(@"%@",json[@"message"]);
        if ([json[@"code"] intValue] == 0) {
            
            NSLog(@"json =%@",json);
            self.score.text = [[NSString alloc]initWithFormat:@"%@分",json[@"content"][@"total"]];
        }else {
            //         [self showInfoWithMsg:json[@"message"]];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

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
