//
//  ParkingListService.m
//  parking
//
//  Created by Robert Xu on 2017/6/19.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "ParkingListService.h"
#import "PostUserPoiList.h"

@implementation ParkingListService

- (void)getNearbyParkingListByLng:(NSString *)lng
                              lat:(NSString *)lat
                                r:(NSString *)r
                        pageIndex:(NSString *)pageIndex
                             size:(NSString *)size
                      resultBlock:(plsNearbyParkingListResultBlock)resultBlock {
    
    PostUserPoiList *postUserPoiList = [[PostUserPoiList alloc] initWithLng:lng lat:lat r:r pageIndex:pageIndex size:size];
    [postUserPoiList startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        BOOL isOK = [request isOK];
        if (isOK) {
            NSMutableArray <NearbyParkingModel *>*parkingList = [NSMutableArray arrayWithCapacity:10];
            NSArray *list = [request content];
            for (NSDictionary *parking in list) {
                [parkingList addObject:[NearbyParkingModel yy_modelWithJSON:parking]];
            }
            resultBlock(isOK, [request message], parkingList);
        } else {
            resultBlock(isOK, [request message], nil);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        resultBlock(NO, [request message], nil);
    }];
}

@end
