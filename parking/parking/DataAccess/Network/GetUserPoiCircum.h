//
//  GetUserPoiCircum.h
//  parking
//
//  Created by Robert Xu on 2017/6/13.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface GetUserPoiCircum : YTKRequest

//搜索栏模糊查找
- (instancetype)initWithStr:(NSString *)str pageSize:(NSString *)pageSize;

@end
