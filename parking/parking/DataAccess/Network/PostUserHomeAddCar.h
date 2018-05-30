//
//  PostUserHomeAddCar.h
//  parking
//
//  Created by Robert Xu on 2017/6/13.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface PostUserHomeAddCar : YTKRequest

//添加车辆信息
- (instancetype)initWithUserID:(NSString *)userID plateNo:(NSString *)plateNo type:(NSString *)type;

@end
