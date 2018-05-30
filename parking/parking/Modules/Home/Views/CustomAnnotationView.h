//
//  CustomAnnotationView.h
//  parking
//
//  Created by Robert Xu on 2017/6/6.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "CommonTools.h"

@interface CustomAnnotationView : MAAnnotationView

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *subTitleLabel;

@property (assign, nonatomic) CUSPinAnnotationColor color;

@end
