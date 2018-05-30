//
//  MoreCell.m
//  parking
//
//  Created by Robert Xu on 2017/5/19.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "MoreCell.h"

@interface MoreCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *extInfoLabel;

@end

@implementation MoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (MoreCell *)cellForTableView:(UITableView *)tableView
{
    static NSString * identify = @"MoreCell";
    MoreCell * cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
    }
    return cell;
}

- (void)showData:(MoreCellModel *)model {
    self.titleLabel.text = model.title;
    if ([model.extInfo length] == 0) {
        self.extInfoLabel.hidden = YES;
    } else {
        self.extInfoLabel.hidden = NO;
        self.extInfoLabel.text = model.extInfo;
    }
}

@end
