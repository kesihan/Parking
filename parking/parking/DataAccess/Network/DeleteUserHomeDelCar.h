//
//  DeleteUserHomeDelCar.h
//  parking
//
//  Created by Robert Xu on 2017/6/14.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface DeleteUserHomeDelCar : YTKRequest

- (instancetype)initWithUserID:(NSString *)userID carID:(NSString *)carID;

@end
