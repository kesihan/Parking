//
//  QACellModel.m
//  parking
//
//  Created by Robert Xu on 2017/6/7.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "QACellModel.h"

@implementation QACellModel

+ (QACellModel *)modelWithTitle:(NSString *)title {
    QACellModel *model = [[QACellModel alloc] init];
    model.title = title;
    return model;
}

@end
