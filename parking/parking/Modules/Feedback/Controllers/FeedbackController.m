//
//  FeedbackController.m
//  parking
//
//  Created by Robert Xu on 2017/5/25.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "FeedbackController.h"
#import "FeedbackHeader.h"
#import "FeedbackCell.h"
#import "FeedbackFooter.h"
#import "COLCamera.h"

@interface FeedbackController () <UITableViewDataSource, UITableViewDelegate, FeedbackFooterDelegate, COLCameraDelegate>

@property (strong, nonatomic) UIAlertController *alertController;
@property (strong, nonatomic) COLCamera *camera;
@property (strong, nonatomic) FeedbackFooter *footer;

@end

@implementation FeedbackController

#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return COLTableViewCellRowOneLineDefaultHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FeedbackCell *cell = [FeedbackCell cellForTableView:tableView];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 34;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    FeedbackHeader *header = [[FeedbackHeader alloc] initWithFrame:CGRectZero];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 320.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (self.footer == nil) {
        self.footer = [[FeedbackFooter alloc] initWithFrame:CGRectZero];
        self.footer.delegate = self;
    }
    return self.footer;
}

#pragma mark - UITableViewDelegate

#pragma mark - FeedbackFooterDelegate

- (void)feedbackFooterImageSource:(UIButton *)button {
    [self showSourcePanelAction];
}

#pragma mark - COLCameraDelegate
- (void)cameraReturnImage:(UIImage *)image {
}

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - action

- (void)showSourcePanelAction {
    self.alertController = [UIAlertController alertControllerWithTitle:@"拍照上传" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    COLWeakSelf(self)
    UIAlertAction *actionCamera = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        COLStrongSelf(self)
        self.camera = [COLCamera instanceWithDelegate:self];
        [self.camera openPhotoLibraryWithResult:^(BOOL success, NSString *errorMessage) {
        }];
    }];
    UIAlertAction *actionAlbum = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [self.alertController addAction:actionCamera];
    [self.alertController addAction:actionAlbum];
    [self.alertController addAction:actionCancel];
    [self presentViewController:self.alertController animated:YES completion:nil];
}

@end
