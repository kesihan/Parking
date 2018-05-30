//
//  Target_Car.m
//  parking
//
//  Created by Robert Xu on 2017/5/24.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "Target_Car.h"
#import "CarController.h"

@implementation Target_Car

- (UIViewController *)Action_carController:(NSDictionary *)params {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:NSStringFromClass([CarController class]) bundle:nil];
    
    //使用instantiateInitialViewController实例化SB中被设置为Is Initial View Controller的控制器
    UIViewController *carController = (UIViewController *)[storyboard instantiateInitialViewController];
    return carController;
    
}


@end
