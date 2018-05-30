//
//  YTKUrlArgumentsFilter.m
//  shuxiang
//
//  Created by 方燕娇 on 16/11/11.
//  Copyright © 2016年 Addison. All rights reserved.
//

#import "YTKUrlArgumentsFilter.h"

@interface YTKUrlArgumentsFilter()


@end

@implementation YTKUrlArgumentsFilter

// 封装请求方法
- (void)sk_startWithWithSuccessBlock: (skSuccessBlock) successBlock
                          errorBlock: (skErrorBlock) errorBlock
                        failureBlock: (skFailureBlock) failureBlock {
    
//    self.ignoreCache = YES;
    [self startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
 
        if (request.code == 0 ||request.code ==200 ) {
            
            successBlock(request);
            
        }else{
            
            errorBlock(request);
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"%@",request.error);
        failureBlock(request.message);
        
    }];
    
}

-(NSDictionary *)returnUrlArgumentsFilterParams:(NSDictionary *)urlArgumentsDict {
    
    NSString * ts = [self getTimestamp];
    
    NSString * sign = [self getSignWithTimestamp:ts];
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:sign,@"sign",ts,@"ts",AG_APPID,@"appID", nil];
    
    NSArray *keysArray = [urlArgumentsDict allKeys];
    for (NSString *key in keysArray) {
        
        [mDict setObject:[urlArgumentsDict objectForKey:key] forKey:key];
    }
    
    return mDict;
}

#pragma mark - return ts
- (NSString *)getTimestamp
{
    return [NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970]];
}

#pragma mark - return sign

/**
 sign = appID+ts+token+'commonICE'
 */
- (NSString *)getSignWithTimestamp:(NSString *)ts {
    return [[NSString stringWithFormat:@"%@%@%@%@", AG_APPID, ts, AG_TOKEN, AG_ENCRYPT] getMD5];
}

- (NSTimeInterval)requestTimeoutInterval {
    return 15;
}

@end
