//
//  MyPresenter.h
//  parking
//
//  Created by Robert Xu on 2017/5/18.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyService.h"
#import "MyCellModel.h"

@protocol MyPresenterDelegate <NSObject>

- (void)setMyMenu:(NSMutableArray<MyCellModel *> *)menu;

@end

@interface MyPresenter : NSObject <COLPresenterProtocol>

//协议方法
- (instancetype)initWithService:(MyService *)service;

- (void)attachView:(id<MyPresenterDelegate>)view;

- (void)detachView;

//其他方法
- (void)getMenu;
//有没有车
- (BOOL)hasCar;

@end
