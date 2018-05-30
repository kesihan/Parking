//
//  YTKUrlArgumentsFilter.m
//  parking
//
//  Created by Robert Xu on 2017/6/8.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "YTKUrlArgumentsFilter.h"
#import <AFNetworking/AFNetworking.h>

@implementation YTKUrlArgumentsFilter

+ (YTKUrlArgumentsFilter *)filter {
    return [[self alloc] init];
}

//每次请求会被调用
- (NSString *)filterUrl:(NSString *)originUrl withRequest:(YTKBaseRequest *)request {
    
    //插入动态参数
    NSString *ts = [self getTimestamp];
    return [self urlStringWithOriginUrlString:originUrl appendParameters:@{ @"sign": [self getSignWithTimestamp:ts], @"ts": ts, @"appID": [self getAppID] }];
}

#pragma mark - tools

- (NSString *)urlStringWithOriginUrlString:(NSString *)originUrlString appendParameters:(NSDictionary *)parameters {
    NSString *filteredUrl = originUrlString;
    NSString *paraUrlString = [self urlParametersStringFromParameters:parameters];
    if (paraUrlString && paraUrlString.length > 0) {
        if ([originUrlString rangeOfString:@"?"].location != NSNotFound) {
            filteredUrl = [filteredUrl stringByAppendingString:paraUrlString];
        } else {
            filteredUrl = [filteredUrl stringByAppendingFormat:@"?%@", [paraUrlString substringFromIndex:1]];
        }
        return filteredUrl;
    } else {
        return originUrlString;
    }
}

- (NSString *)urlParametersStringFromParameters:(NSDictionary *)parameters {
    NSMutableString *urlParametersString = [[NSMutableString alloc] initWithString:@""];
    if (parameters && parameters.count > 0) {
        for (NSString *key in parameters) {
            NSString *value = parameters[key];
            value = [NSString stringWithFormat:@"%@",value];
            value = [self urlEncode:value];
            [urlParametersString appendFormat:@"&%@=%@", key, value];
        }
    }
    return urlParametersString;
}

- (NSString*)urlEncode:(NSString*)str {
    return AFPercentEscapedStringFromString(str);
}

#pragma mark - params

- (NSString *)getTimestamp
{
    return [NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970]];
}

- (NSString *)getSignWithTimestamp:(NSString *)ts {
    return [[NSString stringWithFormat:@"%@%@%@%@", COLAGRequestAppID, ts, COLAGRequestToken, COLAGEncrypt] col_MD5];
}

- (NSString *)getAppID {
    return COLAGRequestAppID;
}

@end
