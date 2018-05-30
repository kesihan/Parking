//
//  CustomPointAnnotation.h
//  parking
//
//  Created by Robert Xu on 2017/6/15.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

@interface CustomPointAnnotation : MAPointAnnotation

@property (assign, nonatomic) NSInteger index;
//红色0 黄色1 绿色2
@property (assign, nonatomic) NSInteger colorNumber;

@end
