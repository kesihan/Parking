//
//  COLBaseController.m
//  parking
//
//  Created by Robert Xu on 2017/5/19.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "COLBaseController.h"

@interface COLBaseController ()

@end

@implementation COLBaseController

#pragma makr - Actions

//通过present方式显示的VC不会存入self.navigationController.viewControllers数组中；而通过push方式显示的VC会存在该数组的最后
- (void)dismissAction:(id)sender {
    if (self.navigationController.topViewController == self) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //修改控制器标题文字字体、颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang-SC-Regular" size:18.0], NSForegroundColorAttributeName: UIColorFromRGB(0x111111)}];
    //当文字为白色，需要通知时设置下面
    //self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    //还原
    //self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    
    //修改返回按钮
    UIImage *selectedImage = [[UIImage imageNamed:@"common_icon_arrow_nor"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *itemleft = [[UIBarButtonItem alloc] initWithImage:selectedImage style:UIBarButtonItemStylePlain target:self action:@selector(dismissAction:)];
    self.navigationItem.leftBarButtonItem = itemleft;
    
    
    //设置顶部导航条背景图片
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
    //还原
    //[self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
    //设置隐藏顶部导航条底部白色阴影线条
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    //还原
    //[self.navigationController.navigationBar setShadowImage:nil];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
