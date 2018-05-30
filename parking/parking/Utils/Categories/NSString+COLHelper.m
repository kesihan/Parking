//
//  NSString+COLHelper.m
//  parking
//
//  Created by Robert Xu on 2017/6/8.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "NSString+COLHelper.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (COLHelper)

/*!
 *  MD5加密
 */
- (NSString *)col_MD5
{
    const char *original_str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (int)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}

/*!
 *  去除字符串前后的空格
 */
- (NSString*)col_trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

/*!
 *  判断是否是邮箱
 */
- (BOOL)col_isValidEmail{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

/*!
 *  判断是否是手机号
 */
- (BOOL)col_isValidMobileNumber
{
    NSString *pattern = @"^1+[3578]+\\d{9}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

/*!
 *  将手机部分数字隐藏为*号
 */
- (NSString *)col_showAsteriskFromIndex:(NSUInteger)startIndex to:(NSUInteger)finIndex {
    NSUInteger numOfAsterisk = finIndex - startIndex + 1;
    
    return [NSString stringWithFormat:@"%@%@%@", [self substringToIndex:startIndex], [@"" stringByPaddingToLength:numOfAsterisk withString:@"*" startingAtIndex:0],[self substringFromIndex:finIndex+1]];
}


@end
