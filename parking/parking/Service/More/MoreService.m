//
//  MoreService.m
//  parking
//
//  Created by Robert Xu on 2017/5/22.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "MoreService.h"

@implementation MoreService

- (NSMutableArray <MoreCellModel *>*)getMenu {
    
    NSMutableArray *menu = [NSMutableArray arrayWithCapacity:5];
    [menu addObject:[MoreCellModel modelWithTitle:@"常见问题" extInfo:@""]];
    [menu addObject:[MoreCellModel modelWithTitle:@"给我评分" extInfo:@""]];
    [menu addObject:[MoreCellModel modelWithTitle:@"意见反馈" extInfo:@""]];
    [menu addObject:[MoreCellModel modelWithTitle:@"清理缓存" extInfo:@"2.1M"]];
    [menu addObject:[MoreCellModel modelWithTitle:@"关于我们" extInfo:@""]];
    return menu;
}


@end
