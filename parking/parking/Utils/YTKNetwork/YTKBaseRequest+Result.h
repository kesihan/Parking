//
//  YTKBaseRequest+Result.h
//  colourfullife
//
//  Created by Robert Xu on 16/5/23.
//  Copyright © 2016年 listcloud. All rights reserved.
//

#import <YTKNetwork/YTKBaseRequest.h>

@interface YTKBaseRequest (Result)

/*!
 *  返回结果
 *
 *  @return 返回的数据
 */
- (id)result;

/*!
 *  状态信息
 *
 *  @return 返回文字描述信息
 */
- (NSString *)message;

/*!
 *  content内容
 *
 *  @return content内容
 */
- (id)content;

/*!
 *  返回的状态吗
 *
 *  @return 状态码
 */
- (NSInteger)responseCode;

/*!
 *  是否为正常数据
 *
 *  @return 正常YES，异常NO
 */
- (BOOL)isCorrect;

/*!
 *  返回code是否为0
 *
 *  @return 为0为YES，否则NO
 */
- (BOOL)isSuccess;

/*!
 *  返回是否成功
 *
 *  @return 满足isCorrect和isSuccess为成功
 */
- (BOOL)isOK;

@end
