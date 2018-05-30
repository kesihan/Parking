//
//  COLFirstLaunch.m
//  parking
//
//  Created by Robert Xu on 2017/6/12.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "COLFirstLaunch.h"

static NSString * const kCOLFirstLaunch = @"kCOLFirstLaunch";

@implementation COLFirstLaunch

+ (BOOL)isFirstLaunch {
    NSString *value = [[NSUserDefaults  standardUserDefaults] objectForKey:kCOLFirstLaunch];
    if ([value isEqualToString:@"1"]) {
        return NO;
    } else {
        [[NSUserDefaults  standardUserDefaults] setValue:@"1" forKey:kCOLFirstLaunch];
        [[NSUserDefaults  standardUserDefaults] synchronize];
        return YES;
    }
}

@end
