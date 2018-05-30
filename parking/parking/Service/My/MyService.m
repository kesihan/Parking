//
//  MyService.m
//  parking
//
//  Created by Robert Xu on 2017/5/18.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "MyService.h"
#import "AccountService.h"

@implementation MyService

- (NSMutableArray <MyCellModel *>*)getMenu {
    
    NSMutableArray *menu = [NSMutableArray arrayWithCapacity:6];
    [menu addObject:[MyCellModel modelWithImage:@"我的钱包" title:@"我的钱包"]];
    [menu addObject:[MyCellModel modelWithImage:@"我的车辆" title:@"我的车辆"]];
    
    [menu addObject:[MyCellModel modelWithImage:@"停车记录" title:@"停车记录"]];
    [menu addObject:[MyCellModel modelWithImage:@"我的收藏" title:@"我的收藏"]];
    [menu addObject:[MyCellModel modelWithImage:@"消息中心" title:@"消息中心"]];
    [menu addObject:[MyCellModel modelWithImage:@"邀请有奖" title:@"邀请有奖"]];
    [menu addObject:[MyCellModel modelWithImage:@"更多" title:@"更多"]];
    return menu;
}

- (BOOL)hasCar {
    NSInteger carNumber = [AccountService userModel].cartotal;
    return (carNumber > 0 ? YES : NO);
}

@end
