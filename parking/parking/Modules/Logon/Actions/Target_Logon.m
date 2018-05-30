//
//  Target_Logon.m
//  parking
//
//  Created by Robert Xu on 2017/5/18.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "Target_Logon.h"
#import "LogonController.h"

@implementation Target_Logon

- (UIViewController *)Action_logonController:(NSDictionary *)params {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:NSStringFromClass([LogonController class]) bundle:nil];
    
    //使用instantiateInitialViewController实例化SB中被设置为Is Initial View Controller的控制器
    UINavigationController *logonController = (UINavigationController *)[storyboard instantiateInitialViewController];
    return logonController;
    
}

@end
