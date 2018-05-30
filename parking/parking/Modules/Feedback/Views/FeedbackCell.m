//
//  FeedbackCell.m
//  parking
//
//  Created by Robert Xu on 2017/6/1.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "FeedbackCell.h"

@interface FeedbackCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *checkImage;

@end

@implementation FeedbackCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (FeedbackCell *)cellForTableView:(UITableView *)tableView
{
    static NSString * identify = @"FeedbackCell";
    FeedbackCell * cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
    }
    return cell;
}

- (void)showCheck:(BOOL)show {
    self.checkImage.hidden = !show;
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}

@end
