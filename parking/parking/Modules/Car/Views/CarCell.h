//
//  CarCell.h
//  parking
//
//  Created by Robert Xu on 2017/5/24.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarModel.h"

@protocol CarCellDelegate <NSObject>

- (void)carCellSetDefaultWithPalteNo:(NSString *)plateNo;

@end

@interface CarCell : UITableViewCell

@property (weak, nonatomic) id <CarCellDelegate> delegate;

+ (CarCell *)cellForTableView:(UITableView *)tableView;
- (void)showData:(CarModel *)carModel;
- (void)setDefaultCarCell:(BOOL)aDefault;

@end
