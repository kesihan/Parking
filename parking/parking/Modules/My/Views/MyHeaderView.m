//
//  MyHeaderView.m
//  parking
//
//  Created by Robert Xu on 2017/5/18.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "MyHeaderView.h"

@interface MyHeaderView ()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImage;

@end

@implementation MyHeaderView

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
    [self.name setText:[AccountService userModel].nickName];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction:)];
    [self.avatarImage addGestureRecognizer:tap];
    self.avatarImage.userInteractionEnabled = YES;
    [self.avatarImage sd_setImageWithURL:[NSURL URLWithString:[AccountService userModel].headImage] placeholderImage:[UIImage imageNamed:@"Identity_icon_name_nor"]];
}

- (void)clickAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(myHeaderViewClickAvatar)]) {
        [self.delegate myHeaderViewClickAvatar];
    }
}

@end
