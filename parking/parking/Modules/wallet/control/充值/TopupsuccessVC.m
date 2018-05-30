//
//  TopupsuccessVC.m
//  mat
//
//  Created by 柯思汉 on 17/7/14.
//  Copyright © 2017年 hfy. All rights reserved.
//

#import "TopupsuccessVC.h"
//#import "ShareView.h"

@interface TopupsuccessVC ()
//@property (nonatomic,strong)ShareView *shareview;
@end

@implementation TopupsuccessVC
- (void)viewWillAppear:(BOOL)animated
{
    if(_is_pay)
    self.navigationItem.title=@"支付成功";
    else
        self.navigationItem.title=@"充值成功";
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"后退"] style:UIBarButtonItemStylePlain target:self action:@selector(returnAction)];
    // Do any additional setup after loading the view from its nib.
}
#pragma mark - action handle
- (void)returnAction
{
    
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
}
- (IBAction)complete:(id)sender {
//    [self.view.window addSubview:self.shareview];
}
//- (ShareView*)shareview
//{
//    if (!_shareview) {
//        _shareview = [[ShareView alloc]init];
//        JF_WS(weakSelf);
//        _shareview.block =^(NSInteger index)
//        {
//            if (index == 0) {
//                weakSelf.shareview.hidden = YES;
//            }
//
//        };
//    }
//    _shareview.hidden=NO;
//    return _shareview;
//}
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [self.shareview removeFromSuperview];
//}
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
