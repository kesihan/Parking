//
//  LogonPresenter.m
//  parking
//
//  Created by Robert Xu on 2017/6/12.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "LogonPresenter.h"

@interface LogonPresenter ()

@property (weak, nonatomic) id <LogonPresenterDelegate> delegate;
@property (strong, nonatomic) AccountService *accountService;  //'id'需要替换成具体类型

@end

@implementation LogonPresenter

- (instancetype)initWithService:(AccountService *)service {
    
    self = [super init];
    if (self) {
        _accountService = service;
    }
    return self;
}

- (void)attachView:(id<LogonPresenterDelegate>)view {
    self.delegate = view;
}

- (void)detachView {
    self.delegate = nil;
}

- (void)sendSMSToMobile:(NSString *)mobile {
    
    COLWeakSelf(self)
    [self.accountService sendSMSWithMobile:mobile resultBlock:^(BOOL success) {
        COLStrongSelf(self)
        if (self.delegate && [self.delegate respondsToSelector:@selector(sendSMSSuccess:)]) {
            [self.delegate sendSMSSuccess:success];
        }
    }];
    
}

- (void)loginWithMobile:(NSString *)mobile verify:(NSString *)verify {
    
    COLWeakSelf(self)
    [self.accountService loginWithMobile:mobile verify:verify resultBlock:^(BOOL success, NSString *message, UserModel *userModel) {
        COLStrongSelf(self)
        if (self.delegate && [self.delegate respondsToSelector:@selector(logonSuccess:message:userModel:)]) {
            [self.delegate logonSuccess:success message:message userModel:userModel];
        }
    }];
    
}


@end
