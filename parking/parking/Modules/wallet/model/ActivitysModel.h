//
//  ActivitysModel.h
//  parking
//
//  Created by 柯思汉 on 2018/3/19.
//  Copyright © 2018年 huafangcloud. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface ActivitysItem : NSObject
@property (nonatomic,strong)NSString *ID;

@property (nonatomic,strong)NSString *add_time;

@property (nonatomic,strong)NSString *give;

@property (nonatomic,strong)NSString *reality;
@end

@interface ActivitysModel : NSObject
@property (nonatomic,strong)NSMutableArray <ActivitysItem *> *content;
@end
