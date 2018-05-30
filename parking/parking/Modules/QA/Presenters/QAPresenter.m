//
//  QAPresenter.m
//  parking
//
//  Created by Robert Xu on 2017/6/7.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "QAPresenter.h"

@interface QAPresenter ()

@property (weak, nonatomic) id <QAPresenterDelegate> delegate;
@property (strong, nonatomic) QAService *qaService;

@end

@implementation QAPresenter

- (instancetype)initWithService:(id)service {
    
    self = [super init];
    if (self) {
        _qaService = service;
    }
    return self;
}

- (void)attachView:(id<QAPresenterDelegate>)view {
    self.delegate = view;
}

- (void)detachView {
    self.delegate = nil;
}

- (void)getMenu {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(setQAMenu:)]) {
        [self.delegate setQAMenu:[self.qaService getMenu]];
    }
}

@end
