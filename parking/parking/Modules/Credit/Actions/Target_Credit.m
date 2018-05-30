//
//  Target_Credit.m
//  parking
//
//  Created by Robert Xu on 2017/5/24.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "Target_Credit.h"
#import "CreditController.h"

@implementation Target_Credit

- (UIViewController *)Action_creditController:(NSDictionary *)params {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:NSStringFromClass([CreditController class]) bundle:nil];
    
    //使用instantiateInitialViewController实例化SB中被设置为Is Initial View Controller的控制器
    UIViewController *creditController = (UINavigationController *)[storyboard instantiateInitialViewController];
    return creditController;
    
}

@end
