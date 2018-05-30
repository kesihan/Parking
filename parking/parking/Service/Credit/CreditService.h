//
//  CreditService.h
//  parking
//
//  Created by Robert Xu on 2017/6/13.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CreditModel.h"

typedef void (^csCreditResultBlock) (BOOL success, NSString *message, CreditModel *creditModel);

@interface CreditService : NSObject

- (void)getCreditListByUserID:(NSString *)userID pageIndex:(NSString *)pageIndex size:(NSString *)size resultBlock:(csCreditResultBlock)resultBlock;
- (void)signDailyByUserID:(NSString *)userID resultBlock:(csCreditResultBlock)resultBlock;

@end
