//
//  PostUserHomeInPoint.m
//  parking
//
//  Created by Robert Xu on 2017/6/13.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "PostUserHomeInPoint.h"

@implementation PostUserHomeInPoint {
    NSString *_userID;
}

- (instancetype)initWithUserID:(NSString *)userID {
    self = [super init];
    if (self) {
        _userID = userID;
    }
    return self;
}

- (NSString *)requestUrl {
    
    return @"/v1/user/home/inpoint";
}

- (NSTimeInterval)requestTimeoutInterval {
    return COLRequestTimeoutInterval;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{
             @"userID": _userID
             };
}

@end
