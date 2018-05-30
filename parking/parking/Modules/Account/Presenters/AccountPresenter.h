//
//  AccountPresenter.h
//  parking
//
//  Created by Robert Xu on 2017/5/23.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountService.h"

@protocol AccountPresenterDelegate <NSObject>

- (void)setAccountTitle:(NSArray *)titles;

@end

@interface AccountPresenter : NSObject <COLPresenterProtocol>

//协议方法
- (instancetype)initWithService:(id)service;

- (void)attachView:(id<AccountPresenterDelegate>)view;

- (void)detachView;

- (void)getTitles;

@end
