//
//  Target_QA.m
//  parking
//
//  Created by Robert Xu on 2017/5/25.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "Target_QA.h"
#import "QAController.h"

@implementation Target_QA

- (UIViewController *)Action_qaController:(NSDictionary *)params {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:NSStringFromClass([QAController class]) bundle:nil];
    
    //使用instantiateInitialViewController实例化SB中被设置为Is Initial View Controller的控制器
    UIViewController *qaController = (UIViewController *)[storyboard instantiateInitialViewController];
    return qaController;
    
}

@end
