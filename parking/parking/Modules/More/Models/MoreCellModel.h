//
//  MoreCellModel.h
//  parking
//
//  Created by Robert Xu on 2017/5/22.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MoreCellModel : NSObject

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *extInfo;

+ (MoreCellModel *)modelWithTitle:(NSString *)title extInfo:(NSString *)extInfo;

@end
