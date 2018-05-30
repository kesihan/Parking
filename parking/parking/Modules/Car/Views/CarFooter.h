//
//  CarFooter.h
//  parking
//
//  Created by Robert Xu on 2017/5/24.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CarFooterDelegate <NSObject>

- (void)carFooterAddCarButtonClicked:(UIButton *)button;

@end

@interface CarFooter : UIView

@property (weak, nonatomic) id <CarFooterDelegate> delegate;

@end
