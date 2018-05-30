//
//  PostUserHomeAddCollection.h
//  parking
//
//  Created by Robert Xu on 2017/6/13.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface PostUserHomeAddCollection : YTKRequest

//添加停车场收藏
- (instancetype)initWithUserID:(NSString *)userID objectType:(NSString *)objectType objectID:(NSString *)objectID;

@end
