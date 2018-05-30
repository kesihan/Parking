//
//  Target_ParkingDetail.m
//  parking
//
//  Created by Robert Xu on 2017/5/23.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "Target_ParkingDetail.h"
#import "ParkingDetailController.h"

@implementation Target_ParkingDetail

- (UIViewController *)Action_parkingDetailController:(NSDictionary *)params {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:NSStringFromClass([ParkingDetailController class]) bundle:nil];
    
    //使用instantiateInitialViewController实例化SB中被设置为Is Initial View Controller的控制器
    ParkingDetailController *parkingDetailController = (ParkingDetailController *)[storyboard instantiateInitialViewController];
    parkingDetailController.detail = params[@"detail"];
    return parkingDetailController;
    
}

@end
