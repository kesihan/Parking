//
//  COLMapNavi.m
//  parking
//
//  Created by Robert Xu on 2017/6/9.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "COLMapNavi.h"

@interface COLMapNavi () <AMapNaviDriveManagerDelegate>

@property (copy, nonatomic) COLMapNaviResultBlock mapNaviResultBlock;

@end

@implementation COLMapNavi

COLSingletonM(COLMapNavi)

- (void)startNaviWithStartPoint:(CLLocation *)start endPoint:(CLLocation *)end resultBlock:(COLMapNaviResultBlock)resultBlock {
    
    AMapNaviPoint *startPoint = [AMapNaviPoint locationWithLatitude:start.coordinate.latitude longitude:start.coordinate.longitude];
    AMapNaviPoint *endPoint = [AMapNaviPoint locationWithLatitude:end.coordinate.latitude longitude:end.coordinate.longitude];
    self.mapNaviResultBlock = resultBlock;
    self.driveManager.delegate = self;
    [self.driveManager calculateDriveRouteWithStartPoints:@[startPoint]
                                                endPoints:@[endPoint]
                                                wayPoints:nil
                                          drivingStrategy:AMapNaviDrivingStrategySingleDefault];
}

#pragma mark - AMapNaviDriveManagerDelegate

- (void)driveManagerOnCalculateRouteSuccess:(AMapNaviDriveManager *)driveManager {
    //显示路径或开启导航
    AMapNaviRoute *naviRoute = driveManager.naviRoute;
    NSArray<AMapNaviPoint *> *routeCoordinates = naviRoute.routeCoordinates;
    NSInteger routeLength = naviRoute.routeLength;//(单位:米)
    NSInteger routeTime = naviRoute.routeTime;//(单位:秒)
    
    self.mapNaviResultBlock(YES, @"", routeLength, routeTime, routeCoordinates);
}

#pragma mark - getter & setter

- (AMapNaviDriveManager *)driveManager {
    if (!_driveManager) {
        _driveManager = [[AMapNaviDriveManager alloc] init];
    }
    return _driveManager;
}

#pragma mark - life cycle 

- (void)dealloc {
    [_driveManager setDelegate:nil];
}

@end
