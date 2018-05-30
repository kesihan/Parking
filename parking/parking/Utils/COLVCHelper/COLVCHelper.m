//
//  COLVCHelper.m
//  colourfullife
//
//  Created by Robert Xu on 16/4/5.
//  Copyright © 2016年 listcloud. All rights reserved.
//

#import "COLVCHelper.h"
#import <UIKit/UIKit.h>

@implementation COLVCHelper

+ (void)col_switchRootVCToSBName:(NSString *)sbName identifier:(NSString *)ident {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:sbName bundle:nil];
    UIViewController *vc = (UIViewController *)[sb instantiateViewControllerWithIdentifier:ident];
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [window makeKeyAndVisible];
    [window setRootViewController:vc];
}

+ (id)col_vcFromSBName:(NSString *)sbName identifier:(NSString *)ident {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:sbName bundle:nil];
    return [sb instantiateViewControllerWithIdentifier:ident];
}


@end
