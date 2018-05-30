//
//  ParkingItemTopCell.m
//  parking
//
//  Created by Robert Xu on 2017/5/22.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "ParkingItemTopCell.h"

@interface ParkingItemTopCell ()

@property (weak, nonatomic) IBOutlet UILabel *routeFirstLabel;
@property (weak, nonatomic) IBOutlet UILabel *routeSecondLabel;
@property (weak, nonatomic) IBOutlet UILabel *allowInCarTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *freeTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLimitLabel;

@end

@implementation ParkingItemTopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (ParkingItemTopCell *)cellForTableView:(UITableView *)tableView
{
    static NSString * identify = @"ParkingItemTopCell";
    ParkingItemTopCell * cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
}

- (void)showData:(NearbyParkingModel *)model {
    
}

@end
