//
//  QAController.m
//  parking
//
//  Created by Robert Xu on 2017/5/25.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "QAController.h"
#import "QACell.h"
#import "QAPresenter.h"
#import "COLMediator+About.h"

@interface QAController () <UITableViewDelegate, UITableViewDataSource, QAPresenterDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) QAPresenter *qaPresenter;
@property (strong, nonatomic) NSMutableArray<QACellModel *> *menu;

@end

@implementation QAController

#pragma mark - QAPresenterDelegate

- (void)setQAMenu:(NSMutableArray<QACellModel *> *)menu {
    self.menu = menu;
    [self.tableView reloadData];
}

#pragma mark - life cycle
- (void)setup {
    self.qaPresenter = [[QAPresenter alloc] initWithService:[[QAService alloc] init]];
    [self.qaPresenter attachView:self];
    [self.qaPresenter getMenu];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    switch (row) {
        case 0:
        {
            [self.navigationController pushViewController:[[COLMediator sharedInstance] aboutCreditController] animated:YES];
        }
            break;
        case 1:
        {
            
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.menu count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QACell *cell = [QACell cellForTableView:tableView];
    [cell showData:self.menu[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

@end
