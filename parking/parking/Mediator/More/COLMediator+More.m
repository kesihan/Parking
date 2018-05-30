//
//  COLMediator+More.m
//  parking
//
//  Created by Robert Xu on 2017/5/19.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "COLMediator+More.h"

// 常量命名规则：
// Target：   kCOLMediatorTarget + 模块名（大写开头）      =  @"模块名（大写开头）"
// Action：   kCOLMediatorAction + 具体操作（大写开头）     =  @"具体操作"（小写开头）

static NSString * const kCOLMediatorTargetMore = @"More";

static NSString * const kCOLMediatorActionMoreController = @"moreController";

@implementation COLMediator (More)

// 方法命名规则：模块名（小写开头）+ 具体操作

// 更多
- (UIViewController *)moreController {
    UIViewController *controller = [self performTarget:kCOLMediatorTargetMore action:kCOLMediatorActionMoreController params:nil shouldCacheTarget:NO];
    if ([controller isKindOfClass:[UIViewController class]]) {
        return controller;
    } else {
        // 处理错误，具体看你想怎么做了...
        return [[UIViewController alloc] init];
    }
}

@end
