//
//  COLMapNavi.h
//  parking
//
//  Created by Robert Xu on 2017/6/9.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapNaviKit/AMapNaviKit.h>

typedef void (^COLMapNaviResultBlock) (BOOL success, NSString *message, NSInteger routeLength, NSInteger routeTime, NSArray<AMapNaviPoint *> *routeCoordinates);

@interface COLMapNavi : NSObject

COLSingletonH(COLMapNavi)

@property (strong, nonatomic) AMapNaviDriveManager *driveManager;

- (void)startNaviWithStartPoint:(CLLocation *)start endPoint:(CLLocation *)end resultBlock:(COLMapNaviResultBlock)resultBlock;

@end
