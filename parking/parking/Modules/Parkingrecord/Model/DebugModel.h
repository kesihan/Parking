//
//  DebugModel.h
//  parking
//
//  Created by 柯思汉 on 2018/3/6.
//  Copyright © 2018年 huafangcloud. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
停车记录接口
 */
@interface DebugItem : NSObject
@property (nonatomic,strong)NSString *add_time;

@property (nonatomic,strong)NSString *carport_id;

@property (nonatomic,strong)NSString *charge_number;

@property (nonatomic,strong)NSString *ID;

@property (nonatomic,strong)NSString *image;

@property (nonatomic,strong)NSString *in_time;

@property (nonatomic,strong)NSString *license_plate;

@property (nonatomic,strong)NSString *money;

@property (nonatomic,strong)NSString * name;

@property (nonatomic,strong)NSString *operator_id;

@property (nonatomic,strong)NSString *out_time;

@property (nonatomic,strong)NSString * parking_number;

@property (nonatomic,strong)NSString *pay_time;

@property (nonatomic,strong)NSString * status;

@property (nonatomic,strong)NSString *upload_id;

@property (nonatomic,strong)NSString *longtime;
@end

@interface DebugModel : NSObject
@property (nonatomic,strong)NSMutableArray <DebugItem *> *content;
@end
