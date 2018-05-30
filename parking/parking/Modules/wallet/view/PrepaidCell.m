//
//  PrepaidCell.m
//  mat
//
//  Created by 柯思汉 on 17/7/11.
//  Copyright © 2017年 hfy. All rights reserved.
//

#import "PrepaidCell.h"

@implementation PrepaidCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"PrepaidCell" owner:self options:nil].lastObject;
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setMoney:(UILabel *)money
{
    _money=money;
    
}
- (void)setMoneys:(NSString *)moneys
{
    _money.text=moneys;
}
- (void)setGiving:(UILabel *)giving
{
    _giving=giving;
}
- (void)setBtn:(UIButton *)btn
{
    _btn=btn;
}
@end
