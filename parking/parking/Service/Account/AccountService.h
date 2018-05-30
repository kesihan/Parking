//
//  AccountService.h
//  parking
//
//  Created by Robert Xu on 2017/5/23.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

typedef void (^asBoolResultBlock) (BOOL success);
typedef void (^asUserResultBlock) (BOOL success, NSString *message, UserModel *userModel);

@interface AccountService : NSObject

//获取标题列表
- (NSArray *)getTitles;
//发送验证短信
- (void)sendSMSWithMobile:(NSString *)mobile resultBlock:(asBoolResultBlock)resultBlock;
//登录
- (void)loginWithMobile:(NSString *)mobile verify:(NSString *)verify resultBlock:(asUserResultBlock)resultBlock;
//清除登录信息
+ (void)logout:(void(^)(void))callback;
//是否已经登录
+ (BOOL)isLogin;
//获取用户信息
+ (UserModel *)userModel;
//更新用户信息
+ (void)updateUserModel:(UserModel *)userModel;


@end
