//
//  HomeService.m
//  parking
//
//  Created by Robert Xu on 2017/6/13.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "HomeService.h"
#import "AccountService.h"
#import "PostUserPoi.h"

@interface HomeService ()

@property (strong, nonatomic) PostUserPoi *postUserPoi;

@end

@implementation HomeService

- (void)getNearbyParkingListByLng:(NSString *)lng lat:(NSString *)lat r:(NSString *)r resultBlock:(hsHomeNearbyParkingListResultBlock)resultBlock {
    
    if (self.postUserPoi) {
        [self.postUserPoi stop];
    }
    self.postUserPoi = [[PostUserPoi alloc] initWithLng:lng lat:lat r:r];
    [self.postUserPoi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        BOOL isOK = [request isOK];
        if (isOK) {
            NSMutableArray <NearbyParkingModel *>*parkingList = [NSMutableArray arrayWithCapacity:10];
            if ([[request content] isKindOfClass:[NSString class]])
            {
                
            }
            else
            {
            NSArray *list = [request content];
            for (NSDictionary *parking in list) {
                [parkingList addObject:[NearbyParkingModel yy_modelWithJSON:parking]];
            }
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
