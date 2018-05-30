//
//  CreditCell.m
//  parking
//
//  Created by Robert Xu on 2017/5/24.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "CreditCell.h"

@interface CreditCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *creditLabel;

@end

@implementation CreditCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CreditCell *)cellForTableView:(UITableView *)tableView
{
    static NSString * identify = @"CreditCell";
    CreditCell * cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
    }
    return cell;
}

- (void)showData:(IntegralList *)credit {
    self.titleLabel.text = credit.fromType;
    self.dateLabel.text = credit.addTime;
    self.creditLabel.text = [NSString stringWithFormat:@"+%ld", (long)credit.num];
}

@end
