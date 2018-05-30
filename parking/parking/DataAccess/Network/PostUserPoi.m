//
//  PostUserPoi.m
//  parking
//
//  Created by Robert Xu on 2017/6/13.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "PostUserPoi.h"

@implementation PostUserPoi {
    NSString *_lng;
    NSString *_lat;
    NSString *_r;
}

- (instancetype)initWithLng:(NSString *)lng lat:(NSString *)lat r:(NSString *)r {
    self = [super init];
    if (self) {
        _lng = lng;
        _lat = lat;
        _r = r;
    }
    return self;
}

- (NSString *)requestUrl {
    
    return @"/v1/user/poi";
}

- (NSTimeInterval)requestTimeoutInterval {
    return COLRequestTimeoutInterval;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{
             @"lng": _lng,
             @"lat": _lat,
             @"r" : _r
             };
}

@end
