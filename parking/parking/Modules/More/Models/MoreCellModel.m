//
//  MoreCellModel.m
//  parking
//
//  Created by Robert Xu on 2017/5/22.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "MoreCellModel.h"

@implementation MoreCellModel

+ (MoreCellModel *)modelWithTitle:(NSString *)title extInfo:(NSString *)extInfo {
    MoreCellModel *model = [[MoreCellModel alloc] init];
    model.title = title;
    model.extInfo = extInfo;
    return model;
}

@end
