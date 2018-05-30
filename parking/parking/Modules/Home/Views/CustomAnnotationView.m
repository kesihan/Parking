//
//  CustomAnnotationView.m
//  parking
//
//  Created by Robert Xu on 2017/6/6.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "CustomAnnotationView.h"
#import "UIView+Helper.h"
#import "UIImage+Helper.h"

#define PADDING_LEFT        10
#define EXPAND_SCALE        1.1
#define PADDING_TOP_SCALE   6

@interface CustomAnnotationView ()

@property (assign, nonatomic) CGRect origRect;
@property (strong, nonatomic) UIView *subTitleView;

@end

@implementation CustomAnnotationView

// annotationType:(CUSPinAnnotationSizeAndColor)type
- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        //必须先设置图片，后续才能获得图片宽高继续处理
        self.image = [UIImage imageNamed:@"home_pin_green_small"];
        [self.imageView addSubview:self.titleLabel];
        
        CGRect imgRect = self.imageView.frame;
        self.subTitleView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imgRect) - PADDING_LEFT, CGRectGetMinY(imgRect) + (imgRect.size.width/PADDING_TOP_SCALE), PADDING_LEFT + (imgRect.size.width * EXPAND_SCALE) + 3, imgRect.size.width - (imgRect.size.width/PADDING_TOP_SCALE)*2)];
        self.subTitleView.backgroundColor = [UIColor whiteColor];
        self.subTitleView.layer.cornerRadius = 2;
        [self.subTitleView setDefaultShadow];
        [self addSubview:self.subTitleView];
        [self.subTitleView addSubview:self.subTitleLabel];
        [self bringSubviewToFront:self.imageView];
    }
    return self;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        CGRect imgRect = self.imageView.frame;
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(-1, 0, imgRect.size.width, imgRect.size.width)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = COL_DefaultFont_Size(9);
    }
    return _titleLabel;
}

- (UILabel *)subTitleLabel {
    if (!_subTitleLabel) {
        CGRect imgRect = self.imageView.frame;
        _subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(PADDING_LEFT, 0, (imgRect.size.width * EXPAND_SCALE) + 3, imgRect.size.width - (imgRect.size.width/PADDING_TOP_SCALE)*2)];
        _subTitleLabel.textAlignment = NSTextAlignmentCenter;
        _subTitleLabel.font = COL_DefaultFont_Size(9);
    }
    return _subTitleLabel;
}

- (void)setColor:(CUSPinAnnotationColor)color {
    switch (color) {
        case CUSAnnotationColorRed:
        {
            self.image = [UIImage imageNamed:@"home_pin_red_small"];
            [self.titleLabel setTextColor:COL_COLOR_ANNOTATION_RED];
            [self.subTitleLabel setTextColor:COL_COLOR_ANNOTATION_RED];
        }
            break;
            
        case CUSAnnotationColorGreen:
        {
            self.image = [UIImage imageNamed:@"home_pin_green_small"];
            [self.titleLabel setTextColor:COL_COLOR_ANNOTATION_GREEN];
            [self.subTitleLabel setTextColor:COL_COLOR_ANNOTATION_GREEN];
        }
            break;
            
        case CUSAnnotationColorYellow:
        {
            self.image = [UIImage imageNamed:@"home_pin_yellow_small"];
            [self.titleLabel setTextColor:COL_COLOR_ANNOTATION_ORANGE];
            [self.subTitleLabel setTextColor:COL_COLOR_ANNOTATION_ORANGE];
        }
            break;
        default:
            break;
    }
    if (color == CUSAnnotationColorRed) {
        self.subTitleView.hidden = YES;
    } else {
        self.subTitleView.hidden = NO;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if(self.selected == selected) {
        return;
    }

    if(selected) {
    }
    
    [super setSelected:selected animated:animated];
}

@end
