//
//  CollectionService.m
//  parking
//
//  Created by Robert Xu on 2017/6/13.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "CollectionService.h"
#import "GetUserHomeAllCollection.h"
#import "PostUserHomeAddCollection.h"
#import "DeleteUserHomeDelCollection.h"

@implementation CollectionService

- (void)getCollectionListByUserID:(NSString *)userID
                       objectType:(NSString *)objectType
                        pageIndex:(NSString *)pageIndex
                             size:(NSString *)size
                      resultBlock:(csCollectionListResultBlock)resultBlock {
    GetUserHomeAllCollection *getUserHomeAllCollection = [[GetUserHomeAllCollection alloc] initWithUserID:userID objectType:objectType pageIndex:pageIndex size:size];
    [getUserHomeAllCollection startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        BOOL isOK = [request isOK];
        if (isOK) {
            NSMutableArray <CollectionModel *>*collectionList = [NSMutableArray arrayWithCapacity:10];
            NSArray *list = [request content];
            for (NSDictionary *collection in list) {
                [collectionList addObject:[CollectionModel yy_modelWithJSON:collection]];
            }
            resultBlock(isOK, [request message], collectionList);
        } else {
            resultBlock(isOK, [request message], nil);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        resultBlock(NO, [request message], nil);
    }];
}

- (void)deleteCollectionByUserID:(NSString *)userID
                      objectType:(NSString *)objectType
                       objectID:(NSString *)objectID
                     resultBlock:(csCollectionBoolResultBlock)resultBlock {
    DeleteUserHomeDelCollection *deleteUserHomeDelCollection = [[DeleteUserHomeDelCollection alloc] initWithUserID:userID objectType:objectType objectID:objectID];
    [deleteUserHomeDelCollection startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        BOOL isOK = [request isOK];
        resultBlock(isOK, [request message]);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        resultBlock(NO, [request message]);
    }];
}

- (void)addCollectionByUserID:(NSString *)userID
                  objectType:(NSString *)objectType
                    objectID:(NSString *)objectID
                 resultBlock:(csCollectionBoolResultBlock)resultBlock {
    PostUserHomeAddCollection *postUserHomeAddCollection = [[PostUserHomeAddCollection alloc] initWithUserID:userID objectType:objectType objectID:objectID];
    [postUserHomeAddCollection startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        BOOL isOK = [request isOK];
        resultBlock(isOK, [request message]);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        resultBlock(NO, [request message]);
    }];
}

@end
