//
//  CarCell.m
//  parking
//
//  Created by Robert Xu on 2017/5/24.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "CarCell.h"

@interface CarCell ()

@property (weak, nonatomic) IBOutlet UILabel *provinceLabel;
@property (weak, nonatomic) IBOutlet UILabel *plateLabel;
@property (weak, nonatomic) IBOutlet UILabel *carTypeLabel;
@property (weak, nonatomic) IBOutlet UIButton *checkButton;
@property (weak, nonatomic) IBOutlet UILabel *defaultLabel;

@end

@implementation CarCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CarCell *)cellForTableView:(UITableView *)tableView
{
    static NSString * identify = @"CarCell";
    CarCell * cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
    }
    return cell;
}

- (void)showData:(CarModel *)carModel {
    self.provinceLabel.text = [carModel.plateNo substringToIndex:1];
    self.plateLabel.text = [carModel.plateNo substringFromIndex:1];
    
    
    NSString *carType = @"小车";
    if ([carModel.type isEqualToString:@"mid"]) {
        carType = @"中车";
    } else if ([carModel.type isEqualToString:@"max"]) {
        carType = @"大车";
    }
    
    self.carTypeLabel.text = carType;
/*
    BOOL isDefaultCar = (carModel.defaultCar == 1) ? YES : NO;
    
    if (isDefaultCar) {
        [self.checkButton setBackgroundImage:[UIImage imageNamed:@"car_icon_checkbox_selected"] forState:UIControlStateNormal];
    } else {
        [self.checkButton setBackgroundImage:[UIImage imageNamed:@"car_icon_checkbox_unselected"] forState:UIControlStateNormal];
    }
*/
}

- (void)setDefaultCarCell:(BOOL)aDefault {
    if (aDefault) {
        [self.checkButton setBackgroundImage:[UIImage imageNamed:@"car_icon_checkbox_selected"] forState:UIControlStateNormal];
    } else {
        [self.checkButton setBackgroundImage:[UIImage imageNamed:@"car_icon_checkbox_unselected"] forState:UIControlStateNormal];
    }
}

- (IBAction)setDefaultAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(carCellSetDefaultWithPalteNo:)]) {
        [self.delegate carCellSetDefaultWithPalteNo:[NSString stringWithFormat:@"%@%@",self.provinceLabel.text, self.plateLabel.text]];
    }
}

@end
