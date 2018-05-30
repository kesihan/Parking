//
//  QAService.h
//  parking
//
//  Created by Robert Xu on 2017/6/7.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QACellModel.h"

@interface QAService : NSObject

//获取标题列表
- (NSMutableArray *)getMenu;

@end
