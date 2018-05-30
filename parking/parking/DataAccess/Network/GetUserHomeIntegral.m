//
//  GetUserHomeIntegral.m
//  parking
//
//  Created by Robert Xu on 2017/6/13.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "GetUserHomeIntegral.h"

@implementation GetUserHomeIntegral {
    NSString *_userID;
    NSString *_pageIndex;
    NSString *_size;
}

- (instancetype)initWithUserID:(NSString *)userID pageIndex:(NSString *)pageIndex size:(NSString *)size {
    self = [super init];
    if (self) {
        _userID = userID;
        _pageIndex = pageIndex;
        _size = size;
    }
    return self;
}

- (NSString *)requestUrl {
    
    return @"/v1/user/home/integral";
}

- (NSTimeInterval)requestTimeoutInterval {
    return COLRequestTimeoutInterval;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (id)requestArgument {
    return @{
             @"userID": _userID,
             @"pageIndex": _pageIndex,
             @"size": _size
             };
}

@end
