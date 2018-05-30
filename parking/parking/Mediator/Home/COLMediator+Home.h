//
//  COLMediator+Home.h
//  parking
//
//  Created by Robert Xu on 2017/5/18.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "COLMediator.h"
#import <UIKit/UIKit.h>

@interface COLMediator (Home)

//首页地图
- (UIViewController *)homeController;
// 首页导航界面
- (UIViewController *)homeNaviControllerWithParams:(NSDictionary *)params;

@end
