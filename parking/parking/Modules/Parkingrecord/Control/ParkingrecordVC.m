//
//  ParkingrecordVC.m
//  parking
//
//  Created by 柯思汉 on 2018/2/26.
//  Copyright © 2018年 huafangcloud. All rights reserved.
//

#import "ParkingrecordVC.h"
#import "TableViewDelegateObj.h"
#import "ParkingdetailsVC.h"
#import "Getdebug.h"
#import "AccountService.h"
#import <MJRefresh/MJRefresh.h>

@interface ParkingrecordVC ()
{
    UITableView *_tableView;
    TableViewDelegateObj *_tableDelegate;
}
@property (nonatomic,assign)NSInteger pages;
@property (nonatomic,strong)DebugModel *model;
@end

@implementation ParkingrecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pages = 1;
    self.navigationItem.title = @"停车记录";
    [self createTableView];
    [self Getdebug];
    // Do any additional setup after loading the view from its nib.
}
- (void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 66+40, DEVICE_WIDTH,DEVICE_HEIGHT-65-40)];
    _tableView.tableFooterView =[[UIView alloc]initWithFrame:CGRectZero];
    _tableDelegate = [TableViewDelegateObj createTableViewDelegateWithDataList:nil
                                                                       selectBlock:^(NSIndexPath *indexPath) {
                                                                           NSLog(@"点击了%ld行cell", (long)indexPath.row);
                                                                           DebugItem *item = [[DebugItem alloc]init];
                                                                           item = self.model.content[indexPath.row];                ParkingdetailsVC *control = [[ParkingdetailsVC alloc]initWithNibName:@"ParkingdetailsVC" bundle:nil];
                                                                           control.ID = item.ID;
                                                                           control.item = item;                [self.navigationController pushViewController:control animated:YES];
                                                                       }];
    _tableView.delegate = _tableDelegate;
    _tableView.dataSource = _tableDelegate;
    [self.view addSubview:_tableView];
    _tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        self.pages = 1;
        [self Getdebug];
        dispatch_async(dispatch_get_main_queue(), ^(){
            [_tableView.mj_header endRefreshing];
        });
    }];
    
    [_tableView.mj_header beginRefreshing];
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        JF_WS(weakSelf);
        self.pages++;
        [self Getdebug];
        dispatch_async(dispatch_get_main_queue(), ^(){
            [_tableView.mj_footer endRefreshing];
        });
        
    }];
    
    [_tableView.mj_footer beginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)Getdebug{
    
    JF_WS(weakSelf);
    [_tableDelegate requestDebug:self.pages selectRequsetDebug:^(DebugModel *model) {
        [_tableView reloadData];
        weakSelf.model = model;
    }];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
