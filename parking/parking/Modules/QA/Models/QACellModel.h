//
//  QACellModel.h
//  parking
//
//  Created by Robert Xu on 2017/6/7.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QACellModel : NSObject

@property (copy, nonatomic) NSString *title;

+ (QACellModel *)modelWithTitle:(NSString *)title;

@end
