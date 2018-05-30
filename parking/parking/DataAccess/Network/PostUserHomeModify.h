//
//  PostUserHomeModify.h
//  parking
//
//  Created by Robert Xu on 2017/6/13.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface PostUserHomeModify : YTKRequest

//修改用户默认车辆
- (instancetype)initWithUserID:(NSString *)userID plateNo:(NSString *)plateNo;

@end
