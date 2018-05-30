//
//  AccountAvatarCell.h
//  parking
//
//  Created by Robert Xu on 2017/5/23.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountAvatarCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *headPic;

+ (AccountAvatarCell *)cellForTableView:(UITableView *)tableView;

- (void)setTitle:(NSString *)title;

@end
