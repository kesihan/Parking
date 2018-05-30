//
//  HomeService.h
//  parking
//
//  Created by Robert Xu on 2017/6/13.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NearbyParkingModel.h"

typedef void (^hsHomeBoolResultBlock) (BOOL success, NSString *message);
typedef void (^hsHomeNearbyParkingListResultBlock) (BOOL success, NSString *message, NSArray <NearbyParkingModel *>*parkingList);

@interface HomeService : NSObject

- (void)getNearbyParkingListByLng:(NSString *)lng lat:(NSString *)lat r:(NSString *)r resultBlock:(hsHomeNearbyParkingListResultBlock)resultBlock;


@end
