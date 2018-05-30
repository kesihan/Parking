//
//  COLMediator+Identity.h
//  parking
//
//  Created by Robert Xu on 2017/5/19.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "COLMediator.h"
#import <UIKit/UIKit.h>

@interface COLMediator (Identity)

// 实名认证
- (UIViewController *)identityController;
// 实名认证状态
- (UIViewController *)identityStatusController;

@end
