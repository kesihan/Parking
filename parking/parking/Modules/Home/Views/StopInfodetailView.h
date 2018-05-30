//
//  StopInfodetailView.h
//  parking
//
//  Created by 柯思汉 on 17/9/12.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^StopInfodetailViewBlock)(NSInteger index);
@interface StopInfodetailView : UIView

@property (strong, nonatomic) IBOutlet UILabel *time;
@property (nonatomic, copy) StopInfodetailViewBlock block;
@end
