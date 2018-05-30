//
//  QAService.m
//  parking
//
//  Created by Robert Xu on 2017/6/7.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "QAService.h"

@implementation QAService

- (NSMutableArray *)getMenu {
    NSMutableArray *menu = [NSMutableArray arrayWithCapacity:2];
    [menu addObject:[QACellModel modelWithTitle:@"关于积分"]];
    [menu addObject:[QACellModel modelWithTitle:@"关于车辆绑定"]];
    return menu;
}

@end
