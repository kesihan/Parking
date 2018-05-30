//
//  COLMediator+ParkingDetail.h
//  parking
//
//  Created by Robert Xu on 2017/5/23.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "COLMediator.h"

@interface COLMediator (ParkingDetail)

// 停车场详情
- (UIViewController *)parkingDetailControllerWithParams:(NSDictionary *)params;

@end
