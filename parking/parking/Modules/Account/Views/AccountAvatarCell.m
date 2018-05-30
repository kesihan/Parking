//
//  AccountAvatarCell.m
//  parking
//
//  Created by Robert Xu on 2017/5/23.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "AccountAvatarCell.h"

@interface AccountAvatarCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation AccountAvatarCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (AccountAvatarCell *)cellForTableView:(UITableView *)tableView
{
    static NSString * identify = @"AccountAvatarCell";
    AccountAvatarCell * cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}

@end
