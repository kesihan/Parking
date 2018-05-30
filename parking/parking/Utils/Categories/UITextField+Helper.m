//
//  UITextField+Helper.m
//  parking
//
//  Created by Robert Xu on 2017/5/27.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "UITextField+Helper.h"

@implementation UITextField (Helper)

- (void)setPlaceholder:(NSString *)placeholder color:(UIColor *)color font:(UIFont *)font {
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:placeholder];
    
    NSRange range = NSMakeRange(0, [placeholder length] - 1);
    //设置字体
    [attrStr addAttribute:NSFontAttributeName value:font range:range];
    //设置文字颜色
    [attrStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    
    [self setAttributedPlaceholder:attrStr];
}

- (void)setPlaceholderColor:(UIColor *)color {
    [self setValue:color forKeyPath:@"_placeholderLabel.textColor"];
    
}

- (void)setPlaceholderFont:(UIFont *)font {
    [self setValue:font forKeyPath:@"_placeholderLabel.font"];
}

- (void)setPlaceholderColor:(UIColor *)color font:(UIFont *)font {
    [self setPlaceholderColor:color];
    [self setPlaceholderFont:font];
}

@end
