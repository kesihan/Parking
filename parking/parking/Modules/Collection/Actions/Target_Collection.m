//
//  Target_Collection.m
//  parking
//
//  Created by Robert Xu on 2017/5/24.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "Target_Collection.h"
#import "CollectionController.h"

@implementation Target_Collection

- (UIViewController *)Action_collectionController:(NSDictionary *)params {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:NSStringFromClass([CollectionController class]) bundle:nil];
    
    //使用instantiateInitialViewController实例化SB中被设置为Is Initial View Controller的控制器
    UIViewController *collectionController = (UINavigationController *)[storyboard instantiateInitialViewController];
    return collectionController;
    
}

@end
