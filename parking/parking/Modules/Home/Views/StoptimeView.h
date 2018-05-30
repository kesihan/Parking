//
//  StoptimeView.h
//  parking
//
//  Created by 柯思汉 on 17/9/12.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^StoptimeViewBlock)(NSInteger index);
@interface StoptimeView : UIView

@property (strong, nonatomic) IBOutlet UIButton *time;

@property (nonatomic, copy) StoptimeViewBlock block;
@end
