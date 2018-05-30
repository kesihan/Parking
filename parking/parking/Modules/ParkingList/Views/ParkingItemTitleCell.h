//
//  ParkingItemTitleCell.h
//  parking
//
//  Created by Robert Xu on 2017/5/22.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParkingItemTitleCell : UITableViewCell

+ (ParkingItemTitleCell *)cellForTableView:(UITableView *)tableView;
- (void)showData:(NSString *)title;

@end
