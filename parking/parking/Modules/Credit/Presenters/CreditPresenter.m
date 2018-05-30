//
//  CreditPresenter.m
//  parking
//
//  Created by Robert Xu on 2017/6/13.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "CreditPresenter.h"
#import "AccountService.h"

@interface CreditPresenter ()

@property (weak, nonatomic) id <CreditPresenterDelegate> delegate;
@property (strong, nonatomic) CreditService *creditService;

//参数
@property (assign, nonatomic) NSUInteger pageIndex;
@property (assign, nonatomic) NSUInteger pageSize;
@property (strong, nonatomic) NSMutableArray *creditList;

@end

@implementation CreditPresenter

- (instancetype)initWithService:(CreditService *)service {
    
    self = [super init];
    if (self) {
        _creditService = service;
        _pageIndex = 1;
        _pageSize = 10;
    }
    return self;
}

- (void)attachView:(id<CreditPresenterDelegate>)view {
    self.delegate = view;
}

- (void)detachView {
    self.delegate = nil;
}

//Others
- (void)getCreditList {
    
    
    NSString *userID = [AccountService userModel].id;
    NSString *pageIndex = [NSString stringWithFormat:@"%lu", (unsigned long)self.pageIndex];
    NSString *size = [NSString stringWithFormat:@"%lu", (unsigned long)self.pageSize];
    
    COLWeakSelf(self)
    [self.creditService getCreditListByUserID:userID pageIndex:pageIndex size:size resultBlock:^(BOOL success, NSString *message, CreditModel *creditModel) {
        COLStrongSelf(self)
        
        if ([pageIndex integerValue] == 1) {
            self.creditList = [NSMutableArray arrayWithArray:creditModel.integralList];
        } else {
            [self.creditList addObjectsFromArray:creditModel.integralList];
        }
        _pageIndex ++;
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(creditListDidLoadedSuccess:list:total:isSignIn:)]) {
            [self.delegate creditListDidLoadedSuccess:success list:self.creditList total:creditModel.total isSignIn:creditModel.signIn];
        }
    }];
}

- (void)signDaily {
    NSString *userID = [AccountService userModel].id;
    COLWeakSelf(self)
    [self.creditService signDailyByUserID:userID resultBlock:^(BOOL success, NSString *message, CreditModel *creditModel) {
        COLStrongSelf(self)
        if (self.delegate && [self.delegate respondsToSelector:@selector(creditDidSignedSuccess:message:)]) {
            [self.delegate creditDidSignedSuccess:success message:message];
        }
    }];
    
}

@end
