//
//  Target_My.m
//  parking
//
//  Created by Robert Xu on 2017/5/18.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "Target_My.h"
#import "MyController.h"

@implementation Target_My

- (UIViewController *)Action_myController:(NSDictionary *)params {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:NSStringFromClass([MyController class]) bundle:nil];
    
    //使用instantiateInitialViewController实例化SB中被设置为Is Initial View Controller的控制器
    UIViewController *myController = (UIViewController *)[storyboard instantiateInitialViewController];
    return myController;
    
}

@end
