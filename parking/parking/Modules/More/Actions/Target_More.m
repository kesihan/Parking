//
//  Target_More.m
//  parking
//
//  Created by Robert Xu on 2017/5/19.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "Target_More.h"
#import "MoreController.h"

@implementation Target_More

- (UIViewController *)Action_moreController:(NSDictionary *)params {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:NSStringFromClass([MoreController class]) bundle:nil];
    
    //使用instantiateInitialViewController实例化SB中被设置为Is Initial View Controller的控制器
    UIViewController *moreController = (UINavigationController *)[storyboard instantiateInitialViewController];
    return moreController;
    
}

@end
