//
//  PaySuccessVC.m
//  parking
//
//  Created by 柯思汉 on 17/9/13.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "PaySuccessVC.h"

@interface PaySuccessVC ()

@end

@implementation PaySuccessVC
- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    UIBarButtonItem *colseItem = [[UIBarButtonItem alloc] initWithCustomView:[[UIButton alloc] init]];
    self.navigationItem.leftBarButtonItem = colseItem;

    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
    [btn setTitle:@"完成" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:0 green:109/255.0 blue:1 alpha:1] forState:UIControlStateNormal];
    [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = barButtonItem;
}
- (void)back {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)backhomevc:(id)sender {
    [self back];
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
