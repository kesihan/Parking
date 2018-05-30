//
//  WaitingPayVC.m
//  parking
//
//  Created by 柯思汉 on 17/9/12.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "WaitingPayVC.h"
#import "PayMoneyCell.h"
#import "PaySuccessVC.h"

#define DEVICE_WIDTH ([UIScreen mainScreen].bounds.size.width)//设备宽
#define DEVICE_HEIGHT ([UIScreen mainScreen].bounds.size.height)//设备高
@interface WaitingPayVC ()
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong)UIButton *pay;
@property (assign, nonatomic) NSIndexPath *selIndex;//单选，当前选中的行
@end

@implementation WaitingPayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"支付订单";
    [self.view addSubview:self.pay];
    // Do any additional setup after loading the view from its nib.
}

- (void)pays
{
    PaySuccessVC *control = [[PaySuccessVC alloc]initWithNibName:@"PaySuccessVC" bundle:nil];
    [self.navigationController pushViewController:control animated:YES];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
    
}
- (CGFloat)tableView:(UITableView* )tableView heightForRowAtIndexPath:(NSIndexPath* )indexPath{
    
    
    
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return cell.frame.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PayMoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PayMoneyCell"];
    
    if (!cell)
    {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"PayMoneyCell" owner:self options:nil]lastObject];
    }
    [cell showCell:indexPath];
    if (_selIndex == indexPath) {
       [cell.chose_btn setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateNormal];
    }else{
        [cell.chose_btn setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
    }
    
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PayMoneyCell *celld = [tableView cellForRowAtIndexPath:_selIndex];
    [celld.chose_btn setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
    //记录当前选中的位置索引
    _selIndex = indexPath;
    //当前选择的打勾
    PayMoneyCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell.chose_btn setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateNormal];
    [self.tableview reloadData];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIButton *)pay
{
    if (!_pay) {
        _pay = [[UIButton alloc]initWithFrame:CGRectMake(10, DEVICE_HEIGHT-60 , DEVICE_WIDTH -20 , 50)];
        _pay.backgroundColor = [UIColor colorWithRed:0 green:120/255.0 blue:1 alpha:1];
        [_pay setTitle:@"立即支付¥22.00" forState:UIControlStateNormal];
        _pay.titleLabel.font = [UIFont systemFontOfSize:16];
        [_pay addTarget:self action:@selector(pays) forControlEvents:UIControlEventTouchDown];
    }
    return _pay;
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
