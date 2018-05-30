//
//  CreditController.m
//  parking
//
//  Created by Robert Xu on 2017/5/24.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "CreditController.h"
#import "CreditCell.h"
#import "CreditHeader.h"
#import "CreditPresenter.h"
#import <MJRefresh/MJRefresh.h>

@interface CreditController () <UITableViewDelegate, UITableViewDataSource, CreditPresenterDelegate>

@property (strong, nonatomic) CreditPresenter *creditPresenter;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *creditTotalLabel;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;

@property (strong, nonatomic) NSMutableArray<IntegralList *> *creditList;

@end

@implementation CreditController

#pragma mark - UITableViewDelegate



#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return COLTableViewCellRowOneLineDefaultHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CreditHeader *header = [[CreditHeader alloc] initWithFrame:CGRectZero];
    return header;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.creditList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return COLTableViewCellRowTwoLineDefaultHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CreditCell *cell = [CreditCell cellForTableView:tableView];
    [cell showData:_creditList[indexPath.row]];
    return cell;
}

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setWhiteTitleStyle];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self setDefaultTitleStyle];
}

- (void)dealloc {
    [_creditPresenter detachView];
}

#pragma mark - setup 

- (void)setup {
    self.creditPresenter = [[CreditPresenter alloc] initWithService:[[CreditService alloc] init]];
    [self.creditPresenter attachView:self];
    
    COLWeakSelf(self)
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        COLStrongSelf(self);
        //处理
        [self.creditPresenter getCreditList];
        
        dispatch_async(dispatch_get_main_queue(), ^(){
            [self.tableView.mj_footer endRefreshing];
        });
        
    }];
    
    [self.tableView.mj_footer beginRefreshing];
}

#pragma mark - CreditPresenterDelegate

- (void)creditListDidLoadedSuccess:(BOOL)success list:(NSMutableArray *)list total:(NSInteger)total isSignIn:(NSString *)isSign {
    if (success) {
        
        self.creditTotalLabel.text = [NSString stringWithFormat:@"%ld", (long)total];
        
        if ([isSign isEqualToString:@"Y"]) {
            self.signInButton.enabled = NO;
            [self.signInButton setTitle:@"已签到" forState:UIControlStateNormal];
            [self.signInButton setBackgroundColor:UIColorFromRGB(0xE1E1E1)];
        } else {
            self.signInButton.enabled = YES;
            [self.signInButton setTitle:@"每日签到" forState:UIControlStateNormal];
            [self.signInButton setBackgroundColor:[UIColor whiteColor]];
        }
        
        self.creditList = list;
        [self.tableView reloadData];
    } else {
        [COLToast showToast:@"获取数据发生了错误"];
    }
}

- (void)creditDidSignedSuccess:(BOOL)success message:(NSString *)message {
    if (success) {
        [COLToast showToast:message];
    } else {
        [COLToast showToast:message];
    }
}

#pragma mark - action

- (IBAction)signAction:(id)sender {
    [self.creditPresenter signDaily];
}


#pragma mark - getter & setter


@end
