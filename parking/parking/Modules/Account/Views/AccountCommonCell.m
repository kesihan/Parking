//
//  AccountCommonCell.m
//  parking
//
//  Created by Robert Xu on 2017/5/23.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "AccountCommonCell.h"

@interface AccountCommonCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *identityImage;

@property (weak, nonatomic) IBOutlet UIImageView *arrowImage;

@end

@implementation AccountCommonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (AccountCommonCell *)cellForTableView:(UITableView *)tableView
{
    static NSString * identify = @"AccountCommonCell";
    AccountCommonCell * cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
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

- (void)setInfo:(NSString *)info {
    self.infoLabel.text = info;
}

- (void)showIdentity:(BOOL)show {
    self.identityImage.hidden = !show;
}

- (void)showArrow:(BOOL)show {
    self.arrowImage.hidden = !show;
}

@end
