//
//  ParkingItemHeader.m
//  parking
//
//  Created by Robert Xu on 2017/5/22.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "ParkingItemHeader.h"
#import "CommonTools.h"

@interface ParkingItemHeader ()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *recommendTag;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *recommendTagWidth;//28
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelLeadingWidth;//5
//标题
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *freeLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@property (copy, nonatomic) NSString *lng;
@property (copy, nonatomic) NSString *lat;

@end

@implementation ParkingItemHeader

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self customInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self customInit];
    }
    return self;
}

- (void)customInit {
    [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    [self addSubview:self.contentView];
    self.contentView.frame = self.bounds;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction:)];
    [self.contentView addGestureRecognizer:tap];
}

- (void)clickAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(parkingItemHeaderDidClick:)]) {
        [self.delegate parkingItemHeaderDidClick:self.section];
    }
}

- (IBAction)startNaviAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(parkingItemHeaderNaviButtonClickedWithLng:lat:)]) {
        [self.delegate parkingItemHeaderNaviButtonClickedWithLng:self.lng lat:self.lat];
    }
}

- (void)showData:(NearbyParkingModel *)model {
    if (model.best == 0) {
        self.recommendTag.hidden = YES;
        self.recommendTagWidth.constant = 0;
        self.titleLabelLeadingWidth.constant = 0;
    } else {
        self.recommendTag.hidden = NO;
        self.recommendTagWidth.constant = 28;
        self.titleLabelLeadingWidth.constant = 5;
    }
    self.titleLabel.text = model.lotName;
    self.addressLabel.text = model.lotAddress;
    NSMutableAttributedString *phoneText = [[NSMutableAttributedString alloc] initWithString:model.companyAdminPhone];
    NSRange phoneTextRange = {0,[phoneText length]};
    [phoneText addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:phoneTextRange];
    self.phoneLabel.attributedText = phoneText;
    self.distanceLabel.text = [NSString stringWithFormat:@"距您%@", [CommonTools normalizedRemainDistance:[model.distance integerValue]]];
    self.freeLabel.attributedText = [CommonTools freeLabelAttributedStringWithFree:model.carportIdle total:model.carportNum];
    //    self.descLabel.text =
    self.lng = model.addressLongitude;
    self.lat = model.addressLatitude;
}

@end
