//
//  COLToast.m
//  parking
//
//  Created by Robert Xu on 2017/6/12.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "COLToast.h"
#import "JRToast.h"

@implementation COLToast

+ (void)showToast:(NSString *)toast {
    [JRToast showWithText:toast];
}

@end
