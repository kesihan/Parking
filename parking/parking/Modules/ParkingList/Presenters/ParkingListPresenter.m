//
//  ParkingListPresenter.m
//  parking
//
//  Created by Robert Xu on 2017/6/19.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "ParkingListPresenter.h"

@interface ParkingListPresenter ()

@property (weak, nonatomic) id <ParkingListPresenterDelegate> delegate;
@property (strong, nonatomic) ParkingListService *parkingListService;

//参数
@property (assign, nonatomic) NSUInteger pageIndex;
@property (assign, nonatomic) NSUInteger pageSize;
@property (strong, nonatomic) NSMutableArray *parkingList;

@end

@implementation ParkingListPresenter

- (instancetype)initWithService:(ParkingListService *)service {
    
    self = [super init];
    if (self) {
        _parkingListService = service;
        _pageIndex = 1;
        _pageSize = 10;
    }
    return self;
}

- (void)attachView:(id<ParkingListPresenterDelegate>)view {
    self.delegate = view;
}

- (void)detachView {
    self.delegate = nil;
}

- (void)getParkingListByLng:(NSString *)lng lat:(NSString *)lat {
    
    NSString *pageIndex = [NSString stringWithFormat:@"%lu", (unsigned long)self.pageIndex];
    NSString *size = [NSString stringWithFormat:@"%lu", (unsigned long)self.pageSize];
    COLWeakSelf(self)
    [self.parkingListService getNearbyParkingListByLng:lng lat:lat r:@"500" pageIndex:pageIndex size:size resultBlock:^(BOOL success, NSString *message, NSArray<NearbyParkingModel *> *parkingList) {
        COLStrongSelf(self)
        if ([pageIndex integerValue] == 1) {
            self.parkingList = [NSMutableArray arrayWithArray:parkingList];
        } else {
            [self.parkingList addObjectsFromArray:parkingList];
        }
        _pageIndex ++;
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(parkingListDidLoadedSuccess:message:nearbyParkingList:)]) {
            [self.delegate parkingListDidLoadedSuccess:success message:message nearbyParkingList:self.parkingList];
        }
    }];
}

@end
