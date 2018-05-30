//
//  LogonPresenter.h
//  parking
//
//  Created by Robert Xu on 2017/6/12.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountService.h"

@protocol LogonPresenterDelegate <NSObject>

- (void)sendSMSSuccess:(BOOL)sucess;
- (void)logonSuccess:(BOOL)success message:(NSString *)message userModel:(UserModel *)userModel;

@end

@interface LogonPresenter : NSObject <COLPresenterProtocol>

//协议方法
- (instancetype)initWithService:(AccountService *)service;

- (void)attachView:(id)view;

- (void)detachView;

//其他
- (void)sendSMSToMobile:(NSString *)mobile;
- (void)loginWithMobile:(NSString *)mobile verify:(NSString *)verify;

@end
