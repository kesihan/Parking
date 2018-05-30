//
//  UIViewController+Swizzling.m
//  parking
//
//  Created by Robert Xu on 2017/5/26.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "UIViewController+Swizzling.h"
#import "NSObject+Swizzling.h"
#import "UIImage+Helper.h"

@implementation UIViewController (Swizzling)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self methodSwizzlingWithOriginalSelector:@selector(viewDidLoad) bySwizzledSelector:@selector(sure_viewDidLoad)];
    });
}

- (void)sure_viewDidLoad {
    [self sure_viewDidLoad];
    
    // 添加自定义的方法
    //修改控制器标题文字字体、颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang-SC-Regular" size:18.0], NSForegroundColorAttributeName: UIColorFromRGB(0x111111)}];
    //当文字为白色，需要通知时设置下面
    //self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    //修改返回按钮
    UIImage *selectedImage = [[UIImage imageNamed:@"common_icon_arrow_nor"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //是否自定义返回执行方法
    SEL returnAction = @selector(dismissAction:);
    if ([self respondsToSelector:@selector(customReturnAction:)]) {
        returnAction = @selector(customReturnAction:);
    }
    
    UIBarButtonItem *itemleft = [[UIBarButtonItem alloc] initWithImage:selectedImage style:UIBarButtonItemStylePlain target:self action:returnAction];
    self.navigationItem.leftBarButtonItem = itemleft;
    
    //设置隐藏顶部导航条底部白色阴影线条
    //设置导航栏背景为白色
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithBgColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self.navigationController.navigationBar setTintColor:UIColorFromRGB(0x111111)];
}

//通过present方式显示的VC不会存入self.navigationController.viewControllers数组中；而通过push方式显示的VC会存在该数组的最后
- (void)dismissAction:(id)sender {
    if (self.navigationController.topViewController == self) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
