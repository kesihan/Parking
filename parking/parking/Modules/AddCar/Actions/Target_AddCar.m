//
//  Target_AddCar.m
//  parking
//
//  Created by Robert Xu on 2017/5/25.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "Target_AddCar.h"
#import "AddCarController.h"

@implementation Target_AddCar

- (UIViewController *)Action_addCarController:(NSDictionary *)params {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:NSStringFromClass([AddCarController class]) bundle:nil];
    
    //使用instantiateInitialViewController实例化SB中被设置为Is Initial View Controller的控制器
    UIViewController *carController = (UIViewController *)[storyboard instantiateInitialViewController];
    return carController;
    
}

@end
