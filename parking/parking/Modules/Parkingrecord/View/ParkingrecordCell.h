//
//  ParkingrecordCell.h
//  parking
//
//  Created by 柯思汉 on 2018/2/26.
//  Copyright © 2018年 huafangcloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DebugModel.h"
@interface ParkingrecordCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *status;
@property (strong, nonatomic) IBOutlet UILabel *money;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *license_plate;
@property (strong, nonatomic) IBOutlet UILabel *out_time;
@property (strong, nonatomic) IBOutlet UILabel *in_time;

- (void)setData:(DebugItem*)item;
@end
