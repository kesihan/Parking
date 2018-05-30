//
//  PostUserHomeAddCar.m
//  parking
//
//  Created by Robert Xu on 2017/6/13.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "PostUserHomeAddCar.h"

@implementation PostUserHomeAddCar {
    NSString *_userID;
    NSString *_plateNo;
    NSString *_type;
}

- (instancetype)initWithUserID:(NSString *)userID plateNo:(NSString *)plateNo type:(NSString *)type {
    self = [super init];
    if (self) {
        _userID = userID;
        _plateNo = plateNo;
        _type = type;
    }
    return self;
}

- (NSString *)requestUrl {
    
    return @"/v1/user/home/addcar";
}

- (NSTimeInterval)requestTimeoutInterval {
    return COLRequestTimeoutInterval;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{
             @"userID": _userID,
             @"plateNo": _plateNo,
             @"type": _type
             };
}

@end
