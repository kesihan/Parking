//
//  COLSearchBar.m
//  parking
//
//  Created by Robert Xu on 2017/5/25.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "COLSearchBar.h"
#import "UITextField+Helper.h"
//home_button_voice_nor
@interface COLSearchBar ()<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIView *contentView;

@end

@implementation COLSearchBar

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
    self.textInput.delegate = self;
//    
    //圆边
    self.layer.cornerRadius = 4.0f;
    self.layer.borderColor = COL_COLOR_SEPARATOR.CGColor;
    self.layer.borderWidth = 1.0f;
    
    [self.textInput setPlaceholderColor:COL_COLOR_TEXT_DEFAULT_LIGHT];
}

#pragma  mark uitextfiled delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;
{
    NSLog(@"点中搜索框");
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)microphonebtn:(id)sender {
    NSLog(@"选中麦克风");
}


@end
