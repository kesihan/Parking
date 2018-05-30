//
//  ParkingrecordCell.m
//  parking
//
//  Created by 柯思汉 on 2018/2/26.
//  Copyright © 2018年 huafangcloud. All rights reserved.
//

#import "ParkingrecordCell.h"

@implementation ParkingrecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setData:(DebugItem*)item;
{    
    [self.name setText:item.name];
    self.money.text = [[NSString alloc]initWithFormat:@"计费中 %@",item.money];
    [self.in_time setText:item.in_time];
    [self.out_time setText:item.out_time];
    [self.license_plate setText:item.license_plate];
    [self.status setText:item.status];
    if ([item.status isEqualToString:@"0"]) {
        [self.status setText:@"待缴费"];
    }
    else
    {
        [self.status setText:@"进行中"];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
