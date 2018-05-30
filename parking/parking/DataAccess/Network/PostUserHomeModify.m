//
//  PostUserHomeModify.m
//  parking
//
//  Created by Robert Xu on 2017/6/13.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "PostUserHomeModify.h"

@implementation PostUserHomeModify {
    NSString *_userID;
    NSString *_plateNo;
}

- (instancetype)initWithUserID:(NSString *)userID plateNo:(NSString *)plateNo {
    self = [super init];
    if (self) {
        _userID = userID;
        _plateNo = plateNo;
    }
    return self;
}

- (NSString *)requestUrl {
    
    return @"/v1/user/home/modify";
}

- (NSTimeInterval)requestTimeoutInterval {
    return COLRequestTimeoutInterval;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{
             @"userID": _userID,
             @"plateNo": _plateNo
             };
}

@end
