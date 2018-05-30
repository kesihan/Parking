//
//  NSString+COLHelper.h
//  parking
//
//  Created by Robert Xu on 2017/6/8.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (COLHelper)

- (NSString *)col_MD5;
- (NSString*)col_trim;
- (BOOL)col_isValidEmail;
- (BOOL)col_isValidMobileNumber;
- (NSString *)col_showAsteriskFromIndex:(NSUInteger)startIndex to:(NSUInteger)finIndex;

@end
