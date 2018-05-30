//
//  ParkingItemTitleCell.m
//  parking
//
//  Created by Robert Xu on 2017/5/22.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "ParkingItemTitleCell.h"

@interface ParkingItemTitleCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation ParkingItemTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (ParkingItemTitleCell *)cellForTableView:(UITableView *)tableView
{
    static NSString * identify = @"ParkingItemTitleCell";
    ParkingItemTitleCell * cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
}

- (void)showData:(NSString *)title {
    self.titleLabel.text = title;
}

@end
