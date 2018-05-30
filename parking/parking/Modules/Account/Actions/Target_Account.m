//
//  Target_Account.m
//  parking
//
//  Created by Robert Xu on 2017/5/23.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "Target_Account.h"
#import "AccountController.h"

@implementation Target_Account

- (UIViewController *)Action_accountController:(NSDictionary *)params {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:NSStringFromClass([AccountController class]) bundle:nil];
    
    //使用instantiateInitialViewController实例化SB中被设置为Is Initial View Controller的控制器
    UIViewController *accountController = (UINavigationController *)[storyboard instantiateInitialViewController];
    return accountController;
    
}

@end
