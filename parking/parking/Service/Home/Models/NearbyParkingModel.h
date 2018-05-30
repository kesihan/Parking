//
//  NearbyParkingModel.h
//  parking
//
//  Created by Robert Xu on 2017/6/14.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Rules :NSObject
@property (assign, nonatomic) NSInteger id;
@property (copy, nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger feesID;
@property (copy, nonatomic) NSString *Rule;

@end

@interface FeeRule :NSObject
@property (assign, nonatomic) NSInteger id;
@property (copy, nonatomic) NSString *freeTime;//免费时长(分钟)
@property (strong, nonatomic) NSArray<Rules *> *Rules;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *ruleType;

@end

@interface NearbyParkingModel : NSObject

@property (copy, nonatomic) NSString *companyAdmin;
@property (copy, nonatomic) NSString *lotAddress;
@property (copy, nonatomic) NSString *areaName;
@property (copy, nonatomic) NSString *legalPersonCardid;
@property (copy, nonatomic) NSString *legalPersonPhone;
@property (copy, nonatomic) NSString *lotType;
@property (copy, nonatomic) NSString *lang;
@property (copy, nonatomic) NSString *feeStatus;
@property (copy, nonatomic) NSString *addressLongitude;
@property (copy, nonatomic) NSString *carType;
@property (copy, nonatomic) NSString *companyAddress;
@property (copy, nonatomic) NSString *addressLatitude;
@property (copy, nonatomic) NSString *garageTypeName;
@property (copy, nonatomic) NSString *lotTypeName;
@property (copy, nonatomic) NSString *legalPersonName;
@property (copy, nonatomic) NSString *companyAdminPhone;
@property (assign, nonatomic) NSInteger id;
@property (copy, nonatomic) NSString *jdprice;//每小时价格
@property (copy, nonatomic) NSString *lotName;//标题
@property (copy, nonatomic) NSString *feeCarType;
@property (copy, nonatomic) NSString *addTime;
@property (copy, nonatomic) NSString *companyName;
@property (copy, nonatomic) NSString *garageType;
@property (assign, nonatomic) NSInteger area;
@property (copy, nonatomic) NSString *editTime;
@property (copy, nonatomic) NSString *serviceTypeName;
@property (assign, nonatomic) NSInteger carportIdle;
@property (assign, nonatomic) NSInteger carportNum;
@property (copy, nonatomic) NSString *feeType;
@property (assign, nonatomic) NSInteger best;//1推荐，0不推荐
@property (copy, nonatomic) NSString *distance;//距离(米)
@property (copy, nonatomic) NSString *duration;//时长(秒)

@property (strong, nonatomic) FeeRule *feeRule;

//额外的属性，用于UI
@property (assign, nonatomic) BOOL isExpand;

@end
