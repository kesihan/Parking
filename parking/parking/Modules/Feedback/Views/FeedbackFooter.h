//
//  FeedbackFooter.h
//  parking
//
//  Created by Robert Xu on 2017/6/1.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FeedbackFooterDelegate <NSObject>

- (void)feedbackFooterImageSource:(UIButton *)button;

@end

@interface FeedbackFooter : UIView

@property (weak, nonatomic) id <FeedbackFooterDelegate> delegate;

@end
