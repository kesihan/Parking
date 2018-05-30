//
//  Target_Invite.m
//  parking
//
//  Created by Robert Xu on 2017/5/25.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "Target_Invite.h"
#import "InviteController.h"

@implementation Target_Invite

- (UIViewController *)Action_inviteController:(NSDictionary *)params {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:NSStringFromClass([InviteController class]) bundle:nil];
    
    //使用instantiateInitialViewController实例化SB中被设置为Is Initial View Controller的控制器
    UIViewController *inviteController = (UIViewController *)[storyboard instantiateInitialViewController];
    return inviteController;
    
}

@end
