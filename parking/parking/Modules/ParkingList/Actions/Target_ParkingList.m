//
//  Target_ParkingList.m
//  parking
//
//  Created by Robert Xu on 2017/5/19.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "Target_ParkingList.h"
#import "ParkingListController.h"

@implementation Target_ParkingList

- (UIViewController *)Action_parkingListController:(NSDictionary *)params {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:NSStringFromClass([ParkingListController class]) bundle:nil];
    
    //使用instantiateInitialViewController实例化SB中被设置为Is Initial View Controller的控制器
    ParkingListController *parkingListController = (ParkingListController *)[storyboard instantiateInitialViewController];
    parkingListController.lng = params[@"lng"];
    parkingListController.lat = params[@"lat"];
    return parkingListController;
    
}

@end
