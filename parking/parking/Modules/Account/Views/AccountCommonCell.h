//
//  AccountCommonCell.h
//  parking
//
//  Created by Robert Xu on 2017/5/23.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountCommonCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

+ (AccountCommonCell *)cellForTableView:(UITableView *)tableView;

- (void)setTitle:(NSString *)title;
- (void)setInfo:(NSString *)info;
- (void)showIdentity:(BOOL)show;
- (void)showArrow:(BOOL)show;

@end
