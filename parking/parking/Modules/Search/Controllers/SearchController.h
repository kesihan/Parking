//
//  SearchController.h
//  parking
//
//  Created by Robert Xu on 2017/5/25.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <UIKit/UIKit.h>
//高德搜索SDK
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "COLMap.h"

typedef void (^selectAmapPOI) (AMapPOI *poi);
@interface SearchController : UIViewController

@property (nonatomic, copy)   selectAmapPOI Block;
@end
