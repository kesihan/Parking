//
//  PayMoneyCell.h
//  parking
//
//  Created by 柯思汉 on 17/9/12.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayMoneyCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIButton *chose_btn;
@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UILabel *lb;

- (void)showCell:(NSIndexPath*)indexpath;
@end
