//
//  CollectionPresenter.h
//  parking
//
//  Created by Robert Xu on 2017/6/13.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CollectionService.h"

@protocol CollectionPresenterDelegate <NSObject>

@optional
- (void)collectionListDidLoadedSuccess:(BOOL)success message:(NSString *)message collectionList:(NSArray <CollectionModel *>*)collectionList;
- (void)collectionDeleteDidSuccess:(BOOL)success message:(NSString *)message;

@end

@interface CollectionPresenter : NSObject <COLPresenterProtocol>

//协议方法
- (instancetype)initWithService:(CollectionService *)service;

- (void)attachView:(id<CollectionPresenterDelegate>)view;

- (void)detachView;

//获取收藏列表
- (void)getCollectionList;
- (void)deleteCollectionByObjectID:(NSString *)objectID;
- (BOOL)isUserLogin;

@end
