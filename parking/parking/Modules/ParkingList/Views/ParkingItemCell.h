//
//  ParkingItemCell.h
//  parking
//
//  Created by Robert Xu on 2017/5/22.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParkingItemCell : UITableViewCell

+ (ParkingItemCell *)cellForTableView:(UITableView *)tableView;
- (void)showDataWithCarType:(NSString *)carType detail:(NSString *)detail;

@end
