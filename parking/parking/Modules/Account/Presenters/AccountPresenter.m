//
//  AccountPresenter.m
//  parking
//
//  Created by Robert Xu on 2017/5/23.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "AccountPresenter.h"

@interface AccountPresenter ()

@property (weak, nonatomic) id <AccountPresenterDelegate> delegate;
@property (strong, nonatomic) AccountService *accountService;

@end

@implementation AccountPresenter

- (instancetype)initWithService:(AccountService *)service {
    
    self = [super init];
    if (self) {
        _accountService = service;
    }
    return self;
}

- (void)attachView:(id<AccountPresenterDelegate>)view {
    self.delegate = view;
}

- (void)detachView {
    self.delegate = nil;
}

- (void)getTitles {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(setAccountTitle:)]) {
        [self.delegate setAccountTitle:[self.accountService getTitles]];
    }
}

@end
