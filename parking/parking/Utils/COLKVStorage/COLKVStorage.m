//
//  COLKVStorage.m
//  shoucangjia
//
//  Created by Robert Xu on 16/4/27.
//  Copyright © 2016年 listcloud. All rights reserved.
//

#import <YYCache/YYCache.h>
#import "COLKVStorage.h"

@interface COLKVStorage ()

@property (nonatomic, strong) YYCache *cache;

@end

@implementation COLKVStorage

static id _instance;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
        [_instance initCache];
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone{
    return _instance;
}

+ (instancetype)sharedSingleton {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
        [_instance initCache];
    });
    return _instance;
}

//存储在Documents目录
- (void)initCache {
    NSString *basePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) lastObject];
    basePath = [basePath stringByAppendingPathComponent:@"colkvstorage"];
    if (!self.cache) {
        self.cache = [[YYCache alloc] initWithPath:basePath];;
    }
}

- (void)setObject:(id<NSCoding>)object forKey:(NSString *)key withBlock:(void (^)(void))block {
    [self.cache setObject:object forKey:key withBlock:^{
        block();
    }];
}

- (void)objectForKey:(NSString *)key withBlock:(void (^)(NSString * key, id<NSCoding> object))block {
    [self.cache objectForKey:key withBlock:^(NSString *key, id<NSCoding> object) {
        block(key, object);
    }];
}

- (id<NSCoding>)objectForKey:(NSString *)key {
    return [self.cache objectForKey:key];
}

- (void)removeObjectForKey:(NSString *)key withBlock:(void (^)(NSString *))block {
    [self.cache removeObjectForKey:key withBlock:^(NSString *key) {
        block(key);
    }];
}

- (BOOL)containsObjectForKey:(NSString *)key {
    return [self.cache containsObjectForKey:key];
}

@end
