//
//  CarFooter.m
//  parking
//
//  Created by Robert Xu on 2017/5/24.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "CarFooter.h"

@interface CarFooter ()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIButton *addCarButton;

@end

@implementation CarFooter

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self customInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self customInit];
    }
    return self;
}

- (void)customInit {
    
    [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    [self addSubview:self.contentView];
    self.contentView.frame = self.bounds;
    
    [self.addCarButton addTarget:self action:@selector(addCarAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addCarAction:(UIButton *)button {
    if (self.delegate && [self.delegate respondsToSelector:@selector(carFooterAddCarButtonClicked:)]) {
        [self.delegate carFooterAddCarButtonClicked:self.addCarButton];
    }
}

@end
