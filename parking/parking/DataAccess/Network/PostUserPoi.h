//
//  PostUserPoi.h
//  parking
//
//  Created by Robert Xu on 2017/6/13.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface PostUserPoi : YTKRequest

//周边停车场列表
- (instancetype)initWithLng:(NSString *)lng lat:(NSString *)lat r:(NSString *)r;

@end
