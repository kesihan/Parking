//
//  SearchCell.h
//  parking
//
//  Created by Robert Xu on 2017/6/15.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

@interface SearchCell : UITableViewCell

+ (SearchCell *)cellForTableView:(UITableView *)tableView;
- (void)showData:(AMapPOI *)poi;

@end
