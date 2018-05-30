//
//  QACell.h
//  parking
//
//  Created by Robert Xu on 2017/6/7.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QACellModel.h"

@interface QACell : UITableViewCell

+ (QACell *)cellForTableView:(UITableView *)tableView;
- (void)showData:(QACellModel *)model;

@end
