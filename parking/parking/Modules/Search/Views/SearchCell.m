//
//  SearchCell.m
//  parking
//
//  Created by Robert Xu on 2017/6/15.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "SearchCell.h"

@interface SearchCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@end

@implementation SearchCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (SearchCell *)cellForTableView:(UITableView *)tableView
{
    static NSString * identify = @"SearchCell";
    SearchCell * cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
    }
    return cell;
}

- (void)showData:(AMapPOI *)poi {
    self.titleLabel.text = poi.name;
    self.subTitleLabel.text = poi.address;
}

@end
