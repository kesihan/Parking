//
//  UserModel.h
//  parking
//
//  Created by Robert Xu on 2017/6/13.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject <NSCoding, NSCopying>

@property (copy, nonatomic) NSString *account;
@property (copy, nonatomic) NSString *birthday;
@property (copy, nonatomic) NSString *nickName;
@property (copy, nonatomic) NSString *status;
@property (copy, nonatomic) NSString *fid;
@property (copy, nonatomic) NSString *sex;
@property (copy, nonatomic) NSString *acquireCode;
@property (copy, nonatomic) NSString *invitationCode;
@property (copy, nonatomic) NSString *govid;
@property (copy, nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger cartotal;
@property (copy, nonatomic) NSString *id;
@property (copy, nonatomic) NSString *addTime;
@property (copy, nonatomic) NSString *mobile;
@property (copy, nonatomic) NSString *editTime;
@property (copy, nonatomic) NSString *join;
@property (copy, nonatomic) NSString *certification;
@property (copy, nonatomic) NSString *address;
@property (copy, nonatomic) NSString *integral;
@property (copy, nonatomic) NSString *headImage;
@end
