//
//  SearchHistoryCell.h
//  parking
//
//  Created by Robert Xu on 2017/5/26.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchHistoryCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *address;

+ (SearchHistoryCell *)cellForTableView:(UITableView *)tableView;

@end
