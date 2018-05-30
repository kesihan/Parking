//
//  UserData.h
//  tuanhuiyuan
//
//  Created by zccl on 15/7/1.
//  Copyright (c) 2015年 dcf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserData : NSObject

+(void)setType:(NSString*)type;
+ (NSString*)getType;
+(void)setIntime:(NSString*)intime;
+ (NSString *)getIntime;
//浏览历史记录
+(void)setHistorical:(NSDictionary*)historical;
+(NSDictionary *)getHistorical;
+ (void)removeHistory;
@end
