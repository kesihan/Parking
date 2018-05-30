//
//  SearchHistoryController.m
//  parking
//
//  Created by Robert Xu on 2017/5/25.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "SearchHistoryController.h"
#import "SearchHistoryCell.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>

#import <AMapSearchKit/AMapSearchKit.h>
@interface SearchHistoryController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *arr;
@end

@implementation SearchHistoryController
- (void)viewWillAppear:(BOOL)animated
{
    self.arr = [[NSMutableArray alloc]initWithArray:[UserData getHistorical][@"historical"]];
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
    return self.arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchHistoryCell *cell = [SearchHistoryCell cellForTableView:tableView];
    NSDictionary *dic = [[NSDictionary alloc]initWithDictionary:self.arr[indexPath.row]];
    [cell.name setText:dic[@"name"]];
    [cell.address setText:dic[@"address"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *userInfo = [[NSDictionary alloc]initWithDictionary:self.arr[indexPath.row]];
    NSNotification *notification =[NSNotification notificationWithName:@"searController" object:nil userInfo:userInfo];
    // 3.通过 通知中心 发送 通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
