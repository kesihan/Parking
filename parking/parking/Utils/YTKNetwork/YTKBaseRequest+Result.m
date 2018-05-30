//
//  YTKBaseRequest+Result.m
//  colourfullife
//
//  Created by Robert Xu on 16/5/23.
//  Copyright © 2016年 listcloud. All rights reserved.
//

#import "YTKBaseRequest+Result.h"

@implementation YTKBaseRequest (Result)

- (id)result {
    return [self responseJSONObject];
}

- (NSInteger)responseCode {
    return [[[self responseJSONObject] objectForKey:@"code"] integerValue];
}

- (BOOL)isSuccess {
    return (0 == [[[self responseJSONObject] objectForKey:@"code"] integerValue] ? YES : NO);
}

- (NSString *)message {
    return [[self responseJSONObject] objectForKey:@"message"];
}

- (id)content {
    return [[self responseJSONObject] objectForKey:@"content"];
}

- (BOOL)isCorrect {
    id result = [self responseJSONObject];
    if (!result) {
        return NO;
    }
    if ([result isKindOfClass:[NSArray class]]) {
        NSArray *array = (NSArray *)result;
        if ([array count]) {
            return YES;
        } else {
            return NO;
        }
    }
    
    if ([result isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = (NSDictionary *)result;
        if ([[dic allKeys] count]) {
            return YES;
        } else {
            return NO;
        }
    }
    
    if ([result isKindOfClass:[NSString class]]) {
        NSString *str = (NSString *)result;
        if (str != NULL && [str col_trim].length > 0) {
            return YES;
        } else {
            return NO;
        }
    }
    
    return YES;
}

- (BOOL)isOK {
    return ([self isCorrect] && [self isSuccess]);
}

@end
