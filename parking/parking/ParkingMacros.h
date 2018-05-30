//
//  ParkingMacros.h
//  parking
//
//  Created by Robert Xu on 2017/5/18.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#ifndef ParkingMacros_h
#define ParkingMacros_h

//防止循环引用
#define COLWeakSelf(type)  __weak typeof(type) weak##type = type;
#define COLStrongSelf(type)  __strong typeof(type) type = weak##type;

//调试输出(fix iOS10)
#ifdef DEBUG
#define NSLog(format, ...) printf("[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#else
#define NSLog(format, ...)
#endif

#define COL_SCREEN_WIDTH    [[UIScreen mainScreen] bounds].size.width
#define COL_SCREEN_HEIGHT   [[UIScreen mainScreen] bounds].size.height

//颜色s
#define RGBCOLOR(r,g,b) \
[UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:1.f]

#define RGBACOLOR(r,g,b,a) \
[UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:a]

#define UIColorFromRGB(rgbValue) \
[UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:1.0]

#define UIColorFromRGBA(rgbValue, alphaValue) \
[UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:alphaValue]

//字体
#define COL_Font_PingFang_SC_Regular @"PingFang-SC-Regular"
#define COL_DefaultFont_Size(_size_) [UIFont fontWithName:COL_Font_PingFang_SC_Regular size:_size_]


//颜色
#define COL_COLOR_LIGHT_BLUE            UIColorFromRGB(0x3EB4F8)
#define COL_COLOR_TEXT_DEFAULT          UIColorFromRGB(0x111111)
#define COL_COLOR_TEXT_DEFAULT_LIGHT    UIColorFromRGB(0x8A8A8A)
#define COL_COLOR_SEPARATOR             UIColorFromRGB(0xE1E1E1)

//标注颜色
#define COL_COLOR_ANNOTATION_RED        UIColorFromRGB(0xF44A28)
#define COL_COLOR_ANNOTATION_ORANGE     UIColorFromRGB(0xF6A905)
#define COL_COLOR_ANNOTATION_GREEN      UIColorFromRGB(0x1ECE37)

#define DEVICE_WIDTH ([UIScreen mainScreen].bounds.size.width)//设备宽
#define DEVICE_HEIGHT ([UIScreen mainScreen].bounds.size.height)//设备高
// 颜色
#define KF_RGB(r, g, b)  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

#pragma mark- 弱引用

#define JF_WS(weakSelf) __weak __typeof(&*self)weakSelf = self;

#endif /* ParkingMacros_h */
