//
//  CollectionController.m
//  parking
//
//  Created by Robert Xu on 2017/5/24.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "CollectionController.h"
#import "CollectionCell.h"
#import "COLMap.h"
#import "COLMediator+Home.h"
#import <MJRefresh/MJRefresh.h>
#import "CollectionPresenter.h"

@interface CollectionController () <UITableViewDataSource, UITableViewDelegate, CollectionPresenterDelegate, CollectionCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) CollectionPresenter *collectionPresenter;

@property (strong, nonatomic) NSMutableArray<CollectionModel *> *collectionList;

@end

@implementation CollectionController

#pragma mark - UITableViewDelegate


#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return COLTableViewCellSectionDefaultVerticalSpace;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return COLTableViewCellRowTwoLineDefaultHeight;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.collectionList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CollectionCell *cell = [CollectionCell cellForTableView:tableView];
    cell.delegate = self;
    [cell showData:self.collectionList[indexPath.row]];
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
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
        CollectionModel *collectionModel = self.collectionList[row];
        [self.collectionPresenter deleteCollectionByObjectID:[NSString stringWithFormat:@"%ld", (long)collectionModel.id]];
        [self.collectionList removeObjectAtIndex:row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"取消收藏";
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
    [_collectionPresenter detachView];
}

#pragma mark - setup 
- (void)setup {
    self.collectionPresenter = [[CollectionPresenter alloc] initWithService:[[CollectionService alloc] init]];
    [self.collectionPresenter attachView:self];
    
    self.collectionList = [NSMutableArray arrayWithCapacity:10];
    
    COLWeakSelf(self)
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        COLStrongSelf(self);
        //处理
        [self.collectionPresenter getCollectionList];
        
        dispatch_async(dispatch_get_main_queue(), ^(){
            [self.tableView.mj_footer endRefreshing];
        });
        
    }];
    
    [self.tableView.mj_footer beginRefreshing];
}

#pragma mark - CollectionPresenterDelegate

- (void)collectionListDidLoadedSuccess:(BOOL)success message:(NSString *)message collectionList:(NSArray<CollectionModel *> *)collectionList {
    if (success) {
        self.collectionList = [NSMutableArray arrayWithArray:collectionList];
        [self.tableView reloadData];
    } else {
        [COLToast showToast:message];
    }
}

- (void)collectionDeleteDidSuccess:(BOOL)success message:(NSString *)message {
    [COLToast showToast:message];
}

#pragma mark - CollectionCellDelegate

- (void)collectionCellStartNaviWithLng:(NSString *)lng lat:(NSString *)lat {
    COLWeakSelf(self)
    [[COLMap sharedCOLMap] startSingleLocWithReGeocode:NO CompletionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        COLStrongSelf(self)
        CLLocation *end = [[CLLocation alloc] initWithLatitude:[lat doubleValue] longitude:[lng doubleValue]];
        //导航界面
        [self.navigationController pushViewController:[[COLMediator sharedInstance] homeNaviControllerWithParams:@{@"start": location, @"end": end}] animated:YES];
    }];
}

@end
