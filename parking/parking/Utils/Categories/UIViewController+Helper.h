//
//  UIViewController+Helper.h
//  parking
//
//  Created by Robert Xu on 2017/5/27.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Helper)

- (void)setWhiteTitleStyle; ///< 在viewWillAppear调用
- (void)setDefaultTitleStyle; ///< 在viewWillDisappear调用

@end
