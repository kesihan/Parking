//
//  YTKBaseRequest+Response.m
//  shuxiang
//
//  Created by 方燕娇 on 16/11/29.
//  Copyright © 2016年 Addison. All rights reserved.
//

#import "YTKBaseRequest+Response.h"

@implementation YTKBaseRequest (Response)

-(NSInteger)code
{
//    if (![[self responseJSONObject] objectForKey:@"code"])
//    {
        return [[[self responseJSONObject] objectForKey:@"code"] integerValue];
//    }
//    return -1;
}

-(id)content
{
    return [[self responseJSONObject] objectForKey:@"content"];
}

-(NSString *)message
{
    return [[self responseJSONObject] objectForKey:@"message"];
}

-(BOOL)isSuccess
{
    return ([self code] == 0 ? true:false);
}

/*!
 *  判断返回的json格式有效性
 *
 *  @return YES or NO
 */
- (BOOL)isJSONValid {
    
    if ([self responseJSONObject] && [[self responseJSONObject] isKindOfClass:[NSDictionary class]]) {
        
        id code = [[self responseJSONObject] objectForKey:@"code"];
        id content = [[self responseJSONObject] objectForKey:@"content"];
        id message = [[self responseJSONObject] objectForKey:@"message"];
        
        if (content && ([content isKindOfClass:[NSArray class]] || [content isKindOfClass:[NSDictionary class]] || [content isKindOfClass:[NSString class]])) {
            if (code && ([code isKindOfClass:[NSNumber class]] || [code isKindOfClass:[NSString class]])) {
                if (message && ([message isKindOfClass:[NSString class]] || [message isKindOfClass:[NSNull class]])) {
                    return YES;
                }
            }
        }
    }
    return NO;
}

- (id)getResponse
{
    
    if ([self isJSONValid])
    {
        if ([self isSuccess]) {
            return [self content];
        } else {
            //错误信息
//            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"错误码%@：%@", @([self code]), [self message]]];
            NSLog(@"%@",[NSString stringWithFormat:@"错误码%@：%@", @([self code]), [self message]]);
            return nil;
        }
    } else {
        //服务器出错
//        [SVProgressHUD showErrorWithStatus:@"服务器返回数据出错"];
        NSLog(@"服务器返回数据出错");
        return nil;
    }
}

- (BOOL)isArrayContent {
    if ([[self content] isKindOfClass:[NSArray class]]) {
        return YES;
    } else {
        return NO;
    }
}

- (void)processError {
    //    DLog(@"%@", self.requestOperation.error.localizedDescription);
    if ([self responseStatusCode] == 0)
    {
        NSLog(@"连接不上网络");
//        [SVProgressHUD showErrorWithStatus:@"连接不上网络"];
    } else {
        NSLog(@"请求出错");
//        [SVProgressHUD showErrorWithStatus:@"请求出错"];
    }
}

@end
