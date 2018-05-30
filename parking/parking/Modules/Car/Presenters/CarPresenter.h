//
//  CarPresenter.h
//  parking
//
//  Created by Robert Xu on 2017/6/13.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CarService.h"

@protocol CarPresenterDelegate <NSObject>

- (void)carListDidLoadedSuccess:(BOOL)success message:(NSString *)message carList:(NSArray <CarModel *>*)carList;
- (void)carSetDefaultSuccess:(BOOL)success message:(NSString *)message;
- (void)carDeleteSuccess:(BOOL)success message:(NSString *)message;

@end

@interface CarPresenter : NSObject <COLPresenterProtocol>

//协议方法
- (instancetype)initWithService:(CarService *)service;

- (void)attachView:(id<CarPresenterDelegate>)view;

- (void)detachView;

- (void)getCarList;
- (void)setDefaultCarByPlateNo:(NSString *)plateNo;
- (void)deleteCarByCarID:(NSString *)carID;

@end
