//
//  PostUserHomeAddCollection.m
//  parking
//
//  Created by Robert Xu on 2017/6/13.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "PostUserHomeAddCollection.h"

@implementation PostUserHomeAddCollection {
    NSString *_userID;
    NSString *_objectType;
    NSString *_objectID;
}

- (instancetype)initWithUserID:(NSString *)userID objectType:(NSString *)objectType objectID:(NSString *)objectID {
    self = [super init];
    if (self) {
        _userID = userID;
        _objectType = objectType;
        _objectID = objectID;
    }
    return self;
}

- (NSString *)requestUrl {
    
    return @"/v1/user/home/addcollection";
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
             @"objectType": _objectType,
             @"objectID": _objectID
             };
}

@end
