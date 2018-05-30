//
//  COLMediator+ParkingList.h
//  parking
//
//  Created by Robert Xu on 2017/5/19.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "COLMediator.h"
#import <UIKit/UIKit.h>

@interface COLMediator (ParkingList)

// 附近停车场列表
- (UIViewController *)parkingListControllerWithLng:(NSString *)lng lat:(NSString *)lat;

@end
