//
//  UITextField+Helper.h
//  parking
//
//  Created by Robert Xu on 2017/5/27.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Helper)

- (void)setPlaceholderColor:(UIColor *)color;
- (void)setPlaceholderFont:(UIFont *)font;
- (void)setPlaceholderColor:(UIColor *)color font:(UIFont *)font;
- (void)setPlaceholder:(NSString *)placeholder color:(UIColor *)color font:(UIFont *)font;

@end
