//
//  Target_Search.m
//  parking
//
//  Created by Robert Xu on 2017/5/25.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "Target_Search.h"
#import "SearchController.h"

@implementation Target_Search

- (UIViewController *)Action_searchController:(NSDictionary *)params {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:NSStringFromClass([SearchController class]) bundle:nil];
    
    //使用instantiateInitialViewController实例化SB中被设置为Is Initial View Controller的控制器
    UIViewController *searchController = (UIViewController *)[storyboard instantiateInitialViewController];
    return searchController;
    
}

@end
