//
//  JFHttpRequestTool.m
//  JFMiaoBo
//
//  Created by 张剑锋 on 2016/10/28.
//  Copyright © 2016年 张剑锋. All rights reserved.
//

#import "JFHttpRequestTool.h"
#import <AFNetworking.h>

@implementation JFHttpRequestTool

// test
+ (void)requestupLoadImgcheckCarAndSettleWithUrl:(NSString *)url postParems:(NSString *)postParems imgArray:(NSArray *)imgArray success:(void(^)(NSDictionary *json))success{
    
    NSDictionary *dic = [NSDictionary new];
    //dic = 结果
    if (success) {
        success(dic);
    }
}
// GET请求

+ (void)getWithURL:(NSString *)urlStr params:(NSDictionary *)params success:(void(^)(id json))success failure:(void(^)(NSError *error))failure {

    // 请求数据
    NSString *newUrl = [NSString stringWithFormat:@"%@",urlStr];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    
    manager.requestSerializer.HTTPShouldHandleCookies = NO;
    manager.requestSerializer.HTTPShouldUsePipelining = YES;
    [manager.operationQueue cancelAllOperations];
    
    manager.requestSerializer.timeoutInterval = 15;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];
    
    [manager GET:newUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        
        if (success) {
            success(responseObject);
        }
//        [self log:params andResponseObject:responseObject url:newUrl];

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(error);
        }
//        [self log:params error:error url:newUrl];
    }];
}

// POST请求
+ (void)postWithURL:(NSString *)urlStr
             params:(id)params
            success:(void (^)(id))success
            failure:(void (^)(NSError *))failure
{
    [self postWithFullURL:[NSString stringWithFormat:@"%@",urlStr]
                   params:params
                  success:success
                  failure:failure];
}

// 完整的url地址请求
+ (void)postWithFullURL:(NSString *)urlStr
                 params:(id)params
                success:(void (^)(id))success
                failure:(void (^)(NSError *))failure
{
    // 1 创建请求管理员
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer.HTTPShouldHandleCookies = NO;
    manager.requestSerializer.HTTPShouldUsePipelining = YES;
    [manager.operationQueue cancelAllOperations];
    
    manager.requestSerializer.timeoutInterval = 15;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];
    
    // 2 发送POST请求
    NSString *newUrl = urlStr;

    // 配置新的加密参数
//    NSDictionary *newParams = [self getNewParams:params];
    
    [manager POST:newUrl parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
//        [self log:newParams andResponseObject:responseObject url:newUrl];
        
        if (success)
        {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
//        [self log:newParams error:error url:newUrl];
        
        if (failure)
        {
            failure(error);
        }
    }];
}


// POST请求（上传图片）
+ (void)postWithURL:(NSString *)urlStr
             params:(id)params
           imageArr:(NSArray *)imageArr
            success:(void (^)(id json))success
            failure:(void (^)(NSError *error))failure
{
    // 没有图片的时候
    if (!imageArr.count && failure)
    {
        failure(nil);
    }
    
    // 1 创建请求管理员
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];
    
    // 配置新的加密参数
//    NSDictionary *newParams = [self getNewParams:params];

    // 2 发送POST请求
    [manager POST:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        // 上传文件
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        // 获取时间用来命名图片
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        
        for (int i=0; i<imageArr.count; i++) {
            // 图片名称
            NSString *fileName = [NSString stringWithFormat:@"%@_%d.jpg",str,i];

            NSData *imageData = imageArr[i];
            [formData appendPartWithFileData:imageData name:@"photo" fileName:fileName mimeType:@"image/png"];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        [self log:newParams andResponseObject:responseObject url:urlStr];
        
        if (success)
        {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
//        [self log:newParams error:error url:urlStr];
        
        if (failure)
        {
            failure(error);
        }
    }];
}

#pragma mark - Utils

//// 加密配置新的参数
//+ (NSDictionary *)getNewParams:(NSDictionary *)params {
//    
//    NSMutableDictionary *newParams = [NSMutableDictionary dictionaryWithDictionary:params];
//    
//    // 获取时间戳
//    NSString *timeString = [JFTool getCurrentDateStr];
//    [newParams setObject:timeString forKey:@"timestamp"];
//    
//    // 所有的key
//    NSArray *allKes = [newParams allKeys];
//    
//    // 按字母顺序排序
//    NSArray *sortedArray = [allKes sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
//        return [obj1 compare:obj2 options:NSNumericSearch];
//    }];
//    
//    // sign规则的字符串
//    NSMutableString *signStr = [NSMutableString string];
//    NSString *secretKey = @"^123qwe$^&%D#((+";
//    
//    for (int i=0; i<sortedArray.count; i++) {
//        [signStr appendString:[NSString stringWithFormat:@"&%@=%@",sortedArray[i],[newParams valueForKey:sortedArray[i]]]];
//    }
//    [signStr appendString:[NSString stringWithFormat:@"&%@",secretKey]];
//    
//    // 赋值
//    [newParams setObject:[signStr jf_md5] forKey:@"sign"];
//    
//    return newParams;
//}
//
//// Log信息
//+ (void)log:(id)params andResponseObject:(id)responseObject url:(NSString *)url{
//    JFLog(@"\r请求的地址是:%@",url);
//    
//    JFLog(@"\r参数为:%@",params);
//    
//    if (!responseObject) {
//        return;
//    }
//    // json数据或者NSDictionary转为NSData，responseObject为json数据或者NSDictionary
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
//    // NSData转为NSString
//    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    
//    JFLog(@"\r获取的json数据是:%@",jsonStr);
//}

//+ (void)log:(id)params error:(id)error url:(NSString *)url{
//    JFLog(@"\r请求的地址是:%@",url);
//    
//    JFLog(@"\r参数为:%@",params);
//    
//    JFLog(@"\r错误:%@",error);
//}

@end
