//
//  QAPresenter.h
//  parking
//
//  Created by Robert Xu on 2017/6/7.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QACellModel.h"
#import "QAService.h"

@protocol QAPresenterDelegate <NSObject>

- (void)setQAMenu:(NSMutableArray<QACellModel *> *)menu;

@end

@interface QAPresenter : NSObject <COLPresenterProtocol>

//协议方法
- (instancetype)initWithService:(QAService *)service;

- (void)attachView:(id<QAPresenterDelegate>)view;

- (void)detachView;

- (void)getMenu;

@end
