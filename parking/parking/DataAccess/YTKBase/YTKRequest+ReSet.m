//
//  YTKRequest+ReSet.m
//  shuxiang
//
//  Created by 陈嘉贤 on 2017/1/10.
//  Copyright © 2017年 Addison. All rights reserved.
//

#import "YTKRequest+ReSet.h"
#import "YTKNetworkConfig.h"
#import <CommonCrypto/CommonDigest.h>

@implementation YTKRequest (ReSet)

- (NSString *)cacheFileName {
    NSString *requestUrl = [self requestUrl];
    NSString *baseUrl = [YTKNetworkConfig sharedConfig].baseUrl;
    id argument = [self cacheFileNameFilterForRequestArgument:[self requestArgument]];
    
    [argument removeObjectForKey:@"appID"];
    [argument removeObjectForKey:@"sign"];
    [argument removeObjectForKey:@"ts"];
    NSString *requestInfo = [NSString stringWithFormat:@"Method:%ld Host:%@ Url:%@ Argument:%@",
                             (long)[self requestMethod], baseUrl, requestUrl, argument];
    NSString *cacheFileName = [YTKRequest md5StringFromString:requestInfo];
    return cacheFileName;
}

+ (NSString *)md5StringFromString:(NSString *)string {
    NSParameterAssert(string != nil && [string length] > 0);
    
    const char *value = [string UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return outputString;
}

@end
