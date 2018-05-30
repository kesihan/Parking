//
//  Target_Identity.m
//  parking
//
//  Created by Robert Xu on 2017/5/19.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "Target_Identity.h"
#import "IdentityController.h"
#import "IdentityStatusController.h"

@implementation Target_Identity

- (UIViewController *)Action_identityController:(NSDictionary *)params {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:NSStringFromClass([IdentityController class]) bundle:nil];
    
    //使用instantiateInitialViewController实例化SB中被设置为Is Initial View Controller的控制器
    UIViewController *identityController = (UINavigationController *)[storyboard instantiateInitialViewController];
    return identityController;
    
}

- (UIViewController *)Action_identityStatusController:(NSDictionary *)params {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:NSStringFromClass([IdentityStatusController class]) bundle:nil];
    
    //使用instantiateInitialViewController实例化SB中被设置为Is Initial View Controller的控制器
    UIViewController *identityStatusController = (UINavigationController *)[storyboard instantiateInitialViewController];
    return identityStatusController;
    
}

@end
