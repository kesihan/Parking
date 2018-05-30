//
//  UIViewController+Swizzling.h
//  parking
//
//  Created by Robert Xu on 2017/5/26.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol COLUIViewControllerDelegate <NSObject>

- (void)customReturnAction:(id)sender;

@end

@interface UIViewController (Swizzling)

@end
