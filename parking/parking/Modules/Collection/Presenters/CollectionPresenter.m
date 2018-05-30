//
//  CollectionPresenter.m
//  parking
//
//  Created by Robert Xu on 2017/6/13.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "CollectionPresenter.h"
#import "AccountService.h"

@interface CollectionPresenter ()

@property (weak, nonatomic) id <CollectionPresenterDelegate> delegate;
@property (strong, nonatomic) CollectionService *collectionService;
//参数
@property (assign, nonatomic) NSUInteger pageIndex;
@property (assign, nonatomic) NSUInteger pageSize;
@property (strong, nonatomic) NSMutableArray *collectionList;

@end

@implementation CollectionPresenter

- (instancetype)initWithService:(CollectionService *)service {
    
    self = [super init];
    if (self) {
        _collectionService = service;
        _pageIndex = 1;
        _pageSize = 10;
    }
    return self;
}

- (void)attachView:(id<CollectionPresenterDelegate>)view {
    self.delegate = view;
}

- (void)detachView {
    self.delegate = nil;
}

- (void)getCollectionList {
    COLWeakSelf(self)
    NSString *userID = [AccountService userModel].id;
    NSString *pageIndex = [NSString stringWithFormat:@"%lu", (unsigned long)self.pageIndex];
    NSString *size = [NSString stringWithFormat:@"%lu", (unsigned long)self.pageSize];
    [self.collectionService getCollectionListByUserID:userID objectType:@"lot" pageIndex:pageIndex size:size resultBlock:^(BOOL success, NSString *message, NSArray<CollectionModel *> *collectionList) {
        COLStrongSelf(self)
        
        if ([pageIndex integerValue] == 1) {
            self.collectionList = [NSMutableArray arrayWithArray:collectionList];
        } else {
            [self.collectionList addObjectsFromArray:collectionList];
        }
        _pageIndex ++;
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(collectionListDidLoadedSuccess:message:collectionList:)]) {
            [self.delegate collectionListDidLoadedSuccess:success message:message collectionList:self.collectionList];
        }
    }];
}

- (void)deleteCollectionByObjectID:(NSString *)objectID {
    COLWeakSelf(self)
    NSString *userID = [AccountService userModel].id;
    [self.collectionService deleteCollectionByUserID:userID objectType:@"lot" objectID:objectID resultBlock:^(BOOL success, NSString *message) {
        COLStrongSelf(self)
        if (self.delegate && [self.delegate respondsToSelector:@selector(collectionDeleteDidSuccess:message:)]) {
            [self.delegate collectionDeleteDidSuccess:success message:message];
        }
    }];
}

- (BOOL)isUserLogin {
    return [AccountService isLogin];
}

@end
