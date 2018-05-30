//
//  YTKBaseRequest+Response.h
//  shuxiang
//
//  Created by 方燕娇 on 16/11/29.
//  Copyright © 2016年 Addison. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>



@interface YTKBaseRequest (Response)

/*!
 *  处理返回请求
 *
 *  @return 返回nil或者数据（可能是NSDictionary或者NSArray）
 */
- (id)getResponse;
/*!
 *  判断content是否为NSArray
 *
 *  @return YES or NO
 */
- (BOOL)isArrayContent;
/*!
 *  失败的统一处理
 */
- (void)processError;

- (NSString *)message;

- (NSInteger)code;

- (id)content;



@end
