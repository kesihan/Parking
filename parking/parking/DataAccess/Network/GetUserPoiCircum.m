//
//  GetUserPoiCircum.m
//  parking
//
//  Created by Robert Xu on 2017/6/13.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "GetUserPoiCircum.h"

@implementation GetUserPoiCircum {
    NSString *_str;
    NSString *_pageSize;
}

- (instancetype)initWithStr:(NSString *)str pageSize:(NSString *)pageSize {
    self = [super init];
    if (self) {
        _str = str;
        _pageSize = pageSize;
    }
    return self;
}

- (NSString *)requestUrl {
    
    return @"/v1/user/poi/circum";
}

- (NSTimeInterval)requestTimeoutInterval {
    return COLRequestTimeoutInterval;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (id)requestArgument {
    return @{
             @"str": _str,
             @"pageSize": _pageSize
             };
}

@end
