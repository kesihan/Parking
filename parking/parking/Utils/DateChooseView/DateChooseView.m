//
//  DateChooseView.m
//  shuxiang
//
//  Created by 陈嘉贤 on 2016/12/29.
//  Copyright © 2016年 Addison. All rights reserved.
//

#import "DateChooseView.h"

#define kDateViewHeight 260
#define kToolHeight 44

#define DATE_CHOOSE_VIEW_DEVICE_WIDTH ([UIScreen mainScreen].bounds.size.width)//设备宽
#define DATE_CHOOSE_VIEW_DEVICE_HEIGHT ([UIScreen mainScreen].bounds.size.height)//设备高

@interface DateChooseView()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) NSDate *inputDate;

@end

@implementation DateChooseView

- (instancetype)init
{
    self = [super init];
    if (self) {
    
        [self setFrame:CGRectMake(0, DATE_CHOOSE_VIEW_DEVICE_HEIGHT, DATE_CHOOSE_VIEW_DEVICE_WIDTH, DATE_CHOOSE_VIEW_DEVICE_HEIGHT)];
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickView:)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }
    return self;
}

- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, DATE_CHOOSE_VIEW_DEVICE_HEIGHT - kDateViewHeight, DATE_CHOOSE_VIEW_DEVICE_WIDTH, kDateViewHeight)];
        _contentView.backgroundColor = [UIColor lightGrayColor];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DATE_CHOOSE_VIEW_DEVICE_WIDTH, kToolHeight)];
        view.backgroundColor = [UIColor whiteColor];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(DATE_CHOOSE_VIEW_DEVICE_WIDTH - 60 - 15, 7, 60, 30)];
        [button setTitle:@"确定" forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor orangeColor]];
        [button addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        
        [_contentView addSubview:view];
        [_contentView addSubview:self.datePicker];
        [self addSubview:_contentView];
        
    }
    return _contentView;
}

- (UIDatePicker *)datePicker
{
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, kToolHeight, DATE_CHOOSE_VIEW_DEVICE_WIDTH, kDateViewHeight - kToolHeight)];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        NSLocale *locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
        _datePicker.locale = locale;
        if (self.inputDate) {
            [_datePicker setDate:self.inputDate];
        }
        
    }
    return _datePicker;
}

#pragma mark - click method
#pragma mark -

- (void)confirm:(UIButton *)sender
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd";
    
    NSDate *now =[formatter dateFromString:[formatter stringFromDate:[NSDate date]]];
    
    //0：当前日期之后不能选择  1：当天日期之后可以选择
    if (self.isAllChoose)
    {
        [self.delegate clickConfirm:[formatter stringFromDate:_datePicker.date]];
        [self hide];
    }
    else{
        if ([_datePicker.date compare:now] == NSOrderedAscending) {
            [self.delegate clickConfirm:[formatter stringFromDate:_datePicker.date]];
            [self hide];
            
        }else{
            
//            [SKHud sk_showTipHudForm:self withText:@"请填写正确日期" animated:YES];
        }
    }
    
    
    
    
}

// 点击背景
- (void)clickView:(UITapGestureRecognizer *)tap
{
    [self hide];
}

// 子视图不相应点击
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isDescendantOfView:_contentView]) {
        return NO;
    }
    return YES;
}

#pragma mark - view Animation

- (void)showWithDate:(NSString *)dateStr;
{
    if (dateStr != nil && [dateStr length] > 0) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = @"yyyy-MM-dd";
        NSDate *date = [formatter dateFromString:dateStr];
        self.inputDate = date;
        
    }

    [self setFrame:CGRectMake(0, 0, DATE_CHOOSE_VIEW_DEVICE_WIDTH, DATE_CHOOSE_VIEW_DEVICE_HEIGHT)];
    CGRect contentViewFrame = self.contentView.frame;
    self.contentView.frame = CGRectMake(contentViewFrame.origin.x, DATE_CHOOSE_VIEW_DEVICE_HEIGHT, contentViewFrame.size.width, contentViewFrame.size.height);
    [UIView animateWithDuration:0.5 animations:^{
        
        self.contentView.frame = CGRectMake(contentViewFrame.origin.x, DATE_CHOOSE_VIEW_DEVICE_HEIGHT - kDateViewHeight, contentViewFrame.size.width, contentViewFrame.size.height);
        
    } completion:^(BOOL finished) {
        
    }];
}

/**
 * 地址选择框移动并销毁
 */
- (void)hide
{
    CGRect mainViewFrame = self.contentView.frame;
    [UIView animateWithDuration:0.5 animations:^{
        self.contentView.frame = CGRectMake(mainViewFrame.origin.x, DATE_CHOOSE_VIEW_DEVICE_HEIGHT, mainViewFrame.size.width, mainViewFrame.size.height);
        
    } completion:^(BOOL finished) {
        self.hidden = YES;
        [self removeFromSuperview];
    }];
    
}

@end
