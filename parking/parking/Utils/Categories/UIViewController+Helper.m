//
//  UIViewController+Helper.m
//  parking
//
//  Created by Robert Xu on 2017/5/27.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "UIViewController+Helper.h"
#import "UIImage+Helper.h"

@implementation UIViewController (Helper)

//viewWillAppear
- (void)setWhiteTitleStyle {
    // 添加自定义的方法
    //修改控制器标题文字字体、颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName: COL_DefaultFont_Size(18.0f), NSForegroundColorAttributeName: [UIColor whiteColor]}];
    //当文字为白色，需要通知时设置下面
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    //修改返回按钮
    UIImage *selectedImage = [[UIImage imageNamed:@"common_icon_arrow_white"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *itemleft = [[UIBarButtonItem alloc] initWithImage:selectedImage style:UIBarButtonItemStylePlain target:self action:@selector(dismissAction:)];
    self.navigationItem.leftBarButtonItem = itemleft;
    
    //设置隐藏顶部导航条底部白色阴影线条
    //设置导航栏背景为白色
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithBgColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

//viewWillDisappear
- (void)setDefaultTitleStyle {
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName: COL_DefaultFont_Size(18.0f), NSForegroundColorAttributeName: UIColorFromRGB(0x111111)}];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    
    //修改返回按钮
    UIImage *selectedImage = [[UIImage imageNamed:@"common_icon_arrow_nor"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *itemleft = [[UIBarButtonItem alloc] initWithImage:selectedImage style:UIBarButtonItemStylePlain target:self action:@selector(dismissAction:)];
    self.navigationItem.leftBarButtonItem = itemleft;
    
    //设置隐藏顶部导航条底部白色阴影线条
    //设置导航栏背景为白色
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithBgColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

#pragma mark - action

- (void)dismissAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
