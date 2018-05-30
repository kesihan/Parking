//
//  MoreService.h
//  parking
//
//  Created by Robert Xu on 2017/5/22.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MoreCellModel.h"

@interface MoreService : NSObject

//获取更多菜单
- (NSMutableArray <MoreCellModel *>*)getMenu;

@end
