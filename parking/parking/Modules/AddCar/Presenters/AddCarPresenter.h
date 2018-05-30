//
//  AddCarPresenter.h
//  parking
//
//  Created by Robert Xu on 2017/6/13.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CarService.h"

@protocol AddCarPresenterDelegate <NSObject>

- (void)addCarAddedSuccess:(BOOL)success message:(NSString *)message;

@end

@interface AddCarPresenter : NSObject <COLPresenterProtocol>

//协议方法
- (instancetype)initWithService:(CarService *)service;

- (void)attachView:(id<AddCarPresenterDelegate>)view;

- (void)detachView;

- (void)adCarByPlateNo:(NSString *)plateNo type:(NSString *)type;

@end
