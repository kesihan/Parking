//
//  CarService.h
//  parking
//
//  Created by Robert Xu on 2017/6/13.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CarModel.h"

typedef void (^csCarListResultBlock) (BOOL success, NSString *message, NSArray<CarModel *> *carList);
typedef void (^csCarAddResultBlock) (BOOL success, NSString *message);
typedef void (^csCarSetDefaultResultBlock) (BOOL success, NSString *message);
typedef void (^csCarBoolResultBlock) (BOOL success, NSString *message);

@interface CarService : NSObject

//获取车辆列表
- (void)getCarListByUserID:(NSString *)userID resultBlock:(csCarListResultBlock)resultBlock;
//添加车辆
- (void)addCarByUserID:(NSString *)userID plateNo:(NSString *)plateNo type:(NSString *)type resultBlock:(csCarAddResultBlock)resultBlock;
//设置默认车辆
- (void)setDefaultCarByUserID:(NSString *)userID plateNo:(NSString *)plateNo resultBlock:(csCarSetDefaultResultBlock)resultBlock;
//删除车辆
- (void)deleteCarByUserID:(NSString *)userID carID:(NSString *)carID resultBlock:(csCarBoolResultBlock)resultBlock;

@end
