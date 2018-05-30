//
//  COLMediator+Home.m
//  parking
//
//  Created by Robert Xu on 2017/5/18.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "COLMediator+Home.h"

// 常量命名规则：
// Target：   kCOLMediatorTarget + 模块名（大写开头）      =  @"模块名（大写开头）"
// Action：   kCOLMediatorAction + 具体操作（大写开头）     =  @"具体操作"（小写开头）

static NSString * const kCOLMediatorTargetHome = @"Home";

static NSString * const kCOLMediatorActionHomeController = @"homeController";

static NSString * const kCOLMediatorActionHomeNaviController = @"homeNaviController";

@implementation COLMediator (Home)

// 方法命名规则：模块名（小写开头）+ 具体操作

// 首页地图
- (UIViewController *)homeController {
    UIViewController *controller = [self performTarget:kCOLMediatorTargetHome action:kCOLMediatorActionHomeController params:nil shouldCacheTarget:NO];
    if ([controller isKindOfClass:[UIViewController class]]) {
        return controller;
    } else {
        // 处理错误，具体看你想怎么做了...
        return [[UIViewController alloc] init];
    }
}

// 首页导航界面
- (UIViewController *)homeNaviControllerWithParams:(NSDictionary *)params {
    UIViewController *controller = [self performTarget:kCOLMediatorTargetHome action:kCOLMediatorActionHomeNaviController params:params shouldCacheTarget:NO];
    if ([controller isKindOfClass:[UIViewController class]]) {
        return controller;
    } else {
        // 处理错误，具体看你想怎么做了...
        return [[UIViewController alloc] init];
    }
}

@end
