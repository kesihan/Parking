//
//  DateChooseView.h
//  shuxiang
//
//  Created by 陈嘉贤 on 2016/12/29.
//  Copyright © 2016年 Addison. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DateChooseViewDelegate <NSObject>

- (void)clickConfirm:(NSString *)date;

@end

@interface DateChooseView : UIView

@property (nonatomic, assign) id<DateChooseViewDelegate> delegate;
@property (assign, nonatomic) BOOL isAllChoose;//NO：当前日期之后不能选择  1：当天日期之后可以选择

- (void)showWithDate:(NSString *)date;

@end
