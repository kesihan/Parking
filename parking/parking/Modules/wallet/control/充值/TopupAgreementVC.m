//
//  TopupAgreementVC.m
//  mat
//
//  Created by 柯思汉 on 17/7/14.
//  Copyright © 2017年 hfy. All rights reserved.
//

#import "TopupAgreementVC.h"

@interface TopupAgreementVC ()
@property (strong, nonatomic) IBOutlet UIView *baceview;

@end

@implementation TopupAgreementVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"充值协议";
    _baceview.layer.cornerRadius=5;
    _baceview.layer.masksToBounds=YES;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
