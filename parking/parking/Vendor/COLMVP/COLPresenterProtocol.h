//
//  COLPresenterProtocol.h
//  parking
//
//  Created by Robert Xu on 2017/5/18.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol COLPresenterProtocol <NSObject>

@required

- (instancetype)initWithService:(id)service;
- (void)attachView:(id)view;
- (void)detachView;

@end
