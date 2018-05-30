//
//  YTKUrlArgumentsFilter.h
//  shuxiang
//
//  Created by 方燕娇 on 16/11/11.
//  Copyright © 2016年 Addison. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

/**
 *  网络请求回调
 */
typedef void (^skSuccessBlock) (YTKBaseRequest *request);
typedef void (^skErrorBlock) (YTKBaseRequest *request);
typedef void (^skFailureBlock)(NSString *message);

//YTKRequest
@interface YTKUrlArgumentsFilter : YTKRequest

- (void)sk_startWithWithSuccessBlock: (skSuccessBlock) successBlock
                          errorBlock: (skErrorBlock) errorBlock
                        failureBlock: (skFailureBlock) failureBlock;
- (NSDictionary *)returnUrlArgumentsFilterParams:(NSDictionary *)urlArgumentsDict;

@end
