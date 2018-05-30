//
//  MyCellModel.m
//  parking
//
//  Created by Robert Xu on 2017/5/18.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "MyCellModel.h"

@implementation MyCellModel

+ (MyCellModel *)modelWithImage:(NSString *)image title:(NSString *)title {
    MyCellModel *model = [[MyCellModel alloc] init];
    model.image = image;
    model.title = title;
    return model;
}

@end
