//
//  HomePresenter.h
//  parking
//
//  Created by Robert Xu on 2017/5/18.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeService.h"

@protocol HomePresenterDelegate <NSObject>

- (void)homeNearbyParkingListDidLoadedSuccess:(BOOL)success
                                      message:(NSString *)message
                            nearbyParkingList:(NSArray <NearbyParkingModel *>*)parkingList;
- (void)homeAddCollectionSuccess:(BOOL)success message:(NSString *)message;

@end

@interface HomePresenter : NSObject <COLPresenterProtocol>

//协议方法
- (instancetype)initWithService:(HomeService *)service;

- (void)attachView:(id)view;

- (void)detachView;

//其他
- (void)getNearbyParkingListByLng:(NSString *)lng lat:(NSString *)lat;
- (BOOL)isUserLogin;
- (void)addCollectionByParkingID:(NSString *)parkingID;

@end
