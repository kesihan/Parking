//
//  DeleteUserHomeDelCar.m
//  parking
//
//  Created by Robert Xu on 2017/6/14.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "DeleteUserHomeDelCar.h"

@implementation DeleteUserHomeDelCar {
    NSString *_userID;
    NSString *_carID;
}

- (instancetype)initWithUserID:(NSString *)userID carID:(NSString *)carID {
    self = [super init];
    if (self) {
        _userID = userID;
        _carID = carID;
    }
    return self;
}

- (NSString *)requestUrl {
    
    return @"/v1/user/home/delcar";
}

- (NSTimeInterval)requestTimeoutInterval {
    return COLRequestTimeoutInterval;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodDELETE;
}

- (id)requestArgument {
    return @{
             @"userID": _userID,
             @"carID": _carID
             };
}

@end
