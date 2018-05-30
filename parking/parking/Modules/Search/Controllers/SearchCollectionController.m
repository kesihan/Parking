//
//  SearchCollectionController.m
//  parking
//
//  Created by Robert Xu on 2017/5/25.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "SearchCollectionController.h"
#import "SearchCollectionCell.h"
#import "CollectionPresenter.h"
#import <MJRefresh/MJRefresh.h>

@interface SearchCollectionController () <UITableViewDelegate, UITableViewDataSource, CollectionPresenterDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) CollectionPresenter *collectionPresenter;
@property (strong, nonatomic) NSMutableArray<CollectionModel *> *collectionList;

@end

@implementation SearchCollectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate



#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
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
    return [self.collectionList count];;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchCollectionCell *cell = [SearchCollectionCell cellForTableView:tableView];
    [cell showData:self.collectionList[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    CollectionModel *model = [[CollectionModel alloc]init];
    model = self.collectionList[indexPath.row];
    NSDictionary *userInfo = [[NSDictionary alloc]initWithObjectsAndKeys:model.lotName,@"name",model.areaName,@"address",model.addressLongitude,@"longitude",model.addressLatitude,@"latitude", nil];
    NSNotification *notification =[NSNotification notificationWithName:@"searController" object:nil userInfo:userInfo];
    // 3.通过 通知中心 发送 通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - setup

- (void)setup {
    self.collectionPresenter = [[CollectionPresenter alloc] initWithService:[[CollectionService alloc] init]];
    [self.collectionPresenter attachView:self];
    self.collectionList = [NSMutableArray arrayWithCapacity:10];
    
    if ([self.collectionPresenter isUserLogin]) {
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

@end
