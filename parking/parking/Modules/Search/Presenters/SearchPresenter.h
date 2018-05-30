//
//  SearchPresenter.h
//  parking
//
//  Created by Robert Xu on 2017/6/15.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchService.h"

@protocol SearchPresenterDelegate <NSObject>



@end

@interface SearchPresenter : NSObject <COLPresenterProtocol>

//协议方法
- (instancetype)initWithService:(SearchService *)service;

- (void)attachView:(id<SearchPresenterDelegate>)view;

- (void)detachView;

@end
