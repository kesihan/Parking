//
//  MoreCell.h
//  parking
//
//  Created by Robert Xu on 2017/5/19.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoreCellModel.h"

@interface MoreCell : UITableViewCell

+ (MoreCell *)cellForTableView:(UITableView *)tableView;

- (void)showData:(MoreCellModel *)model;

@end
