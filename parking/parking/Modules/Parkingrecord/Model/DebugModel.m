//
//  DebugModel.m
//  parking
//
//  Created by 柯思汉 on 2018/3/6.
//  Copyright © 2018年 huafangcloud. All rights reserved.
//

#import "DebugModel.h"

@implementation DebugModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"content":@"DebugItem",
             };
}
@end

@implementation DebugItem
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"add_time" : @"add_time",
             @"carport_id" : @"carport_id",
             @"charge_number" : @"charge_number",
             @"ID" : @"id",
             @"image" :@"image",
             @"in_time" : @"in_time",
             @"license_plate" : @"license_plate",
             @"money":@"money",
             @"name" : @"name",
             @"operator_id":@"operator_id",
             @"out_time" : @"out_time",
             @"parking_number" : @"parking_number",
             @"pay_time":@"pay_time",
             @"status" : @"status",
             @"upload_id":@"upload_id",
             @"longtime":@"longtime",
             };
}
@end
