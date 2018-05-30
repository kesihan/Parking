//
//  DeleteUserHomeDelCollection.h
//  parking
//
//  Created by Robert Xu on 2017/6/13.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface DeleteUserHomeDelCollection : YTKRequest

//取消已收藏停车场信息
- (instancetype)initWithUserID:(NSString *)userID objectType:(NSString *)objectType objectID:(NSString *)objectID;

@end
