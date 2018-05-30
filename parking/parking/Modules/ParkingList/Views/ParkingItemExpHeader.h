//
//  ParkingItemExpHeader.h
//  parking
//
//  Created by Robert Xu on 2017/6/5.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NearbyParkingModel.h"

@protocol ParkingItemExpHeaderDelegate <NSObject>

@optional
- (void)parkingItemExpHeaderDidClick:(NSInteger)section;
- (void)parkingItemExpNaviButtonClickedWithLng:(NSString *)lng lat:(NSString *)lat;

@end

@interface ParkingItemExpHeader : UIView

@property (assign, nonatomic) NSInteger section;
@property (weak, nonatomic) id <ParkingItemExpHeaderDelegate> delegate;

- (void)showData:(NearbyParkingModel *)model;

@end
