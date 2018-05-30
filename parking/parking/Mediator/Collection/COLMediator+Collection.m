//
//  COLMediator+Collection.m
//  parking
//
//  Created by Robert Xu on 2017/5/24.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "COLMediator+Collection.h"

// 常量命名规则：
// Target：   kCOLMediatorTarget + 模块名（大写开头）      =  @"模块名（大写开头）"
// Action：   kCOLMediatorAction + 具体操作（大写开头）     =  @"具体操作"（小写开头）

static NSString * const kCOLMediatorTargetCollection = @"Collection";

static NSString * const kCOLMediatorActionCollectionController = @"collectionController";

@implementation COLMediator (Collection)

// 方法命名规则：模块名（小写开头）+ 具体操作

// 我的收藏
- (UIViewController *)collectionController {
    UIViewController *controller = [self performTarget:kCOLMediatorTargetCollection action:kCOLMediatorActionCollectionController params:nil shouldCacheTarget:NO];
    if ([controller isKindOfClass:[UIViewController class]]) {
        return controller;
    } else {
        // 处理错误，具体看你想怎么做了...
        return [[UIViewController alloc] init];
    }
}

@end
