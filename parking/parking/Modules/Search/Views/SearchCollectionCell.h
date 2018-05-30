//
//  SearchCollectionCell.h
//  parking
//
//  Created by Robert Xu on 2017/5/26.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionModel.h"

@interface SearchCollectionCell : UITableViewCell

+ (SearchCollectionCell *)cellForTableView:(UITableView *)tableView;
- (void)showData:(CollectionModel *)collectionModel;

@end
