//
//  TableViewParkingDetailsObj.m
//  parking
//
//  Created by 柯思汉 on 2018/2/26.
//  Copyright © 2018年 huafangcloud. All rights reserved.
//

#import "TableViewParkingDetailsObj.h"

#import "ParkingrecordCell.h"
#import "ParkingDetailsCell.h"
#import "PaybuttonCell.h"
#import <AFNetworking.h>
#import "JFHttpRequestTool.h"
#import "DebugModel.h"

@interface TableViewParkingDetailsObj ()
@property (nonatomic, strong) NSArray   *dataList;
@property (nonatomic, copy)   selectCell selectBlock;
@property (nonatomic, copy)   selectRequsetSure sureBlock;
@property (nonatomic,strong) DebugItem *item;
@end
@implementation TableViewParkingDetailsObj
+ (instancetype)createTableViewDelegateWithDataList:(DebugItem *)item
                                        selectBlock:(selectCell)selectBlock {
    return [[[self class] alloc] initTableViewDelegateWithDataList:item
                                                       selectBlock:selectBlock];
}

- (instancetype)initTableViewDelegateWithDataList:(DebugItem *)item selectBlock:(selectCell)selectBlock {
    self = [super init];
    if (self) {
        self.item = item;
        self.selectBlock = selectBlock;
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


- (CGFloat)tableView:(UITableView* )tableView heightForRowAtIndexPath:(NSIndexPath* )indexPath{
    
    
    
    //    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.row == 0) {
         return 180.0;
    }
    else if(indexPath.row == 1)
        return 70.0;
    else
        return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0)
    {
    ParkingrecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ParkingrecordCell"];
    
    if (!cell)
    {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"ParkingrecordCell" owner:self options:nil]lastObject];
    }
        [cell.name setText:self.item.name];
        [cell.license_plate setText:self.item.license_plate];
        [cell.out_time setText:self.item.out_time];
        [cell.money setText:[[NSString alloc]initWithFormat:@"%@元",self.item.money]];
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell;
    }
    else if(indexPath.row == 1)
    {
        ParkingDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ParkingDetailsCell"];
        
        if (!cell)
        {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"ParkingDetailsCell" owner:self options:nil]lastObject];
        }
        
        cell.money.text = [[NSString alloc]initWithFormat:@"最终支付:¥%@元",self.item.money];
        cell.time.text = [[NSString alloc]initWithFormat:@"已停放:%@",self.item.longtime];
        tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        tableView.showsVerticalScrollIndicator = NO;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell;
    }
    else
    {
        PaybuttonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PaybuttonCell"];
        
        if (!cell)
        {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"PaybuttonCell" owner:self options:nil]lastObject];
        }
        [cell.complaint addTarget:self action:@selector(complaintgo) forControlEvents:UIControlEventTouchDown];
        [cell.paymoney addTarget:self action:@selector(pay) forControlEvents:UIControlEventTouchDown];
        tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        tableView.showsVerticalScrollIndicator = NO;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell;
    }
}
- (void)pay
{
    NSIndexPath *index = [NSIndexPath indexPathForRow:8888 inSection:1];
    self.selectBlock(index);
}
- (void)complaintgo
{
    NSIndexPath *index = [NSIndexPath indexPathForRow:9999 inSection:1];
     self.selectBlock(index);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    // 将点击事件通过block的方式传递出去
//    self.selectBlock(indexPath);
}

- (void)requestselectRequsetDebug:(selectRequsetSure)selectRequsetDebug WithID:(NSString *)ID;
{
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           [AccountService userModel].id,@"userID",
                           ID,@"id",
                           @"1520239994",@"ts",
                           @"17890fae0e09ed9197ee0f552c435c2a",@"sign",
                           COLAGRequestAppID,@"appID",
                           nil];
    
    NSLog(@"parm =%@",param);
    JF_WS(weakSelf);
    [JFHttpRequestTool getWithURL:[[NSString alloc]initWithFormat:@"%@/v1/user/debugging/debug",COLAGBaseURL]  params:param success:^(id json) {
        if ([json[@"code"] intValue] == 0) {
            
            NSLog(@"json =%@",json);
            weakSelf.sureBlock(json[@"content"][0]);
            
        }else {
            //         [self showInfoWithMsg:json[@"message"]];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

@end
