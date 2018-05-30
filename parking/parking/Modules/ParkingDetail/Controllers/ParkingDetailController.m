//
//  ParkingDetailController.m
//  parking
//
//  Created by Robert Xu on 2017/5/23.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "ParkingDetailController.h"
//Cell
#import "ParkingItemExpHeader.h"
#import "ParkingItemTopCell.h"
#import "ParkingItemTitleCell.h"
#import "ParkingItemCell.h"
#import "ParkingItemBottomCell.h"
#import "UIImage+Helper.h"
#import "UIViewController+Swizzling.h"
#import <CoreLocation/CoreLocation.h>
#import "COLMap.h"

#import "COLMediator+Home.h"

@interface ParkingDetailController () <UITableViewDataSource, UITableViewDelegate, COLUIViewControllerDelegate, ParkingItemExpHeaderDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ParkingDetailController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma amrk - COLUIViewControllerDelegate

- (void)customReturnAction:(id)sender {
    //从下往上push的效果
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromBottom;
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma makr - setup

- (void)setup {
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 20;
}

//折叠时候header高度173，非折叠时候147
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 147;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    ParkingItemExpHeader *header = [[ParkingItemExpHeader alloc] initWithFrame:CGRectZero];
    [header showData:self.detail];
    header.delegate = self;
    header.section = section;
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    NSInteger rowNumber = [self getSectionRowNumberBy:self.detail];
    
    if (0 == row) {
        //正常160 (头：固定一个)
        ParkingItemTopCell *cell = [ParkingItemTopCell cellForTableView:tableView];
//        cell
        return cell;
    }  else if (rowNumber - 1 == row) {
        
        //固定20（尾：固定一个）
        ParkingItemBottomCell *cell = [ParkingItemBottomCell cellForTableView:tableView];
        return cell;
    } else if (row > 0 && row < (rowNumber - 1)) {
        if (row % 2 == 1) {
            //时间段
            ParkingItemTitleCell *cell = [ParkingItemTitleCell cellForTableView:tableView];
            [cell showData:self.detail.feeRule.Rules[row / 2].name];
            return cell;
        } else {
            //具体收费
            ParkingItemCell *cell = [ParkingItemCell cellForTableView:tableView];
            [cell showDataWithCarType:@"全部车辆" detail:self.detail.feeRule.Rules[(row - 1) / 2].Rule];
            return cell;
        }
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //计算section的行数
    NSInteger rowNumber = [self getSectionRowNumberBy:self.detail];
    return rowNumber;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


#pragma mark - getter & setter

#pragma mark - ParkingItemExpHeaderDelegate

- (void)parkingItemExpNaviButtonClickedWithLng:(NSString *)lng lat:(NSString *)lat {
    COLWeakSelf(self)
    [[COLMap sharedCOLMap] startSingleLocWithReGeocode:NO CompletionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        COLStrongSelf(self)
        CLLocation *end = [[CLLocation alloc] initWithLatitude:[lat doubleValue] longitude:[lng doubleValue]];
//        导航界面
        [self.navigationController pushViewController:[[COLMediator sharedInstance] homeNaviControllerWithParams:@{@"start": location, @"end": end}] animated:YES];
    }];
}

- (NSInteger)getSectionRowNumberBy:(NearbyParkingModel *)model {
    NSInteger row = 0;
    if (model.feeRule.Rules) {
        row = [model.feeRule.Rules count];
    }
    row = (2 + row*2);
    return row;
}

@end
