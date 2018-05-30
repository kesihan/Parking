//
//  CollectionCell.m
//  parking
//
//  Created by Robert Xu on 2017/5/24.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "CollectionCell.h"

@interface CollectionCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLable;

@property (copy, nonatomic) NSString *lng;
@property (copy, nonatomic) NSString *lat;

@end

@implementation CollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CollectionCell *)cellForTableView:(UITableView *)tableView
{
    static NSString * identify = @"CollectionCell";
    CollectionCell * cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
    }
    return cell;
}

- (void)showData:(CollectionModel *)collectionModel {
    self.titleLabel.text = collectionModel.lotName;
    self.subTitleLable.text = collectionModel.lotAddress;
    self.lng = collectionModel.addressLongitude;
    self.lat = collectionModel.addressLatitude;
}

- (IBAction)startNaviAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionCellStartNaviWithLng:lat:)]) {
        [self.delegate collectionCellStartNaviWithLng:self.lng lat:self.lat];
    }
}

@end
