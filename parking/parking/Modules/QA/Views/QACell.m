//
//  QACell.m
//  parking
//
//  Created by Robert Xu on 2017/6/7.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "QACell.h"

@interface QACell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation QACell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (QACell *)cellForTableView:(UITableView *)tableView
{
    static NSString * identify = @"QACell";
    QACell * cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
    }
    return cell;
}

- (void)showData:(QACellModel *)model {
    self.titleLabel.text = model.title;
}

@end
