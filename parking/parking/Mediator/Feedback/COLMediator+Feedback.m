//
//  COLMediator+Feedback.m
//  parking
//
//  Created by Robert Xu on 2017/5/25.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "COLMediator+Feedback.h"

// 常量命名规则：
// Target：   kCOLMediatorTarget + 模块名（大写开头）      =  @"模块名（大写开头）"
// Action：   kCOLMediatorAction + 具体操作（大写开头）     =  @"具体操作"（小写开头）

static NSString * const kCOLMediatorTargetFeedback = @"Feedback";

static NSString * const kCOLMediatorActionFeedbackController = @"feedbackController";

@implementation COLMediator (Feedback)

// 方法命名规则：模块名（小写开头）+ 具体操作

// 意见反馈
- (UIViewController *)feedbackController {
    UIViewController *controller = [self performTarget:kCOLMediatorTargetFeedback action:kCOLMediatorActionFeedbackController params:nil shouldCacheTarget:NO];
    if ([controller isKindOfClass:[UIViewController class]]) {
        return controller;
    } else {
        // 处理错误，具体看你想怎么做了...
        return [[UIViewController alloc] init];
    }
}

@end
