//
//  GetUserHomeCar.h
//  parking
//
//  Created by Robert Xu on 2017/6/13.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface GetUserHomeCar : YTKRequest

//用户车辆信息
- (instancetype)initWithUserID:(NSString *)userID;

@end
