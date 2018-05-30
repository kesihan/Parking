//
//  Getnavigationrealtime.m
//  parking
//
//  Created by 柯思汉 on 17/9/19.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "Getnavigationrealtime.h"

@implementation Getnavigationrealtime
{
    NSString *_userID;
    NSString *_str;
    
}
- (id)initWithuserID:(NSString *)userID str:(NSString *)str;
{
    self = [super init];
    if (self) {
        _userID = userID;
        _str =str;
    }
    return self;
}

- (NSString *)requestUrl {
    // “http://www.yuantiku.com” 在 YTKNetworkConfig 中设置，这里只填除去域名剩余的网址信息
    return @"/v1/navigation/realtime";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (id)requestArgument {
    
    return nil;
//    return [self returnUrlArgumentsFilterParams:@{
//                                                  @"userID": _userID,
//                                                  @"str": _str,
//                                                  }];
}

@end
