//
//  MessageCenterVC.m
//  parking
//
//  Created by 柯思汉 on 2018/3/12.
//  Copyright © 2018年 huafangcloud. All rights reserved.
//

#import "MessageCenterVC.h"
#import "MessagetableviewObject.h"
#import "MessagedetailsVC.h"
@interface MessageCenterVC ()
{
    UITableView *_tableView;
    MessagetableviewObject *_tableDelegate;
}
@end

@implementation MessageCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"消息中心";
    [self createTableView];
    // Do any additional setup after loading the view from its nib.
}
- (void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 66, DEVICE_WIDTH,DEVICE_HEIGHT-65)];
    _tableView.tableFooterView =[[UIView alloc]initWithFrame:CGRectZero];
    _tableDelegate = [MessagetableviewObject createTableViewDelegateWithDataList:nil
                                                                   selectBlock:^(NSIndexPath *indexPath) {
                                                                       NSLog(@"点击了%ld行cell", (long)indexPath.row);
                                                                       MessagedetailsVC *control = [[MessagedetailsVC alloc]initWithNibName:@"MessagedetailsVC" bundle:nil];
                                                                       [self.navigationController pushViewController:control animated:YES];
                                                                   }];
    _tableView.backgroundColor = KF_RGB(245, 245, 245);
    _tableView.delegate = _tableDelegate;
    _tableView.dataSource = _tableDelegate;
    [self.view addSubview:_tableView];
//    _tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
//        self.pages = 1;
//        [self Getdebug];
//        dispatch_async(dispatch_get_main_queue(), ^(){
//            [_tableView.mj_header endRefreshing];
//        });
//    }];
//    
//    [_tableView.mj_header beginRefreshing];
//    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        //        JF_WS(weakSelf);
//        self.pages++;
//        [self Getdebug];
//        dispatch_async(dispatch_get_main_queue(), ^(){
//            [_tableView.mj_footer endRefreshing];
//        });
//        
//    }];
//    
//    [_tableView.mj_footer beginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)Getdebug{
    //    [AccountService userModel].id
    
//    [_tableDelegate requestDebug:self.pages selectRequsetDebug:^(DebugModel *model) {
//        [_tableView reloadData];
//    }];
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
