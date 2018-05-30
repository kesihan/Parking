//
//  UIView+Helper.m
//  parking
//
//  Created by Robert Xu on 2017/5/26.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "UIView+Helper.h"

@implementation UIView (Helper)

- (void)setDefaultShadow {
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.2f;
    self.layer.shadowOffset = CGSizeMake(0,0);
}

@end
