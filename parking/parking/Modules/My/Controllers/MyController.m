//
//  MyController.m
//  parking
//
//  Created by Robert Xu on 2017/5/18.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "MyController.h"
#import "MyHeaderView.h"
#import "MyCell.h"

//Present
#import "MyPresenter.h"

//Mediator
#import "COLMediator+More.h"
#import "COLMediator+Account.h"
#import "COLMediator+Credit.h"
#import "COLMediator+Collection.h"
#import "COLMediator+Car.h"
#import "COLMediator+AddCar.h"
#import "COLMediator+Invite.h"
#import "CoreMotionVC.h"
#import "WalletVC.h"
#import "ParkingrecordVC.h"
#import "MessageCenterVC.h"

@interface MyController () <UITableViewDelegate, UITableViewDataSource, MyPresenterDelegate, MyHeaderViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

//MVP
@property (strong, nonatomic) MyPresenter *myPresenter;

//Data
@property (strong, nonatomic) NSMutableArray<MyCellModel *> *menu;

@end

@implementation MyController

#pragma mark - MyHeaderViewDelegate

- (void)myHeaderViewClickAvatar {
    
    UINavigationController* nav = (UINavigationController*)self.mm_drawerController.centerViewController;
    [nav pushViewController:[[COLMediator sharedInstance] accountController] animated:YES];
    //当我们push成功之后，关闭我们的抽屉
    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
        //设置打开抽屉模式为MMOpenDrawerGestureModeNone，也就是没有任何效果。
        [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    }];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    
    UINavigationController* nav = (UINavigationController*)self.mm_drawerController.centerViewController;
    switch (row) {
        case 0:
        {
//            [nav pushViewController:[[COLMediator sharedInstance] creditController] animated:YES];
            WalletVC *control = [[WalletVC alloc]initWithNibName:@"WalletVC" bundle:nil];
            [nav pushViewController:control animated:YES];
        }
            break;
        case 1:
        {
            //如果用户当前没有绑定车辆，则跳到添加车辆
            if ([self.myPresenter hasCar]) {
                [nav pushViewController:[[COLMediator sharedInstance] carController] animated:YES];
            } else {
                [nav pushViewController:[[COLMediator sharedInstance] addCarController] animated:YES];
            }
        }
            break;
        case 2:
        {
            ParkingrecordVC *control = [[ParkingrecordVC alloc]initWithNibName:@"ParkingrecordVC" bundle:nil];
            [nav pushViewController:control animated:YES];
        }
            break;
        case 3:
        {
            [nav pushViewController:[[COLMediator sharedInstance] collectionController] animated:YES];
        }
            break;
        case 4:
        {
            MessageCenterVC *control = [[MessageCenterVC alloc]initWithNibName:@"MessageCenterVC" bundle:nil];
            [nav pushViewController:control animated:YES];
        }
            break;
            
        case 5:
        {
            [nav pushViewController:[[COLMediator sharedInstance] inviteController] animated:YES];
        }
            break;
        case 6:
        {
            [nav pushViewController:[[COLMediator sharedInstance] moreController] animated:YES];
        }
            break;
            
        default:
            break;
    }
    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
        //设置打开抽屉模式为MMOpenDrawerGestureModeNone，也就是没有任何效果。
        [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    }];
}

//  Header
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MyHeaderView *header = [[MyHeaderView alloc] initWithFrame:CGRectZero];
    header.delegate = self;
    return header;
}
//  Header Height
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 236;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyCell *cell = [MyCell cellForTableView:tableView];
    [cell showData:self.menu[indexPath.row]];
    return cell;
}

#pragma mark -  MyPresenterDelegate 

- (void)setMyMenu:(NSMutableArray<MyCellModel *> *)menu {
    self.menu = menu;
    [self.tableView reloadData];
}

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //MVP
    self.myPresenter = [[MyPresenter alloc] initWithService:[[MyService alloc] init]];
    [self.myPresenter attachView:self];
    [self.myPresenter getMenu];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setup

- (void)setup {

}

@end
