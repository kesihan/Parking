//
//  UserData.m
//  tuanhuiyuan
//
//  Created by zccl on 15/7/1.
//  Copyright (c) 2015年 dcf. All rights reserved.
//

#import "UserData.h"

@implementation UserData

+(void)setType:(NSString*)type;
{
    
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    [userdefaults setObject:type forKey:@"Cartype"];
    [userdefaults synchronize];
}
+ (NSString *)getType;
{
    return  [[NSUserDefaults standardUserDefaults] objectForKey:@"Cartype"];

}

+(void)setIntime:(NSString*)intime;
{
    
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    [userdefaults setObject:intime forKey:@"intime"];
    [userdefaults synchronize];
}
+ (NSString *)getIntime;
{
    return  [[NSUserDefaults standardUserDefaults] objectForKey:@"intime"];
    
}

+(void)setHistorical:(NSDictionary*)historical
{
    
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    [userdefaults setObject:historical forKey:@"historical"];
    [userdefaults synchronize];
}
+(NSDictionary *)getHistorical
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"historical"];
}
+ (void)removeHistory
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"historical"];
}

@end
