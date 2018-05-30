//
//  CarController.m
//  parking
//
//  Created by Robert Xu on 2017/5/24.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "CarController.h"
#import "CarCell.h"
#import "CarFooter.h"
#import "CarPresenter.h"

#import "COLMediator+AddCar.h"
#import "UIViewController+Swizzling.h"

@interface CarController () <CarFooterDelegate, UITableViewDelegate, UITableViewDataSource, CarPresenterDelegate, CarCellDelegate, COLUIViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) CarPresenter *carPresenter;
@property (strong, nonatomic) NSMutableArray *carList;
@property (copy, nonatomic) NSString *settedDefaultCarPlateNo;
@property (copy, nonatomic) NSString *defaultCarPlateNo;

@end

@implementation CarController

#pragma mark - COLUIViewControllerDelegate

- (void)customReturnAction:(id)sender {
    
    if (![self.defaultCarPlateNo isEqualToString:self.settedDefaultCarPlateNo]) {
        [self.carPresenter setDefaultCarByPlateNo:self.settedDefaultCarPlateNo];
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - CarCellDelegate

- (void)carCellSetDefaultWithPalteNo:(NSString *)plateNo {
    self.settedDefaultCarPlateNo = plateNo;
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate


#pragma mark - UITableViewDataSource

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    CarFooter *footer = [[CarFooter alloc] initWithFrame:CGRectZero];
    footer.delegate = self;
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 80.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return COLTableViewCellSectionDefaultVerticalSpace;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.carList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CarCell *cell = [CarCell cellForTableView:tableView];
    cell.delegate = self;
    CarModel *carModel = self.carList[indexPath.row];
    if ([carModel.plateNo isEqualToString:self.settedDefaultCarPlateNo]) {
        [cell setDefaultCarCell:YES];
    } else {
        [cell setDefaultCarCell:NO];
    }
    [cell showData:carModel];
    return cell;
}

//删除操作
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        CarModel *carModel = self.carList[row];
        [self.carPresenter deleteCarByCarID:[NSString stringWithFormat:@"%ld", (long)carModel.id]];
        [self.carList removeObjectAtIndex:row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

#pragma mark - CarFooterDelegate

- (void)carFooterAddCarButtonClicked:(UIButton *)button {
    
    if ([self.carList count] < 3) {
        [self.navigationController pushViewController:[[COLMediator sharedInstance] addCarController] animated:YES];
    } else {
        [COLToast showToast:@"最多可添加3辆"];
    }
    
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

- (void)dealloc {
    [_carPresenter detachView];
}

#pragma mark - setup 

- (void)setup {
    
    self.settedDefaultCarPlateNo = @"";
    self.carList = [NSMutableArray arrayWithCapacity:10];
    
    self.carPresenter = [[CarPresenter alloc] initWithService:[[CarService alloc] init]];
    [self.carPresenter attachView:self];
    
    [self.carPresenter getCarList];
    
    
}

#pragma mark - CarPresenterDelegate

- (void)carSetDefaultSuccess:(BOOL)success message:(NSString *)message {
    [COLToast showToast:message];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)carListDidLoadedSuccess:(BOOL)success message:(NSString *)message carList:(NSArray<CarModel *> *)carList {
    [self.carList removeAllObjects];
    [self.carList addObjectsFromArray:carList];
    
    for (CarModel *carModel in carList) {
        BOOL isDefaultCar = (carModel.defaultCar == 1) ? YES : NO;
        if (isDefaultCar) {
            self.defaultCarPlateNo = carModel.plateNo;
            self.settedDefaultCarPlateNo = carModel.plateNo;
        }
    }
    [self.tableView reloadData];
}

- (void)carDeleteSuccess:(BOOL)success message:(NSString *)message {
    if (success) {
        [COLToast showToast:message];
    } else {
        [COLToast showToast:message];
    }
}

@end
