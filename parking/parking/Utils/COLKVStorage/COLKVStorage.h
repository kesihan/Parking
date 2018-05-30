//
//  COLKVStorage.h
//  shoucangjia
//
//  Created by Robert Xu on 16/4/27.
//  Copyright © 2016年 listcloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface COLKVStorage : NSObject

+ (instancetype)sharedSingleton;
- (void)setObject:(id<NSCoding>)object forKey:(NSString *)key withBlock:(void (^)(void))block;
- (void)objectForKey:(NSString *)key withBlock:(void (^)(NSString * key, id<NSCoding> object))block;
- (id<NSCoding>)objectForKey:(NSString *)key;
- (void)removeObjectForKey:(NSString *)key withBlock:(void (^)(NSString *))block;
- (BOOL)containsObjectForKey:(NSString *)key;

@end
