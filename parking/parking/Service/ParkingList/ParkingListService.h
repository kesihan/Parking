//
//  ParkingListService.h
//  parking
//
//  Created by Robert Xu on 2017/6/19.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NearbyParkingModel.h"

typedef void (^plsNearbyParkingListResultBlock) (BOOL success, NSString *message, NSArray <NearbyParkingModel *>*parkingList);

@interface ParkingListService : NSObject

- (void)getNearbyParkingListByLng:(NSString *)lng
                              lat:(NSString *)lat
                                r:(NSString *)r
                        pageIndex:(NSString *)pageIndex
                             size:(NSString *)size
                      resultBlock:(plsNearbyParkingListResultBlock)resultBlock;

@end
