//
//  HomePresenter.m
//  parking
//
//  Created by Robert Xu on 2017/5/18.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "HomePresenter.h"
#import "AccountService.h"
#import "CollectionService.h"


@interface HomePresenter () <COLPresenterProtocol>

@property (weak, nonatomic) id <HomePresenterDelegate> delegate;
@property (strong, nonatomic) HomeService *homeService;
@property (strong, nonatomic) CollectionService *collectionService;

@end

@implementation HomePresenter

- (instancetype)initWithService:(HomeService *)service {
    
    self = [super init];
    if (self) {
        _homeService = service;
    }
    return self;
}

- (void)attachView:(id<HomePresenterDelegate>)view {
    self.delegate = view;
}

- (void)detachView {
    self.delegate = nil;
}

- (void)getNearbyParkingListByLng:(NSString *)lng lat:(NSString *)lat {
    COLWeakSelf(self)
    [self.homeService getNearbyParkingListByLng:lng lat:lat r:@"500" resultBlock:^(BOOL success, NSString *message, NSArray<NearbyParkingModel *> *parkingList) {
        COLStrongSelf(self)
        if (self.delegate && [self.delegate respondsToSelector:@selector(homeNearbyParkingListDidLoadedSuccess:message:nearbyParkingList:)]) {
            [self.delegate homeNearbyParkingListDidLoadedSuccess:success message:message nearbyParkingList:parkingList];
        }
    }];
}

- (BOOL)isUserLogin {
    return [AccountService isLogin];
}

- (void)addCollectionByParkingID:(NSString *)parkingID {
    NSString *userID = [AccountService userModel].id;
    self.collectionService = [[CollectionService alloc] init];
    COLWeakSelf(self)
    [self.collectionService addCollectionByUserID:userID objectType:@"lot" objectID:parkingID resultBlock:^(BOOL success, NSString *message) {
        COLStrongSelf(self)
        if (self.delegate && [self.delegate respondsToSelector:@selector(homeAddCollectionSuccess:message:)]) {
            [self.delegate homeAddCollectionSuccess:success message:message];
        }
    }];
}

@end
