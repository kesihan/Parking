//
//  CreditCell.h
//  parking
//
//  Created by Robert Xu on 2017/5/24.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreditModel.h"

@interface CreditCell : UITableViewCell

+ (CreditCell *)cellForTableView:(UITableView *)tableView;
- (void)showData:(IntegralList *)credit;

@end
