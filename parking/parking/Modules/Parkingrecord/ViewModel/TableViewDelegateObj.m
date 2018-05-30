//
//  TableViewDelegateObj.m
//  parking
//
//  Created by 柯思汉 on 2018/2/26.
//  Copyright © 2018年 huafangcloud. All rights reserved.
//

#import "TableViewDelegateObj.h"
#import "ParkingrecordCell.h"
#import <AFNetworking.h>
#import "JFHttpRequestTool.h"

@interface TableViewDelegateObj ()
@property (nonatomic, strong) NSArray   *dataList;
@property (nonatomic, copy)   selectCell selectBlock;
@property (nonatomic, copy)   selectRequsetDebug debugBlock;
@property (nonatomic,strong) DebugModel *debugmodel;
@end
@implementation TableViewDelegateObj

+ (instancetype)createTableViewDelegateWithDataList:(NSArray *)dataList
                                        selectBlock:(selectCell)selectBlock {
    return [[[self class] alloc] initTableViewDelegateWithDataList:dataList
                                                       selectBlock:selectBlock];
}

- (instancetype)initTableViewDelegateWithDataList:(NSArray *)dataList selectBlock:(selectCell)selectBlock {
    self = [super init];
    if (self) {
        self.dataList = dataList;
        self.selectBlock = selectBlock;
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.debugmodel.content.count;
}


- (CGFloat)tableView:(UITableView* )tableView heightForRowAtIndexPath:(NSIndexPath* )indexPath{
    
    
    
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return cell.frame.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ParkingrecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ParkingrecordCell"];
    
    if (!cell)
    {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"ParkingrecordCell" owner:self options:nil]lastObject];
    }
    DebugItem *item = [[DebugItem alloc]init];
    item = self.debugmodel.content[indexPath.row];
    NSLog(@"%@",item.name);
    [cell setData:item];
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    // 将点击事件通过block的方式传递出去
    self.selectBlock(indexPath);
}
- (void)requestDebug:(NSInteger)pages selectRequsetDebug:(selectRequsetDebug)selectRequsetDebug
{
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           [AccountService userModel].id,@"userID",
                           [NSNumber numberWithInt:(int)pages],@"pageSize",
                           @"10",@"nums",
                           @"1520239994",@"ts",
                           @"17890fae0e09ed9197ee0f552c435c2a",@"sign",
                           COLAGRequestAppID,@"appID",
                           nil];
    
    NSLog(@"parm =%@",param);
    JF_WS(weakSelf);
    [JFHttpRequestTool getWithURL:[[NSString alloc]initWithFormat:@"%@/v1/user/debugging/debug",COLAGBaseURL]  params:param success:^(id json) {
        if ([json[@"code"] intValue] == 0) {
            
            NSLog(@"json =%@",json);
            DebugModel *model = [[DebugModel alloc]init];
            model.content = [DebugItem mj_objectArrayWithKeyValuesArray:json[@"content"]];
            if (pages == 1)
            {
                weakSelf.debugmodel = model;
            }
            else
            {
                [weakSelf.debugmodel.content addObjectsFromArray:model.content];
            }
            
            selectRequsetDebug(weakSelf.debugmodel);
            
        }else {
            //         [self showInfoWithMsg:json[@"message"]];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

- (DebugModel *)debugmodel
{
    if (!_debugmodel) {
        _debugmodel = [[DebugModel alloc]init];
    }
    return _debugmodel;
}
@end
