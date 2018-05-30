//
//  CommonTools.m
//  parking
//
//  Created by Robert Xu on 2017/6/16.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "CommonTools.h"

@implementation CommonTools

+ (NSAttributedString *)freeLabelAttributedStringWithFree:(NSInteger)free total:(NSInteger)total {
    
    CUSPinAnnotationColor colorNumber = [CommonTools getColorByFree:free total:total];
    UIColor *color = COL_COLOR_ANNOTATION_GREEN;
    switch (colorNumber) {
        case CUSAnnotationColorRed:
            color = COL_COLOR_ANNOTATION_RED;
            break;
        case CUSAnnotationColorYellow:
            color = COL_COLOR_ANNOTATION_ORANGE;
            break;
        case CUSAnnotationColorGreen:
            color = COL_COLOR_ANNOTATION_GREEN;
            break;
        default:
            break;
    }
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    NSString *str0 = @"空：";
    NSDictionary *dictAttr0 = @{NSFontAttributeName:COL_DefaultFont_Size(14), NSForegroundColorAttributeName:UIColorFromRGB(0x8A8A8A)};
    NSAttributedString *attr0 = [[NSAttributedString alloc] initWithString:str0 attributes:dictAttr0];
    [attributedString appendAttributedString:attr0];
    
    NSString *str1 = [NSString stringWithFormat:@"%ld", (long)free];
    NSDictionary *dictAttr1 = @{NSFontAttributeName:COL_DefaultFont_Size(14), NSForegroundColorAttributeName:color};
    NSAttributedString *attr1 = [[NSAttributedString alloc] initWithString:str1 attributes:dictAttr1];
    [attributedString appendAttributedString:attr1];
    
    NSString *str2 = [NSString stringWithFormat:@" / %ld", (long)total];
    NSDictionary *dictAttr2 = @{NSFontAttributeName:COL_DefaultFont_Size(11), NSForegroundColorAttributeName:UIColorFromRGB(0x111111)};
    NSAttributedString *attr2 = [[NSAttributedString alloc] initWithString:str2 attributes:dictAttr2];
    [attributedString appendAttributedString:attr2];
    return attributedString;
}


/**
 *  判断规则
 *  红色0：停车场的空车位数 = 0
 *  橙色1：停车场的空车位数 <= 30%
 *  绿色2：停车场的空车位数 > 30%
 */

+ (CUSPinAnnotationColor)getColorByFree:(NSInteger)free total:(NSInteger)total {
    
    CGFloat scale = (CGFloat)free / (CGFloat)total ;
    CUSPinAnnotationColor color  = CUSAnnotationColorRed;
    if (0 == free) {
        color  = CUSAnnotationColorRed;
    } else if (scale <= 0.3) {
        color  = CUSAnnotationColorYellow;
    } else if (scale > 0.3) {
        color = CUSAnnotationColorGreen;
    }
    return color;
}

+ (NSString *)normalizedRemainDistance:(NSInteger)remainDistance
{
    if (remainDistance < 0)
    {
        return @"";
    }
    
    if (remainDistance >= 1000)
    {
        CGFloat kiloMeter = remainDistance / 1000.0;
        
        if (remainDistance % 1000 >= 100)
        {
            kiloMeter -= 0.05f;
            return [NSString stringWithFormat:@"%.1f公里", kiloMeter];
        }
        else
        {
            return [NSString stringWithFormat:@"%.0f公里", kiloMeter];
        }
    }
    else
    {
        return [NSString stringWithFormat:@"%ld米", (long)remainDistance];
    }
}

+ (NSString *)normalizedRemainTime:(NSInteger)remainTime
{
    if (remainTime < 0)
    {
        return @"";
    }
    
    if (remainTime < 60)
    {
        return [NSString stringWithFormat:@"< 1分钟"];
    }
    else if (remainTime >= 60 && remainTime < 60*60)
    {
        return [NSString stringWithFormat:@"%ld分钟", (long)remainTime/60];
    }
    else
    {
        NSInteger hours = remainTime / 60 / 60;
        NSInteger minute = remainTime / 60 % 60;
        if (minute == 0)
        {
            return [NSString stringWithFormat:@"%ld小时", (long)hours];
        }
        else
        {
            return [NSString stringWithFormat:@"%ld小时%ld分钟", (long)hours, (long)minute];
        }
    }
}

@end
