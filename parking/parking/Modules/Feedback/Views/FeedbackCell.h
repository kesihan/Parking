//
//  FeedbackCell.h
//  parking
//
//  Created by Robert Xu on 2017/6/1.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedbackCell : UITableViewCell

+ (FeedbackCell *)cellForTableView:(UITableView *)tableView;

- (void)showCheck:(BOOL)show;
- (void)setTitle:(NSString *)title;

@end
