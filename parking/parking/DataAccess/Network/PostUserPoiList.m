//
//  PostUserPoiList.m
//  parking
//
//  Created by Robert Xu on 2017/6/13.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "PostUserPoiList.h"

@implementation PostUserPoiList {
    NSString *_lng;
    NSString *_lat;
    NSString *_r;
    NSString *_pageIndex;
    NSString *_size;
}

- (instancetype)initWithLng:(NSString *)lng
                        lat:(NSString *)lat
                          r:(NSString *)r
                  pageIndex:(NSString *)pageIndex
                       size:(NSString *)size {
    self = [super init];
    if (self) {
        _lng = lng;
        _lat = lat;
        _r = r;
        _pageIndex = pageIndex;
        _size = size;
    }
    return self;
}

- (NSString *)requestUrl {
    
    return @"/v1/user/poi/list";
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
             @"r" : _r,
             @"pageIndex": _pageIndex,
             @"size": _size
             };
}

@end
