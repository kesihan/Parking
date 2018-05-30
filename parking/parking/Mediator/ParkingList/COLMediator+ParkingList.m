//
//  COLMediator+ParkingList.m
//  parking
//
//  Created by Robert Xu on 2017/5/19.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "COLMediator+ParkingList.h"

// 常量命名规则：
// Target：   kCOLMediatorTarget + 模块名（大写开头）      =  @"模块名（大写开头）"
// Action：   kCOLMediatorAction + 具体操作（大写开头）     =  @"具体操作"（小写开头）

static NSString * const kCOLMediatorTargetParkingList = @"ParkingList";

static NSString * const kCOLMediatorActionParkingListController = @"parkingListController";

@implementation COLMediator (ParkingList)

// 方法命名规则：模块名（小写开头）+ 具体操作

// 附近停车场列表
- (UIViewController *)parkingListControllerWithLng:(NSString *)lng lat:(NSString *)lat {
    UIViewController *controller = [self performTarget:kCOLMediatorTargetParkingList
                                                action:kCOLMediatorActionParkingListController
                                                params:@{ @"lng": lng, @"lat" : lat}
                                     shouldCacheTarget:NO];
    if ([controller isKindOfClass:[UIViewController class]]) {
        return controller;
    } else {
        // 处理错误，具体看你想怎么做了...
        return [[UIViewController alloc] init];
    }
}

@end
