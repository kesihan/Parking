//
//  Target_Home.m
//  parking
//
//  Created by Robert Xu on 2017/5/18.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "Target_Home.h"
#import "HomeController.h"
#import "HomeNaviController.h"

@implementation Target_Home

- (UIViewController *)Action_homeController:(NSDictionary *)params {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:NSStringFromClass([HomeController class]) bundle:nil];
    
    //使用instantiateInitialViewController实例化SB中被设置为Is Initial View Controller的控制器
    UINavigationController *homeNaviController = (UINavigationController *)[storyboard instantiateInitialViewController];
    return homeNaviController.topViewController;
    
}

- (UIViewController *)Action_homeNaviController:(NSDictionary *)params {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:NSStringFromClass([HomeNaviController class]) bundle:nil];
    
    //使用instantiateInitialViewController实例化SB中被设置为Is Initial View Controller的控制器
    HomeNaviController *homeNaviController = [storyboard instantiateInitialViewController];
    homeNaviController.start = (CLLocation *)params[@"start"];
    homeNaviController.end = (CLLocation *)params[@"end"];
    return homeNaviController;
}

@end
