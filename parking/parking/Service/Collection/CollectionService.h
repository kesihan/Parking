//
//  CollectionService.h
//  parking
//
//  Created by Robert Xu on 2017/6/13.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CollectionModel.h"

typedef void (^csCollectionListResultBlock) (BOOL success, NSString *message, NSArray<CollectionModel *> *collectionList);
typedef void (^csCollectionBoolResultBlock) (BOOL success, NSString *message);

@interface CollectionService : NSObject

//获取收藏列表
- (void)getCollectionListByUserID:(NSString *)userID
                       objectType:(NSString *)objectType
                        pageIndex:(NSString *)pageIndex
                             size:(NSString *)size
                      resultBlock:(csCollectionListResultBlock)resultBlock;
//删除收藏
- (void)deleteCollectionByUserID:(NSString *)userID
                      objectType:(NSString *)objectType
                        objectID:(NSString *)objectID
                     resultBlock:(csCollectionBoolResultBlock)resultBlock;

//添加收藏
- (void)addCollectionByUserID:(NSString *)userID
                   objectType:(NSString *)objectType
                     objectID:(NSString *)objectID
                  resultBlock:(csCollectionBoolResultBlock)resultBlock;
@end
