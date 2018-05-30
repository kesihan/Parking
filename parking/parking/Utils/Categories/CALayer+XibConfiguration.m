//
//  CALayer+XibConfiguration.m
//  parking
//
//  Created by Robert Xu on 2017/5/31.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//  https://stackoverflow.com/questions/12301256/is-it-possible-to-set-uiview-border-properties-from-interface-builder/17993890#17993890

#import "CALayer+XibConfiguration.h"

@implementation CALayer (XibConfiguration)

-(void)setBorderUIColor:(UIColor*)color
{
    self.borderColor = color.CGColor;
}

-(UIColor*)borderUIColor
{
    return [UIColor colorWithCGColor:self.borderColor];
}

@end
