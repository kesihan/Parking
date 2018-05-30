//
//  MyCellModel.h
//  parking
//
//  Created by Robert Xu on 2017/5/18.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyCellModel : NSObject

@property (copy, nonatomic) NSString *image;
@property (copy, nonatomic) NSString *title;

+ (MyCellModel *)modelWithImage:(NSString *)image title:(NSString *)title;

@end
