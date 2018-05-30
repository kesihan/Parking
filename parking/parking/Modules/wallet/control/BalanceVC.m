//
//  BalanceVC.m
//  parking
//
//  Created by 柯思汉 on 2018/3/9.
//  Copyright © 2018年 huafangcloud. All rights reserved.
//

#import "BalanceVC.h"
#import "BalanCell.h"
#import <AFNetworking.h>
#import "JFHttpRequestTool.h"
#import "BalanceModel.h"
#import <MJRefresh/MJRefresh.h>

@interface BalanceVC ()
@property (strong, nonatomic) IBOutlet UIView *underline;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *line_distance;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *line_long;
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong) BalanceModel *model;
@property (nonatomic,assign)NSInteger pages;
@end

@implementation BalanceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    self.pages = 1;
    [self requestpaydetail];
    // Do any additional setup after loading the view from its nib.
}
- (void)setUI
{
    self.navigationItem.title = @"余额明细";
    self.line_long.constant = DEVICE_WIDTH/3;
    self.tableview.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _tableview.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        self.pages = 1;
        if(self.line_distance.constant == 0)
        [self requestpaydetail];
        else if (self.line_distance.constant == DEVICE_WIDTH/3)
                [self requestpaydetailtype:@"income"];
        else
            [self requestpaydetailtype:@"expend"];
        dispatch_async(dispatch_get_main_queue(), ^(){
            [_tableview.mj_header endRefreshing];
        });
    }];
    
    [_tableview.mj_header beginRefreshing];
    _tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        //        JF_WS(weakSelf);
        self.pages++;
        if(self.line_distance.constant == 0)
            [self requestpaydetail];
        else if (self.line_distance.constant == DEVICE_WIDTH/3)
            [self requestpaydetailtype:@"income"];
        else
            [self requestpaydetailtype:@"expend"];
        dispatch_async(dispatch_get_main_queue(), ^(){
            [_tableview.mj_footer endRefreshing];
        });
        
    }];
    
    [_tableview.mj_footer beginRefreshing];

}
//全部
- (IBAction)allMoney:(UIButton *)sender {
    self.line_distance.constant = 0;
    [self.model.content removeAllObjects];
    self.pages = 1;
    [self requestpaydetail];
}
//全部支出
- (IBAction)allSpending:(UIButton *)sender {
    self.line_distance.constant = DEVICE_WIDTH/3*2;
    [self.model.content removeAllObjects];
    self.pages = 1;
    [self requestpaydetailtype:@"expend"];
}
//全部收入
- (IBAction)allIncome:(UIButton *)sender {
    self.line_distance.constant = DEVICE_WIDTH/3;
    [self.model.content removeAllObjects];
    self.pages = 1;
    [self requestpaydetailtype:@"income"];
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.model.content.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BalanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BalanCell"];
    if (!cell)
    {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"BalanCell" owner:self options:nil]lastObject];
    }
    BalanceItem *item = [[BalanceItem alloc]init];
    item = self.model.content[indexPath.row];
    [cell.time setText:item.add_time];
    
    if ([item.type isEqualToString:@"expend"]) {
        cell.money.textColor = [UIColor redColor];
        [cell.money setText:[[NSString alloc]initWithFormat:@"-%@",item.money]];
        [cell.income setText:@"支出"];
    }
    else
    {
        [cell.income setText:@"收入"];
        [cell.money setText:[[NSString alloc]initWithFormat:@"+%@",item.money]];
    }
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)requestpaydetail;
{
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           [AccountService userModel].id,@"userID",
                           @"1520239994",@"ts",
                           [NSNumber numberWithInteger:self.pages],@"pageSize",
                           @"10",@"nums",
                           @"17890fae0e09ed9197ee0f552c435c2a",@"sign",
                           COLAGRequestAppID,@"appID",
                           nil];
    
    NSLog(@"parm =%@",param);
    JF_WS(weakSelf);
    [JFHttpRequestTool getWithURL:[[NSString alloc]initWithFormat:@"%@/v1/user/debugging/paydetail",COLAGBaseURL]  params:param success:^(id json) {
        if ([json[@"code"] intValue] == 0) {
            
            NSLog(@"json =%@",json);
            BalanceModel *model = [[BalanceModel alloc]init];
            model.content = [BalanceItem mj_objectArrayWithKeyValuesArray:json[@"content"]];
            if (self.pages == 1)
            {
                weakSelf.model = model;
            }
            else
            {
                [weakSelf.model.content addObjectsFromArray:model.content];
            }
             [weakSelf.tableview reloadData];
            
        }else {
            //         [self showInfoWithMsg:json[@"message"]];
        }
        
    } failure:^(NSError *error) {
        
    }];
}


- (void)requestpaydetailtype:(NSString *)type;
{
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           [AccountService userModel].id,@"userID",
                           @"1520239994",@"ts",
                           [NSNumber numberWithInteger:self.pages],@"pageSize",
                           type,@"type",
                           @"10",@"nums",
                           @"17890fae0e09ed9197ee0f552c435c2a",@"sign",
                           COLAGRequestAppID,@"appID",
                           nil];
    
    NSLog(@"parm =%@",param);
    JF_WS(weakSelf);
    [JFHttpRequestTool getWithURL:[[NSString alloc]initWithFormat:@"%@/v1/user/debugging/paytype",COLAGBaseURL]  params:param success:^(id json) {
        if ([json[@"code"] intValue] == 0) {
            
            NSLog(@"json =%@",json);
            BalanceModel *model = [[BalanceModel alloc]init];
            model.content = [BalanceItem mj_objectArrayWithKeyValuesArray:json[@"content"]];
            if (self.pages == 1)
            {
                weakSelf.model = model;
            }
            else
            {
                [weakSelf.model.content addObjectsFromArray:model.content];
            }
            [self.tableview reloadData];
            
        }else {
            //         [self showInfoWithMsg:json[@"message"]];
        }
        
    } failure:^(NSError *error) {
        
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
