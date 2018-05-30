//
//  CreditModel.h
//  parking
//
//  Created by Robert Xu on 2017/6/13.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IntegralList :NSObject

@property (assign, nonatomic) NSInteger num;
@property (copy, nonatomic) NSString *addTime;
@property (copy, nonatomic) NSString *fromType;

@end

@interface CreditModel : NSObject

@property (assign ,nonatomic) NSInteger total;
@property (copy, nonatomic) NSString *signIn;
@property (strong, nonatomic) NSArray<IntegralList *> *integralList;

@end
