//
//  PrepaidCell.h
//  mat
//
//  Created by 柯思汉 on 17/7/11.
//  Copyright © 2017年 hfy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrepaidCell : UICollectionViewCell
{
    
}
@property (strong, nonatomic) IBOutlet UILabel *money;
@property (strong, nonatomic) IBOutlet UILabel *giving;
@property (strong, nonatomic) IBOutlet UIButton *btn;

@property (nonatomic,strong) NSString *moneys;
- (instancetype)initWithFrame:(CGRect)frame;
@end
