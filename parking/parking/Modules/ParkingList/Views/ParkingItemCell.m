//
//  ParkingItemCell.m
//  parking
//
//  Created by Robert Xu on 2017/5/22.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "ParkingItemCell.h"

@interface ParkingItemCell ()

@property (weak, nonatomic) IBOutlet UILabel *carTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end

@implementation ParkingItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (ParkingItemCell *)cellForTableView:(UITableView *)tableView
{
    static NSString * identify = @"ParkingItemCell";
    ParkingItemCell * cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
}

- (void)showDataWithCarType:(NSString *)carType detail:(NSString *)detail {
    self.carTypeLabel.text = carType;
    self.detailLabel.text = detail;
}

@end
