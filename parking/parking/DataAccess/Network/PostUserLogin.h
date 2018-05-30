//
//  PostUserLogin.h
//  parking
//
//  Created by Robert Xu on 2017/6/13.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface PostUserLogin : YTKRequest

//登录验证
- (instancetype)initWithMobile:(NSString *)mobile verify:(NSString *)verify;

@end
