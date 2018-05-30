//
//  AccountService.m
//  parking
//
//  Created by Robert Xu on 2017/5/23.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "AccountService.h"
#import "PostSmsSend.h"
#import "PostUserLogin.h"
#import "COLKVStorage.h"

static NSString * const kCOLUserInfoKey     = @"COL_USER_INFO_KEY";

@interface AccountService ()

@property (strong, nonatomic) PostSmsSend *postSmsSend;

@end

@implementation AccountService

- (NSArray *)getTitles {
    return @[@"头像", @"昵称", @"性别", @"手机号", @"生日", @"实名认证"];
}

- (void)sendSMSWithMobile:(NSString *)mobile resultBlock:(asBoolResultBlock)resultBlock {
    PostSmsSend *postSmsSend = [[PostSmsSend alloc] initWithMobile:mobile purpose:@"verify" message:@"{code}"];
    [postSmsSend startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        BOOL isOK = [request isOK];
        resultBlock(isOK);
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        resultBlock(NO);
    }];
}

- (void)loginWithMobile:(NSString *)mobile verify:(NSString *)verify resultBlock:(asUserResultBlock)resultBlock {
    PostUserLogin *postUserLogin = [[PostUserLogin alloc] initWithMobile:mobile verify:verify];
    [postUserLogin startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        BOOL isOK = [request isOK];
        if (isOK) {
            UserModel *userModel = [UserModel yy_modelWithJSON:request.content[0]];
            [AccountService updateUserModel:userModel];
            resultBlock(isOK, [request message],userModel);
        } else {
            resultBlock(isOK, [request message], nil);
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        resultBlock(NO, @"", nil);
    }];
}

//登录相关
+ (void)logout:(void(^)(void))callback {
    //清除登录信息
    [[COLKVStorage sharedSingleton] removeObjectForKey:kCOLUserInfoKey withBlock:^(NSString *key) {
        callback();
    }];
}

+ (BOOL)isLogin {
    return [[COLKVStorage sharedSingleton] containsObjectForKey:kCOLUserInfoKey];
}

+ (UserModel *)userModel {
    return (UserModel *)[[COLKVStorage sharedSingleton] objectForKey:kCOLUserInfoKey];
}

+ (void)updateUserModel:(UserModel *)userModel {
    [[COLKVStorage sharedSingleton] setObject:userModel forKey:kCOLUserInfoKey withBlock:^{
    }];
}

@end
