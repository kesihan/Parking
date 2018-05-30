//
//  CreditService.m
//  parking
//
//  Created by Robert Xu on 2017/6/13.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "CreditService.h"
#import "GetUserHomeIntegral.h"
#import "PostUserHomeInPoint.h"

@implementation CreditService

- (void)getCreditListByUserID:(NSString *)userID pageIndex:(NSString *)pageIndex size:(NSString *)size resultBlock:(csCreditResultBlock)resultBlock {
    GetUserHomeIntegral *getUserHomeIntegral = [[GetUserHomeIntegral alloc] initWithUserID:userID pageIndex:pageIndex size:size];
    [getUserHomeIntegral startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        BOOL isOK = [request isOK];
        if (isOK) {
            CreditModel *creditModel = [CreditModel yy_modelWithJSON:request.content];
            resultBlock(isOK, [request message], creditModel);
        } else {
            resultBlock(isOK, [request message], nil);
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        resultBlock(NO, [request message], nil);
    }];
}

- (void)signDailyByUserID:(NSString *)userID resultBlock:(csCreditResultBlock)resultBlock {
    PostUserHomeInPoint *postUserHomeInPoint = [[PostUserHomeInPoint alloc] initWithUserID:userID];
    [postUserHomeInPoint startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        BOOL isOK = [request isOK];
        resultBlock(isOK, [request message], nil);
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        resultBlock(NO, [request message], nil);
    }];
}

@end
