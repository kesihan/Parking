//
//  COLMap.h
//  parking
//
//  Created by Robert Xu on 2017/6/8.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
/**
 *  @brief AMapLocatingCompletionBlock 单次定位返回Block
 *  @param location 定位信息
 *  @param regeocode 逆地理信息
 *  @param error 错误信息，参考 AMapLocationErrorCode
 */
typedef void (^COLMapCompletionBlock)(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error);

@interface COLMap : NSObject

COLSingletonH(COLMap)

- (void)configureSingleLoc;
- (void)startSingleLocWithReGeocode:(BOOL)willReGeocode CompletionBlock:(COLMapCompletionBlock)completion;
- (void)stop;

@end
