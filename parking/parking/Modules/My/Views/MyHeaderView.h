//
//  MyHeaderView.h
//  parking
//
//  Created by Robert Xu on 2017/5/18.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyHeaderViewDelegate <NSObject>

- (void)myHeaderViewClickAvatar;

@end

@interface MyHeaderView : UIView
@property (strong, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) id <MyHeaderViewDelegate> delegate;

@end
