//
//  SearchCollectionCell.m
//  parking
//
//  Created by Robert Xu on 2017/5/26.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "SearchCollectionCell.h"

@interface SearchCollectionCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@end

@implementation SearchCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (SearchCollectionCell *)cellForTableView:(UITableView *)tableView
{
    static NSString * identify = @"SearchCollectionCell";
    SearchCollectionCell * cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
    }
    return cell;
}

- (void)showData:(CollectionModel *)collectionModel {
    self.titleLabel.text = collectionModel.lotName;
    self.subTitleLabel.text = collectionModel.lotAddress;
}

@end
