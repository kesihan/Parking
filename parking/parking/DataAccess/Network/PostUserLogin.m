//
//  PostUserLogin.m
//  parking
//
//  Created by Robert Xu on 2017/6/13.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "PostUserLogin.h"

@implementation PostUserLogin {
    NSString *_mobile;
    NSString *_verify;
}

- (instancetype)initWithMobile:(NSString *)mobile verify:(NSString *)verify {
    self = [super init];
    if (self) {
        _mobile = mobile;
        _verify = verify;
    }
    return self;
}

- (NSString *)requestUrl {
    
    return @"/v1/user/login";
}

- (NSTimeInterval)requestTimeoutInterval {
    return COLRequestTimeoutInterval;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{
             @"mobile": _mobile,
             @"verify": _verify
             };
}

@end
