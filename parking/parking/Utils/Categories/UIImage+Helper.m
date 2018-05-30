//
//  UIImage+Helper.m
//  parking
//
//  Created by Robert Xu on 2017/5/26.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "UIImage+Helper.h"

@implementation UIImage (Helper)

// 返回一个带有背景色的图片
+(UIImage *)imageWithBgColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
