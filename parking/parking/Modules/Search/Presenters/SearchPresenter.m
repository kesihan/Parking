//
//  SearchPresenter.m
//  parking
//
//  Created by Robert Xu on 2017/6/15.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "SearchPresenter.h"
#import "AccountService.h"

@interface SearchPresenter ()

@property (weak, nonatomic) id <SearchPresenterDelegate> delegate;
@property (strong, nonatomic) SearchService *searchService;

@end

@implementation SearchPresenter

- (instancetype)initWithService:(SearchService *)service {
    
    self = [super init];
    if (self) {
        _searchService = service;
    }
    return self;
}

- (void)attachView:(id<SearchPresenterDelegate>)view {
    self.delegate = view;
}

- (void)detachView {
    self.delegate = nil;
}

@end
