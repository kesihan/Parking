//
//  ParkingItemHeader.h
//  parking
//
//  Created by Robert Xu on 2017/5/22.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NearbyParkingModel.h"

@protocol ParkingItemHeaderDelegate <NSObject>

@optional
- (void)parkingItemHeaderDidClick:(NSInteger)section;
- (void)parkingItemHeaderNaviButtonClickedWithLng:(NSString *)lng lat:(NSString *)lat;

@end

@interface ParkingItemHeader : UIView

@property (assign, nonatomic) NSInteger section;
@property (weak, nonatomic) id <ParkingItemHeaderDelegate> delegate;
- (void)showData:(NearbyParkingModel *)model;

@end
