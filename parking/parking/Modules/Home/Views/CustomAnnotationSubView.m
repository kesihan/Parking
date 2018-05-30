//
//  CustomAnnotationSubView.m
//  parking
//
//  Created by Robert Xu on 2017/6/6.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "CustomAnnotationSubView.h"

@interface CustomAnnotationSubView ()

@property (strong, nonatomic) IBOutlet UIView *contentView;

@end

@implementation CustomAnnotationSubView

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
}

- (IBAction)touchAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(customAnnotationSubViewClicked:)]) {
        [self.delegate customAnnotationSubViewClicked:self];
    }
}

@end
