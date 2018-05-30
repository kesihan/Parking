//
//  HomeBottomCell.m
//  parking
//
//  Created by Robert Xu on 2017/5/23.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "HomeBottomCell.h"
#import "UIView+Helper.h"
#import "CommonTools.h"

@interface HomeBottomCell ()

@property (weak, nonatomic) IBOutlet UIImageView *recommendTag;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *recommendTagWidth;//28
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelLeadingWidth;//10

//UI辅助
@property (weak, nonatomic) IBOutlet UIView *pullupBgShadow;
@property (strong, nonatomic) NearbyParkingModel *model;

@end

@implementation HomeBottomCell

- (void)awakeFromNib{
    [super awakeFromNib];
    //设置阴影
    [self.bgView setDefaultShadow];
    
    [self.pullupBgShadow setDefaultShadow];
    
    //添加上滑手势
    UISwipeGestureRecognizer * recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionUp)];
    [self.bgView addGestureRecognizer:recognizer];
}


- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer {
    if(recognizer.direction == UISwipeGestureRecognizerDirectionUp) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(homeBottomCellSwipeUpAtIndexPath:parkingDetail:)]) {
            [self.delegate homeBottomCellSwipeUpAtIndexPath:self.indexPath parkingDetail:self.model];
        }
    }
}

- (IBAction)collectAction:(UIButton*)sender {
    //换图标
    sender.selected=!sender.selected;
    if (self.delegate && [self.delegate respondsToSelector:@selector(homeBottomCollectButtonClickedWithParkingID:)]) {
        [self.delegate homeBottomCollectButtonClickedWithParkingID:[NSString stringWithFormat:@"%ld", (long)self.model.id]];
    }
}

- (IBAction)naviAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(homeBottomNaviButtonClickedWithLng:lat:)]) {
        [self.delegate homeBottomNaviButtonClickedWithLng:self.model.addressLongitude lat:self.model.addressLatitude];
    }
}

- (void)showData:(NearbyParkingModel *)model {
    self.titleLabel.text = model.lotName;
    NSString *price = model.jdprice;
    if (price == nil || [price length] <= 0) {
        price = @"0";
    }
    
    self.distanceLabel.text = [NSString stringWithFormat:@"%@ | %@",
                               [CommonTools normalizedRemainDistance:[model.distance integerValue]],
                               [CommonTools normalizedRemainTime:[model.duration integerValue]]];
    if (model.feeRule.freeTime == nil || [model.feeRule.freeTime isEqualToString:@""]) {
        self.priceLabel.text = [NSString stringWithFormat:@"%@元/小时", price];
    } else {
        self.priceLabel.text = [NSString stringWithFormat:@"%@元/小时 | 免%@分钟", price, model.feeRule.freeTime];
    }
    
    if (model.best == 0) {
        self.recommendTag.hidden = YES;
        self.recommendTagWidth.constant = 0;
        self.titleLabelLeadingWidth.constant = 0;
    } else {
        self.recommendTag.hidden = NO;
        self.recommendTagWidth.constant = 28;
        self.titleLabelLeadingWidth.constant = 10;
    }
    self.model = model;
}

@end
