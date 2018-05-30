//
//  Target_About.m
//  parking
//
//  Created by Robert Xu on 2017/5/25.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "Target_About.h"
#import "AboutController.h"
#import "AboutCreditController.h"

@implementation Target_About

- (UIViewController *)Action_aboutController:(NSDictionary *)params {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:NSStringFromClass([AboutController class]) bundle:nil];
    
    //使用instantiateInitialViewController实例化SB中被设置为Is Initial View Controller的控制器
    UIViewController *aboutController = (UIViewController *)[storyboard instantiateInitialViewController];
    return aboutController;
    
}

- (UIViewController *)Action_aboutCreditController:(NSDictionary *)params {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:NSStringFromClass([AboutCreditController class]) bundle:nil];
    
    //使用instantiateInitialViewController实例化SB中被设置为Is Initial View Controller的控制器
    UIViewController *aboutCreditController = (UIViewController *)[storyboard instantiateInitialViewController];
    return aboutCreditController;
    
}

@end
