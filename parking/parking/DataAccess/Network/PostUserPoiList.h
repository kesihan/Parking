//
//  PostUserPoiList.h
//  parking
//
//  Created by Robert Xu on 2017/6/13.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface PostUserPoiList : YTKRequest

//周边搜索列表
- (instancetype)initWithLng:(NSString *)lng
                        lat:(NSString *)lat
                          r:(NSString *)r
                  pageIndex:(NSString *)pageIndex
                       size:(NSString *)size;

@end
