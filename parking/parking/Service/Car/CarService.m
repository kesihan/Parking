//
//  CarService.m
//  parking
//
//  Created by Robert Xu on 2017/6/13.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "CarService.h"
//API
#import "GetUserHomeCar.h"
#import "PostUserHomeAddCar.h"
#import "PostUserHomeModify.h"
#import "DeleteUserHomeDelCar.h"
//Service
#import "AccountService.h"

@implementation CarService

- (void)getCarListByUserID:(NSString *)userID resultBlock:(csCarListResultBlock)resultBlock  {
    GetUserHomeCar *getUserHomeCar = [[GetUserHomeCar alloc] initWithUserID:userID];
    [getUserHomeCar startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        BOOL isOK = [request isOK];
        if (isOK) {
            NSMutableArray *carList = [NSMutableArray arrayWithCapacity:10];
            NSArray *list = [request content];
            for (NSDictionary *car in list) {
                [carList addObject:[CarModel yy_modelWithJSON:car]];
            }
            resultBlock(isOK, [request message], carList);
        } else {
            resultBlock(isOK, [request message], nil);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        resultBlock(NO, [request message], nil);
    }];
}

- (void)addCarByUserID:(NSString *)userID plateNo:(NSString *)plateNo type:(NSString *)type resultBlock:(csCarAddResultBlock)resultBlock {
    PostUserHomeAddCar *postUserHomeAddCar = [[PostUserHomeAddCar alloc] initWithUserID:userID plateNo:plateNo type:type];
    [postUserHomeAddCar startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        BOOL isOK = [request isOK];
        resultBlock(isOK, [request message]);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        resultBlock(NO, [request message]);
    }];
}

- (void)setDefaultCarByUserID:(NSString *)userID plateNo:(NSString *)plateNo resultBlock:(csCarSetDefaultResultBlock)resultBlock {
    PostUserHomeModify *postUserHomeModify = [[PostUserHomeModify alloc] initWithUserID:userID plateNo:plateNo];
    [postUserHomeModify startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        BOOL isOK = [request isOK];
        resultBlock(isOK, [request message]);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        resultBlock(NO, [request message]);
    }];
}

- (void)deleteCarByUserID:(NSString *)userID carID:(NSString *)carID resultBlock:(csCarBoolResultBlock)resultBlock {
    DeleteUserHomeDelCar *deleteUserHomeDelCar = [[DeleteUserHomeDelCar alloc] initWithUserID:userID carID:carID];
    [deleteUserHomeDelCar startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        BOOL isOK = [request isOK];
        resultBlock(isOK, [request message]);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        resultBlock(NO, [request message]);
    }];
}

@end
