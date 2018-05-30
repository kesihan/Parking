//
//  JFHttpRequestTool.h
//  JFMiaoBo
//
//  Created by 张剑锋 on 2016/10/28.
//  Copyright © 2016年 张剑锋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JFHttpRequestTool : NSObject


// GET网络请求

+ (void)getWithURL:(NSString *)urlStr
            params:(NSDictionary *)params
           success:(void(^)(id json))success
           failure:(void(^)(NSError *error))failure;
    
// POST请求
+ (void)postWithURL:(NSString *)urlStr
             params:(id)params
            success:(void (^)(id))success
            failure:(void (^)(NSError *))failure;

// POST请求（上传图片）
+ (void)postWithURL:(NSString *)urlStr
             params:(id)params
           imageArr:(NSArray *)imageArr
            success:(void (^)(id json))success
            failure:(void (^)(NSError *error))failure;
@end
