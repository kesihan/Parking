//
//  Target_Feedback.m
//  parking
//
//  Created by Robert Xu on 2017/5/25.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "Target_Feedback.h"
#import "FeedbackController.h"

@implementation Target_Feedback

- (UIViewController *)Action_feedbackController:(NSDictionary *)params {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:NSStringFromClass([FeedbackController class]) bundle:nil];
    
    //使用instantiateInitialViewController实例化SB中被设置为Is Initial View Controller的控制器
    UIViewController *feedbackController = (UIViewController *)[storyboard instantiateInitialViewController];
    return feedbackController;
    
}

@end
