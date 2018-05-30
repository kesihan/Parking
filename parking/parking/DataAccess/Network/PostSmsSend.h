//
//  PostSmsSend.h
//  parking
//
//  Created by Robert Xu on 2017/6/12.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface PostSmsSend : YTKRequest

//发送短信
- (instancetype)initWithMobile:(NSString *)mobile purpose:(NSString *)purpose message:(NSString *)message;

@end
