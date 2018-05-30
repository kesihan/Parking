//
//  ParkingdetailsVC.m
//  parking
//
//  Created by 柯思汉 on 2018/2/26.
//  Copyright © 2018年 huafangcloud. All rights reserved.
//

#import "ParkingdetailsVC.h"
#import "TableViewParkingDetailsObj.h"
#import "FeedbackVC.h"
#import "PayVC.h"

@interface ParkingdetailsVC ()
{
    UITableView *_tableView;
    TableViewParkingDetailsObj *_tableDelegate;
}
@end

@implementation ParkingdetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"停车详情";
    [self createTableView];
    [self GetSure];
    // Do any additional setup after loading the view from its nib.
}
- (void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 65, DEVICE_WIDTH,DEVICE_HEIGHT-65)];
    _tableView.backgroundColor = KF_RGB(235, 235, 235);
    _tableDelegate = [TableViewParkingDetailsObj createTableViewDelegateWithDataList:self.item
                                                                   selectBlock:^(NSIndexPath *indexPath) {
                                                                       NSLog(@"点击了%ld行cell", (long)indexPath.row);
                                                                       if (indexPath.row == 9999) {
                                                                           FeedbackVC *control = [[FeedbackVC alloc]initWithNibName:@"FeedbackVC" bundle:nil];
                                                                           [self.navigationController pushViewController:control animated:YES];
                                                                       }
                                           else if (indexPath.row == 8888) {
                                                                           PayVC *control = [[PayVC alloc]initWithNibName:@"PayVC" bundle:nil];
                                                                           [self.navigationController pushViewController:control animated:YES];
                                                                       }

                                                                   }];
    _tableView.delegate = _tableDelegate;
    _tableView.dataSource = _tableDelegate;
    [self.view addSubview:_tableView];
   
}

- (void)GetSure
{
    [_tableDelegate requestselectRequsetDebug:^(NSDictionary *dic) {
        NSLog(@"dic = %@",dic);
    } WithID:self.ID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
