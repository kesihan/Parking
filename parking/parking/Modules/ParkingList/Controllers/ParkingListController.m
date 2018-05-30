//
//  ParkingListController.m
//  parking
//
//  Created by Robert Xu on 2017/5/19.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "ParkingListController.h"

//Cell
#import "ParkingItemHeader.h"
#import "ParkingItemExpHeader.h"
#import "ParkingItemTopCell.h"
#import "ParkingItemTitleCell.h"
#import "ParkingItemCell.h"
#import "ParkingItemBottomCell.h"
#import "MKDropdownMenu.h"
#import "UIImage+Helper.h"
#import "COLMap.h"
#import <MJRefresh/MJRefresh.h>
#import "COLMediator+Home.h"
#import "ParkingListPresenter.h"

@interface ParkingListController () <UITableViewDataSource, UITableViewDelegate, ParkingItemHeaderDelegate, ParkingItemExpHeaderDelegate, MKDropdownMenuDataSource, MKDropdownMenuDelegate, ParkingListPresenterDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet MKDropdownMenu *dropdownMenu;


//辅助
@property (weak, nonatomic) IBOutlet UIView *secondButtonView;
@property (weak, nonatomic) IBOutlet UIView *thirdButtonView;
@property (weak, nonatomic) IBOutlet UILabel *firstButtonLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondButtonLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdButtonLabel;
@property (weak, nonatomic) IBOutlet UIView *firstButtonTrack;
@property (weak, nonatomic) IBOutlet UIView *secondButtonTrack;
@property (weak, nonatomic) IBOutlet UIView *thirdButtonTrack;

@property (strong, nonatomic) ParkingListPresenter *parkingListPresenter;
@property (strong, nonatomic) NSMutableArray<NearbyParkingModel *> *parkingList;

@end

@implementation ParkingListController

#pragma mark - ParkingListPresenterDelegate

- (void)parkingListDidLoadedSuccess:(BOOL)success message:(NSString *)message nearbyParkingList:(NSArray<NearbyParkingModel *> *)parkingList {
    self.parkingList = [NSMutableArray arrayWithArray:parkingList];
    [self.tableView reloadData];
}

#pragma mark - ParkingItemHeaderDelegate

- (void)parkingItemHeaderDidClick:(NSInteger)section {
    NearbyParkingModel *model = self.parkingList[section];
    model.isExpand = !model.isExpand;
    [self.tableView reloadData];
}

- (void)parkingItemHeaderNaviButtonClickedWithLng:(NSString *)lng lat:(NSString *)lat {
    COLWeakSelf(self)
    [[COLMap sharedCOLMap] startSingleLocWithReGeocode:NO CompletionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        COLStrongSelf(self)
        CLLocation *end = [[CLLocation alloc] initWithLatitude:[lat doubleValue] longitude:[lng doubleValue]];
        [self.navigationController pushViewController:[[COLMediator sharedInstance] homeNaviControllerWithParams:@{@"start": location, @"end": end}] animated:YES];
    }];
}

- (void)parkingItemExpNaviButtonClickedWithLng:(NSString *)lng lat:(NSString *)lat {
    COLWeakSelf(self)
    [[COLMap sharedCOLMap] startSingleLocWithReGeocode:NO CompletionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        COLStrongSelf(self)
        CLLocation *end = [[CLLocation alloc] initWithLatitude:[lat doubleValue] longitude:[lng doubleValue]];
        [self.navigationController pushViewController:[[COLMediator sharedInstance] homeNaviControllerWithParams:@{@"start": location, @"end": end}] animated:YES];
    }];
}

- (void)parkingItemExpHeaderDidClick:(NSInteger)section {
    NearbyParkingModel *model = self.parkingList[section];
    model.isExpand = !model.isExpand;
    [self.tableView reloadData];
}

#pragma mark - setup

- (void)setup {
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 20;
    
    self.dropdownMenu.disclosureIndicatorImage = [UIImage imageWithBgColor:[UIColor clearColor]];
    self.dropdownMenu.dropdownBouncesScroll = NO;
    self.dropdownMenu.rowTextAlignment = NSTextAlignmentCenter;
    
    //设置顶部按钮action
    UITapGestureRecognizer *tapSecond = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSecondAction:)];
    [self.secondButtonView addGestureRecognizer:tapSecond];
    
    UITapGestureRecognizer *tapThird = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapThirdAction:)];
    [self.thirdButtonView addGestureRecognizer:tapThird];
    
    //设置右上角按钮
    UIBarButtonItem* itemSearch = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"parkinglist_icon_search_nor"] style:UIBarButtonItemStylePlain target:self action:@selector(itemSearchAction:)];
    UIBarButtonItem* itemLocation = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"parkinglist_icon_big_position_nor"] style:UIBarButtonItemStylePlain target:self action:@selector(itemLocationAction:)];
    NSArray* array = @[itemLocation, itemSearch];
    self.navigationItem.rightBarButtonItems = array;
    
    self.parkingListPresenter = [[ParkingListPresenter alloc] initWithService:[[ParkingListService alloc] init]];
    [self.parkingListPresenter attachView:self];
    
    self.parkingList = [NSMutableArray arrayWithCapacity:1];
    
    COLWeakSelf(self)
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        COLStrongSelf(self);
        [self.parkingListPresenter getParkingListByLng:_lng lat:_lat];
        
        dispatch_async(dispatch_get_main_queue(), ^(){
            [self.tableView.mj_footer endRefreshing];
        });
        
    }];
    
    [self.tableView.mj_footer beginRefreshing];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


//折叠时候header高度173，非折叠时候147
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    NearbyParkingModel *model = self.parkingList[section];
    if (model.isExpand) {
        return 147;
    } else {
        return 173;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NearbyParkingModel *model = self.parkingList[section];
    if (model.isExpand) {
        ParkingItemExpHeader *header = [[ParkingItemExpHeader alloc] initWithFrame:CGRectZero];
        header.delegate = self;
        header.section = section;
        [header showData:self.parkingList[section]];
        return header;
    } else {
        ParkingItemHeader *header = [[ParkingItemHeader alloc] initWithFrame:CGRectZero];
        header.delegate = self;
        header.section = section;
        [header showData:self.parkingList[section]];
        return header;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    NearbyParkingModel *model = self.parkingList[indexPath.section];
    NSInteger rowNumber = [self getSectionRowNumberBy:model];
    
    if (0 == row) {
        //正常160高度，仅需1个
        ParkingItemTopCell *cell = [ParkingItemTopCell cellForTableView:tableView];
        return cell;
    }  else if (rowNumber - 1 == row) {
        
        //底部提醒，固定20
        ParkingItemBottomCell *cell = [ParkingItemBottomCell cellForTableView:tableView];
        return cell;
    }  else if (row > 0 && row < (rowNumber - 1)) {
        if (row % 2 == 1) {
            //时间段
            ParkingItemTitleCell *cell = [ParkingItemTitleCell cellForTableView:tableView];
            [cell showData:model.feeRule.Rules[row / 2].name];
            return cell;
        } else {
            //具体收费
            ParkingItemCell *cell = [ParkingItemCell cellForTableView:tableView];
            [cell showDataWithCarType:@"全部车辆" detail:model.feeRule.Rules[(row - 1) / 2].Rule];
            return cell;
        }
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NearbyParkingModel *model = self.parkingList[section];
    if (model.isExpand) {
        //计算需要多少行
        NSInteger rowNumber = [self getSectionRowNumberBy:model];
        return rowNumber;
        return 0;
    } else {
        return 0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.parkingList count];
}

#pragma mark - MKDropdownMenuDataSource

- (NSInteger)numberOfComponentsInDropdownMenu:(MKDropdownMenu *)dropdownMenu {
    return 1;
}

- (NSInteger)dropdownMenu:(MKDropdownMenu *)dropdownMenu numberOfRowsInComponent:(NSInteger)component {
    return 3;
}

#pragma mark - MKDropdownMenuDelegate

- (CGFloat)dropdownMenu:(MKDropdownMenu *)dropdownMenu rowHeightForComponent:(NSInteger)component {
    return 40;
}

- (NSString *)dropdownMenu:(MKDropdownMenu *)dropdownMenu titleForComponent:(NSInteger)component {
    return @"";
}

- (NSAttributedString *)dropdownMenu:(MKDropdownMenu *)dropdownMenu attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    NSString *title = @"";
    switch (row) {
        case 0:
        {
            title = @"综合排序";
        }
            break;
        case 1:
        {
            title = @"价格优先";
        }
            break;
        case 2:
        {
            title = @"空位最多";
        }
            break;
            
        default:
            break;
    }
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@"%@", title] attributes:@{NSFontAttributeName: COL_DefaultFont_Size(14.0f), NSForegroundColorAttributeName: UIColorFromRGB(0x111111)}];
    return string;
}


- (void)dropdownMenu:(MKDropdownMenu *)dropdownMenu didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    //根据选中的项目来过滤
    
    [dropdownMenu closeAllComponentsAnimated:YES];
}

//展开下来菜单的时候
- (void)dropdownMenu:(MKDropdownMenu *)dropdownMenu didOpenComponent:(NSInteger)component {
    [self setCurrentButtonSelected:1];
}

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.dropdownMenu closeAllComponentsAnimated:YES];
}

- (void)dealloc {
    [_parkingListPresenter detachView];
}

#pragma mark - action
//离我最近
- (void)tapSecondAction:(id)sender {
    [self.dropdownMenu closeAllComponentsAnimated:YES];
    [self setCurrentButtonSelected:2];
}
//离目的地最近
- (void)tapThirdAction:(id)sender {
    [self.dropdownMenu closeAllComponentsAnimated:YES];
    [self setCurrentButtonSelected:3];
}

- (void)setCurrentButtonSelected:(NSInteger)number {
    switch (number) {
        case 1:
        {
            [self setSelected:YES label:self.firstButtonLabel track:self.firstButtonTrack];
            [self setSelected:NO label:self.secondButtonLabel track:self.secondButtonTrack];
            [self setSelected:NO label:self.thirdButtonLabel track:self.thirdButtonTrack];
        }
            break;
        case 2:
        {
            [self setSelected:YES label:self.secondButtonLabel track:self.secondButtonTrack];
            [self setSelected:NO label:self.firstButtonLabel track:self.firstButtonTrack];
            [self setSelected:NO label:self.thirdButtonLabel track:self.thirdButtonTrack];
        }
            break;
        case 3:
        {
            [self setSelected:YES label:self.thirdButtonLabel track:self.thirdButtonTrack];
            [self setSelected:NO label:self.firstButtonLabel track:self.firstButtonTrack];
            [self setSelected:NO label:self.secondButtonLabel track:self.secondButtonTrack];
        }
            break;
            
        default:
            break;
    }
}

- (void)setSelected:(BOOL)selected label:(UILabel *)label track:(UIView *)track {
    if (selected) {
        label.textColor = UIColorFromRGB(0x111111);
        track.backgroundColor = UIColorFromRGB(0x3EB4F8);
    } else {
        label.textColor = UIColorFromRGB(0x8A8A8A);
        track.backgroundColor = [UIColor whiteColor];
    }
}

//右上角按钮
- (void)itemSearchAction:(id)sender {
    
}

- (void)itemLocationAction:(id)sender {
    
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
