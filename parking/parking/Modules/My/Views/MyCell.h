//
//  MyCell.h
//  parking
//
//  Created by Robert Xu on 2017/5/18.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCellModel.h"

@interface MyCell : UITableViewCell

+ (MyCell *)cellForTableView:(UITableView *)tableView;
- (void)showData:(MyCellModel *)model;

@end
