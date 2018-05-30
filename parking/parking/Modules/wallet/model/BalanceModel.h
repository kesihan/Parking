//
//  BalanceModel.h
//  parking
//
//  Created by 柯思汉 on 2018/3/15.
//  Copyright © 2018年 huafangcloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BalanceItem : NSObject
@property (nonatomic,strong)NSString *ID;

@property (nonatomic,strong)NSString *money;

@property (nonatomic,strong)NSString *add_time;

@property (nonatomic,strong)NSString *userID;

@property (nonatomic,strong)NSString *type;
@end

@interface BalanceModel : NSObject
@property (nonatomic,strong)NSMutableArray <BalanceItem *> *content;
@end
