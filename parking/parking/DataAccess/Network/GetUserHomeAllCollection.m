//
//  GetUserHomeAllCollection.m
//  parking
//
//  Created by Robert Xu on 2017/6/13.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "GetUserHomeAllCollection.h"

@implementation GetUserHomeAllCollection {
    NSString *_userID;
    NSString *_objectType;
    NSString *_pageIndex;
    NSString *_size;
}

- (instancetype)initWithUserID:(NSString *)userID objectType:(NSString *)objectType pageIndex:(NSString *)pageIndex size:(NSString *)size {
    self = [super init];
    if (self) {
        _userID = userID;
        _objectType = objectType;
        _pageIndex = pageIndex;
        _size = size;
    }
    return self;
}

- (NSString *)requestUrl {
    
    return @"/v1/user/home/allcollection";
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
             @"objectType": _objectType,
             @"pageIndex": _pageIndex,
             @"size": _size
             };
}

@end
