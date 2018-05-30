//
//  MessagetableviewObject.m
//  parking
//
//  Created by 柯思汉 on 2018/3/12.
//  Copyright © 2018年 huafangcloud. All rights reserved.
//

#import "MessagetableviewObject.h"
#import "MessageCenterCell.h"
@interface MessagetableviewObject ()
@property (nonatomic, strong) NSArray   *dataList;
@property (nonatomic, copy)   selectMessageCell selectMessageBlock;
//@property (nonatomic,strong) DebugModel *debugmodel;
@end
@implementation MessagetableviewObject
+ (instancetype)createTableViewDelegateWithDataList:(NSArray *)dataList
                                        selectBlock:(selectMessageCell)selectBlock {
    return [[[self class] alloc] initTableViewDelegateWithDataList:dataList
                                                       selectBlock:selectBlock];
}

- (instancetype)initTableViewDelegateWithDataList:(NSArray *)dataList selectBlock:(selectMessageCell)selectBlock {
    self = [super init];
    if (self) {
        self.dataList = dataList;
        self.selectMessageBlock = selectBlock;
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
    
    
    
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return cell.frame.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageCenterCell"];
    
    if (!cell)
    {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"MessageCenterCell" owner:self options:nil]lastObject];
    }
//    DebugItem *item = [[DebugItem alloc]init];
//    item = self.debugmodel.content[indexPath.row];
//    NSLog(@"%@",item.name);
//    [cell setData:item];
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    // 将点击事件通过block的方式传递出去
    self.selectMessageBlock(indexPath);
}

@end
