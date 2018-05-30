//
//  GetUserHomeIntegral.h
//  parking
//
//  Created by Robert Xu on 2017/6/13.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface GetUserHomeIntegral : YTKRequest

//积分明细
- (instancetype)initWithUserID:(NSString *)userID pageIndex:(NSString *)pageSize size:(NSString *)size;

@end
