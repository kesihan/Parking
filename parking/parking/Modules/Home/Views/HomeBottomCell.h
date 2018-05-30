//
//  HomeBottomCell.h
//  parking
//
//  Created by Robert Xu on 2017/5/23.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NearbyParkingModel.h"

@protocol HomeBottomCellDelegate <NSObject>

- (void)homeBottomCellSwipeUpAtIndexPath:(NSIndexPath *)indexPath parkingDetail:(NearbyParkingModel *)detail;
- (void)homeBottomNaviButtonClickedWithLng:(NSString *)lng lat:(NSString *)lat;
- (void)homeBottomCollectButtonClickedWithParkingID:(NSString *)parkingID;

@end

@interface HomeBottomCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *collectButton;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (assign, nonatomic) NSInteger index;

@property (weak, nonatomic) id <HomeBottomCellDelegate> delegate;
@property (strong, nonatomic) NSIndexPath *indexPath;

- (void)showData:(NearbyParkingModel *)model;

@end
