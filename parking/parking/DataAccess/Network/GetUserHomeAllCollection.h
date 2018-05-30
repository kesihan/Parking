//
//  GetUserHomeAllCollection.h
//  parking
//
//  Created by Robert Xu on 2017/6/13.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface GetUserHomeAllCollection : YTKRequest

//查看已收藏停车场信息
- (instancetype)initWithUserID:(NSString *)userID objectType:(NSString *)objectType pageIndex:(NSString *)pageIndex size:(NSString *)size;

@end
