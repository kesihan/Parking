//
//  MyService.h
//  parking
//
//  Created by Robert Xu on 2017/5/18.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyCellModel.h"

@interface MyService : NSObject

//获取个人中心菜单
- (NSMutableArray <MyCellModel *>*)getMenu;
//有没有车
- (BOOL)hasCar;

@end
