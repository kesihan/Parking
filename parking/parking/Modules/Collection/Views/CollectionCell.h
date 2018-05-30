//
//  CollectionCell.h
//  parking
//
//  Created by Robert Xu on 2017/5/24.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionModel.h"

@protocol CollectionCellDelegate <NSObject>

- (void)collectionCellStartNaviWithLng:(NSString *)lng lat:(NSString *)lat;

@end

@interface CollectionCell : UITableViewCell

@property (weak, nonatomic) id delegate;

+ (CollectionCell *)cellForTableView:(UITableView *)tableView;
- (void)showData:(CollectionModel *)collectionModel;

@end
