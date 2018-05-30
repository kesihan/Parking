//
//  COLMediator+Account.m
//  parking
//
//  Created by Robert Xu on 2017/5/23.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "COLMediator+Account.h"

// 常量命名规则：
// Target：   kCOLMediatorTarget + 模块名（大写开头）      =  @"模块名（大写开头）"
// Action：   kCOLMediatorAction + 具体操作（大写开头）     =  @"具体操作"（小写开头）

static NSString * const kCOLMediatorTargetAccount = @"Account";

static NSString * const kCOLMediatorActionAccountController = @"accountController";

@implementation COLMediator (Account)

// 方法命名规则：模块名（小写开头）+ 具体操作

// 账号信息
- (UIViewController *)accountController {
    UIViewController *controller = [self performTarget:kCOLMediatorTargetAccount action:kCOLMediatorActionAccountController params:nil shouldCacheTarget:NO];
    if ([controller isKindOfClass:[UIViewController class]]) {
        return controller;
    } else {
        // 处理错误，具体看你想怎么做了...
        return [[UIViewController alloc] init];
    }
}

@end
