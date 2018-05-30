//
//  MorePresenter.m
//  parking
//
//  Created by Robert Xu on 2017/5/22.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "MorePresenter.h"

@interface MorePresenter ()

@property (weak, nonatomic) id <MorePresenterDelegate> delegate;
@property (strong, nonatomic) MoreService *moreService;

@end

@implementation MorePresenter

- (instancetype)initWithService:(MoreService *)service {
    
    self = [super init];
    if (self) {
        _moreService = service;
    }
    return self;
}

- (void)attachView:(id<MorePresenterDelegate>)view {
    self.delegate = view;
}

- (void)detachView {
    self.delegate = nil;
}

- (void)getMenu {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(setMoreMenu:)]) {
        [self.delegate setMoreMenu:[self.moreService getMenu]];
    }
}

@end
