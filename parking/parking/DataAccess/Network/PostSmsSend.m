//
//  PostSmsSend.m
//  parking
//
//  Created by Robert Xu on 2017/6/12.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "PostSmsSend.h"

@implementation PostSmsSend {
    NSString *_mobile;//手机号
    NSString *_purpose;//用途：register,login,verify
    NSString *_message;//hud提示
}

- (instancetype)initWithMobile:(NSString *)mobile purpose:(NSString *)purpose message:(NSString *)message {
    self = [super init];
    if (self) {
        _mobile = mobile;
        _purpose = purpose;
        _message = message;
    }
    return self;
}

- (NSString *)requestUrl {
    
    return @"/v1/sms/send";
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
             @"purpose": _purpose,
             @"message": _message
             };
}

@end
