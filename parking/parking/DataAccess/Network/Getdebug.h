//
//  Getdebug.h
//  parking
//
//  Created by 柯思汉 on 2018/3/5.
//  Copyright © 2018年 huafangcloud. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>
#import "YTKUrlArgumentsFilter.h"
@interface Getdebug : YTKUrlArgumentsFilter
- (id)initWithuserID:(NSString *)userID pageSize:(NSString *)pageSize nums:(NSString *)nums;
@end
