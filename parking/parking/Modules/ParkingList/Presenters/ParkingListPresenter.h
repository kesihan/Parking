//
//  ParkingListPresenter.h
//  parking
//
//  Created by Robert Xu on 2017/6/19.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NearbyParkingModel.h"
#import "ParkingListService.h"

@protocol ParkingListPresenterDelegate <NSObject>

- (void)parkingListDidLoadedSuccess:(BOOL)success message:(NSString *)message nearbyParkingList:(NSArray<NearbyParkingModel *> *)parkingList;

@end

@interface ParkingListPresenter : NSObject <COLPresenterProtocol>

//协议方法
- (instancetype)initWithService:(ParkingListService *)service;

- (void)attachView:(id<ParkingListPresenterDelegate>)view;

- (void)detachView;
//获取
- (void)getParkingListByLng:(NSString *)lng lat:(NSString *)lat;

@end
