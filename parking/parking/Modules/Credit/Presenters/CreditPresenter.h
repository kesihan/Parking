//
//  CreditPresenter.h
//  parking
//
//  Created by Robert Xu on 2017/6/13.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CreditService.h"

@protocol CreditPresenterDelegate <NSObject>

//暴露给View的Model不能是CreditModel，这个是Model层使用的，应该专门有View层的Model。
- (void)creditListDidLoadedSuccess:(BOOL)success list:(NSMutableArray *)list total:(NSInteger)total isSignIn:(NSString *)isSign;
- (void)creditDidSignedSuccess:(BOOL)success message:(NSString *)message;

@end

@interface CreditPresenter : NSObject <COLPresenterProtocol>

//协议方法
- (instancetype)initWithService:(CreditService *)service;

- (void)attachView:(id<CreditPresenterDelegate>)view;

- (void)detachView;

//Others
- (void)getCreditList;
- (void)signDaily;

@end
