//
//  CarPresenter.m
//  parking
//
//  Created by Robert Xu on 2017/6/13.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "CarPresenter.h"
#import "AccountService.h"

@interface CarPresenter ()

@property (weak, nonatomic) id <CarPresenterDelegate> delegate;
@property (strong, nonatomic) CarService *carService;

@end

@implementation CarPresenter

- (instancetype)initWithService:(CarService *)service {
    
    self = [super init];
    if (self) {
        _carService = service;
    }
    return self;
}

- (void)attachView:(id<CarPresenterDelegate>)view {
    self.delegate = view;
}

- (void)detachView {
    self.delegate = nil;
}

- (void)getCarList {
    NSString *userID = [AccountService userModel].id;
    COLWeakSelf(self)
    [self.carService getCarListByUserID:userID resultBlock:^(BOOL success, NSString *message, NSArray<CarModel *> *carList) {
        COLStrongSelf(self)
        if (self.delegate && [self.delegate respondsToSelector:@selector(carListDidLoadedSuccess:message:carList:)]) {
            [self.delegate carListDidLoadedSuccess:success message:message carList:carList];
        }
    }];
}

- (void)setDefaultCarByPlateNo:(NSString *)plateNo {
    COLWeakSelf(self)
    NSString *userID = [AccountService userModel].id;
    [self.carService setDefaultCarByUserID:userID plateNo:plateNo resultBlock:^(BOOL success, NSString *message) {
        COLStrongSelf(self)
        if (self.delegate && [self.delegate respondsToSelector:@selector(carSetDefaultSuccess:message:)]) {
            [self.delegate carSetDefaultSuccess:success message:message];
        }
    }];
}

- (void)deleteCarByCarID:(NSString *)carID {
    COLWeakSelf(self)
    NSString *userID = [AccountService userModel].id;
    [self.carService deleteCarByUserID:userID carID:carID resultBlock:^(BOOL success, NSString *message) {
        COLStrongSelf(self)
        if (self.delegate && [self.delegate respondsToSelector:@selector(carDeleteSuccess:message:)]) {
            [self.delegate carDeleteSuccess:success message:message];
        }
    }];
}

@end
