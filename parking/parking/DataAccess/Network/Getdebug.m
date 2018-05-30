//
//  Getdebug.m
//  parking
//
//  Created by 柯思汉 on 2018/3/5.
//  Copyright © 2018年 huafangcloud. All rights reserved.
//

#import "Getdebug.h"

@implementation Getdebug
{
    NSString *_userID;
    NSString *_pageSize;
    NSString *_nums;
    
}
- (id)initWithuserID:(NSString *)userID pageSize:(NSString *)pageSize nums:(NSString *)nums;
{
    self = [super init];
    if (self) {
        _userID = userID;
        _pageSize =pageSize;
        _nums =nums;
    }
    return self;
}

- (NSString *)requestUrl {
    // “http://www.yuantiku.com” 在 YTKNetworkConfig 中设置，这里只填除去域名剩余的网址信息
    return @"/v1/user/debugging/debug";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (id)requestArgument {
    
//    return nil;
        return @{
                 @"userID": _userID,
                 @"pageSize": _pageSize,
                 @"nums":_nums
                };
}

@end
