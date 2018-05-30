//
//  COLVCHelper.h
//  colourfullife
//
//  Created by Robert Xu on 16/4/5.
//  Copyright © 2016年 listcloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface COLVCHelper : NSObject

/*!
 *  设置Storyboard中的指定VC为整个应用的RootVC
 *
 *  @param sbName      Storyboard名称
 *  @param ident       VC的Identifier
 */
+ (void)col_switchRootVCToSBName:(NSString *)sbName identifier:(NSString *)ident;

/*!
 *  获取Storyboard中的指定VC的实例
 *
 *  @param sbName      Storyboard名称
 *  @param ident       VC的Identifier
 *
 *  @return 返回一个VC实例
 */
+ (id)col_vcFromSBName:(NSString *)sbName identifier:(NSString *)ident;

@end
