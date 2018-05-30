//
//  ActivitysModel.m
//  parking
//
//  Created by 柯思汉 on 2018/3/19.
//  Copyright © 2018年 huafangcloud. All rights reserved.
//

#import "ActivitysModel.h"
@implementation ActivitysItem
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"ID" : @"id",
             @"add_time" : @"add_time",
             @"give" : @"give",
             @"reality" : @"reality",
             };
}
@end
@implementation ActivitysModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"content":@"ActivitysItem",
             };
}
@end
