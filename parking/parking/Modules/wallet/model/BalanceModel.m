//
//  BalanceModel.m
//  parking
//
//  Created by 柯思汉 on 2018/3/15.
//  Copyright © 2018年 huafangcloud. All rights reserved.
//

#import "BalanceModel.h"

@implementation BalanceModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"content":@"BalanceItem",
             };
}
@end

@implementation BalanceItem
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"ID" : @"id",
             @"money" : @"money",
             @"add_time" : @"add_time",
             @"userID" : @"userID",
             @"type":@"type",
             };
}
@end
