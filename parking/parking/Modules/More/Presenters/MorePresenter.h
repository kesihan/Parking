//
//  MorePresenter.h
//  parking
//
//  Created by Robert Xu on 2017/5/22.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MoreCellModel.h"
#import "MoreService.h"

@protocol MorePresenterDelegate <NSObject>

- (void)setMoreMenu:(NSMutableArray<MoreCellModel *> *)menu;

@end

@interface MorePresenter : NSObject <COLPresenterProtocol>

//协议方法
- (instancetype)initWithService:(MoreService *)service;

- (void)attachView:(id<MorePresenterDelegate>)view;

- (void)detachView;

- (void)getMenu;

@end
