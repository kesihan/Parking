//
//  MoreController.m
//  parking
//
//  Created by Robert Xu on 2017/5/19.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "MoreController.h"
#import "MoreCell.h"
#import "LogOutCell.h"
#import "AccountService.h"
//Presenter
#import "MorePresenter.h"

//COLMediator
#import "COLMediator+QA.h"
#import "COLMediator+Feedback.h"
#import "COLMediator+About.h"
#import "LogonController.h"
#import "COLMediator+Logon.h"

@interface MoreController () <UITableViewDelegate, UITableViewDataSource, MorePresenterDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) MorePresenter *morePresenter;

@property (strong, nonatomic) NSMutableArray<MoreCellModel *> *menu;

@end

@implementation MoreController

#pragma mark - MorePresenterDelegate

- (void)setMoreMenu:(NSMutableArray<MoreCellModel *> *)menu {
    self.menu = menu;
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.section) {
        switch (indexPath.row) {
            case 0:
            {
                [self.navigationController pushViewController:[[COLMediator sharedInstance] qaController] animated:YES];
            }
                break;
            case 1:
            {
                
            }
                break;
            case 2:
            {
                [self.navigationController pushViewController:[[COLMediator sharedInstance] feedbackController] animated:YES];
            }
                break;
            case 3:
            {
                
            }
                break;
            case 4:
            {
                [self.navigationController pushViewController:[[COLMediator sharedInstance] aboutController] animated:YES];
            }
                break;
                
            default:
                break;
        }
    } else {
        //退出
        [AccountService logout:^{
            
        }];
        [self.navigationController pushViewController:[[COLMediator sharedInstance] logonController] animated:YES];
    }
}

#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return COLTableViewCellSectionDefaultVerticalSpace;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (0 == section) {
        return 5;
    } else if (1 == section) {
        return 1;
    } else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return COLTableViewCellRowOneLineDefaultHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    if (0 == section) {
        MoreCell *cell = [MoreCell cellForTableView:tableView];
        [cell showData:self.menu[row]];
        return cell;
    } else if (1 == section) {
        LogOutCell *cell = [LogOutCell cellForTableView:tableView];
        return cell;
    } else {
        return nil;
    }
}

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.morePresenter = [[MorePresenter alloc] initWithService:[[MoreService alloc] init]];
    [self.morePresenter attachView:self];
    [self.morePresenter getMenu];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
