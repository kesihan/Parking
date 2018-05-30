//
//  MyPresenter.m
//  parking
//
//  Created by Robert Xu on 2017/5/18.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "MyPresenter.h"

@interface MyPresenter ()

@property (weak, nonatomic) id <MyPresenterDelegate> delegate;
@property (strong, nonatomic) MyService *myService;  //'id'需要替换成具体类型

@end

@implementation MyPresenter

- (instancetype)initWithService:(MyService *)service {
    
    self = [super init];
    if (self) {
        _myService = service;
    }
    return self;
}

- (void)attachView:(id<MyPresenterDelegate>)view {
    self.delegate = view;
}

- (void)detachView {
    self.delegate = nil;
}

- (void)getMenu {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(setMyMenu:)]) {
        [self.delegate setMyMenu:[self.myService getMenu]];
    }
}

- (BOOL)hasCar {
    return [self.myService hasCar];
}

@end
