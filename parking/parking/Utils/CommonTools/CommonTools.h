//
//  CommonTools.h
//  parking
//
//  Created by Robert Xu on 2017/6/16.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, CUSPinAnnotationColor){
    CUSAnnotationColorRed = 0,          ///< 红
    CUSAnnotationColorYellow = 1,     ///< 黄
    CUSAnnotationColorGreen = 2      ///< 绿
};

@interface CommonTools : NSObject

+ (NSAttributedString *)freeLabelAttributedStringWithFree:(NSInteger)free total:(NSInteger)total;
+ (CUSPinAnnotationColor)getColorByFree:(NSInteger)free total:(NSInteger)total;
//米转公里
+ (NSString *)normalizedRemainDistance:(NSInteger)remainDistance;
//秒转小时、分
+ (NSString *)normalizedRemainTime:(NSInteger)remainTime;

@end
