//
//  FeedbackFooter.m
//  parking
//
//  Created by Robert Xu on 2017/6/1.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "FeedbackFooter.h"

static const NSInteger kOccupyTag = 1001;

@interface FeedbackFooter ()

@property (strong, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UIButton *cameraButton1;
@property (weak, nonatomic) IBOutlet UIButton *cameraButton2;
@property (weak, nonatomic) IBOutlet UIButton *cameraButton3;

@property (strong, nonatomic) NSArray *buttonArray;

@end

@implementation FeedbackFooter

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
    
    //自定义
    self.buttonArray = @[ _cameraButton1, _cameraButton2, _cameraButton3];
}

- (IBAction)cameraAction:(id)sender {
    UIButton *button = (UIButton *)sender;
    if (self.delegate && [self.delegate respondsToSelector:@selector(feedbackFooterImageSource:)]) {
        [self.delegate feedbackFooterImageSource:button];
    }
}

- (NSInteger)nextButtonIndex {
    int i;
    for (i = 0; i < [self.buttonArray count]; i++) {
        UIButton *button = self.buttonArray[i];
        if (kOccupyTag != button.tag) {
            return i;
        }
    }
    return i;
}

@end
