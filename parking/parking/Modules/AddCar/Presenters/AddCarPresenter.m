//
//  AddCarPresenter.m
//  parking
//
//  Created by Robert Xu on 2017/6/13.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "AddCarPresenter.h"
#import "AccountService.h"

@interface AddCarPresenter ()

@property (weak, nonatomic) id <AddCarPresenterDelegate> delegate;
@property (strong, nonatomic) CarService *carService;

@end

@implementation AddCarPresenter

- (instancetype)initWithService:(CarService *)service {
    
    self = [super init];
    if (self) {
        _carService = service;
    }
    return self;
}

- (void)attachView:(id<AddCarPresenterDelegate>)view {
    self.delegate = view;
}

- (void)detachView {
    self.delegate = nil;
}

- (void)adCarByPlateNo:(NSString *)plateNo type:(NSString *)type {
    NSString *userID = [AccountService userModel].id;
    COLWeakSelf(self)
    [self.carService addCarByUserID:userID plateNo:plateNo type:type resultBlock:^(BOOL success, NSString *message) {
        COLStrongSelf(self)
        if (self.delegate && [self.delegate respondsToSelector:@selector(addCarAddedSuccess:message:)]) {
            [self.delegate addCarAddedSuccess:success message:message];
        }
    }];
}

@end
