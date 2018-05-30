//
//  HomeNaviController.h
//  parking
//
//  Created by Robert Xu on 2017/6/9.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapNaviKit/AMapNaviKit.h>

@interface HomeNaviController : UIViewController

//起始点
@property (strong, nonatomic) CLLocation *start;
//结束点
@property (strong, nonatomic) CLLocation *end;

@end
