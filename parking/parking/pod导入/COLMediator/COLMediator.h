//
//  COLMediator.h
//  COLMediator
//
//  Created by Robert Xu on 2017/3/30.
//  Copyright © 2017年 casa. All rights reserved.
//  注：拷贝并修改自 casa 的 CTMediator
//  详情参考：https://casatwy.com/modulization_in_action.html
//

#import <Foundation/Foundation.h>

@interface COLMediator : NSObject

+ (instancetype)sharedInstance;

// 远程App调用入口
- (id)performActionWithUrl:(NSURL *)url completion:(void(^)(NSDictionary *info))completion;
// 本地组件调用入口
- (id)performTarget:(NSString *)targetName action:(NSString *)actionName params:(NSDictionary *)params shouldCacheTarget:(BOOL)shouldCacheTarget;
- (void)releaseCachedTargetWithTargetName:(NSString *)targetName;

@end
