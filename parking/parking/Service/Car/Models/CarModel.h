//
//  CarModel.h
//  parking
//
//  Created by Robert Xu on 2017/6/14.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarModel : NSObject

@property (assign, nonatomic) NSInteger id;
@property (copy, nonatomic) NSString *plateNo;
@property (copy, nonatomic) NSString *type;
@property (assign, nonatomic) NSInteger defaultCar;

@end
