//
//  PayMoneyCell.m
//  parking
//
//  Created by 柯思汉 on 17/9/12.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "PayMoneyCell.h"
@interface PayMoneyCell()
@property (nonatomic,strong)UIButton *btn;
@end
@implementation PayMoneyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)showCell:(NSIndexPath*)indexpath;
{
    if (indexpath.row == 0) {
        self.img.image = [UIImage imageNamed:@"余额"];
        [self.lb setText:@"账户余额(可用¥39.00)"];
    }
    else if (indexpath.row == 1) {
        self.img.image = [UIImage imageNamed:@"支付宝"];
        [self.lb setText:@"支付宝"];
    }
    else if (indexpath.row == 2) {
        self.img.image = [UIImage imageNamed:@"微信"];
        [self.lb setText:@"微信"];
    }
}
- (IBAction)chosebtn:(UIButton *)sender {
//    self.btn.selected = YES;
//    sender.selected =!sender.selected;
    
//    self.btn =sender;
    NSLog(@"%@",self.btn);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
