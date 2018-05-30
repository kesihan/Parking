//
//  AccountController.m
//  parking
//
//  Created by Robert Xu on 2017/5/23.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "AccountController.h"
#import "AccountPresenter.h"
#import "AccountAvatarCell.h"
#import "AccountCommonCell.h"
#import "DateChooseView.h"

#import "COLMediator+Identity.h"

@interface AccountController () <AccountPresenterDelegate, UITableViewDelegate, UITableViewDataSource, DateChooseViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) AccountPresenter *accountPresenter;
@property (copy, nonatomic) NSArray *titles;

@property (strong, nonatomic) UIAlertController *alertController;
//头像
@property (nonatomic,strong)UIImage *HeadPic;
//昵称
@property (nonatomic,strong)NSString *name;
//性别
@property (nonatomic,strong)NSString *sex;
//手机号
@property (nonatomic,strong)NSString *tel;
//生日
@property (nonatomic,strong)NSString *birthday;
//真实名字
@property (nonatomic,strong)NSString *name_real;
@end

@implementation AccountController

#pragma mark - AccountPresenterDelegate

- (void)setAccountTitle:(NSArray *)titles {
    self.titles = titles;
    [self.tableView reloadData];
}
//拍照
- (void) snapImage{
    UIImagePickerController *ipc=[[UIImagePickerController alloc] init];
    ipc.sourceType=UIImagePickerControllerSourceTypeCamera;
    ipc.delegate=self;
    ipc.allowsEditing=YES;
    [self presentViewController:ipc animated:YES completion:^{
        
    }];
    
}
#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;
{
    NSLog(@"info = %@",info);
    
    //    UIImagePickerControllerEditedImage 编辑图片
    //    UIImagePickerControllerOriginalImage 原始图片
    _HeadPic = [info objectForKey:UIImagePickerControllerEditedImage];
    [self.tableView reloadData];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            self.alertController = [UIAlertController alertControllerWithTitle:@"选择头像" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *actionCamera = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self snapImage];
            }];
            UIAlertAction *actionAlbum = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
                imagePicker.delegate = self;
                imagePicker.allowsEditing = YES;
                //    [self.navigationController pushViewController:tag animated:YES];
                [self presentViewController:imagePicker animated:YES completion:^{
                    
                }];
            }];
            UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [self.alertController addAction:actionCamera];
            [self.alertController addAction:actionAlbum];
            [self.alertController addAction:actionCancel];
            [self presentViewController:self.alertController animated:YES completion:nil];
        }
             [self.tableView reloadData];
            break;
        case 1:
        {
            self.alertController = [UIAlertController alertControllerWithTitle:@"修改昵称" message:nil preferredStyle:UIAlertControllerStyleAlert];
            COLWeakSelf(self)
            [self.alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                COLStrongSelf(self)
                textField.placeholder = @"请输入新的昵称";
                
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alertTextFieldDidChange:) name:UITextFieldTextDidChangeNotification object:textField];
            }];
            UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction *actionConfirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                UITextField *nickNameTextField = _alertController.textFields.firstObject;
                _name = [[NSString alloc]initWithFormat:@"%@",nickNameTextField.text];
                 [self.tableView reloadData];
            }];
            actionConfirm.enabled  = NO;
            
            [self.alertController addAction:actionCancel];
            [self.alertController addAction:actionConfirm];
            [self presentViewController:self.alertController animated:YES completion:nil];
        }
            
            break;
        case 2:
        {
            self.alertController = [UIAlertController alertControllerWithTitle:@"修改性别" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *actionMale = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                self.sex = @"男";
                 [self.tableView reloadData];
            }];
            UIAlertAction *actionFemale = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                self.sex = @"女";
                 [self.tableView reloadData];
            }];
            UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [self.alertController addAction:actionMale];
            [self.alertController addAction:actionFemale];
            [self.alertController addAction:actionCancel];
            [self presentViewController:self.alertController animated:YES completion:nil];
        }
            
            break;
        case 3:
        {
            self.alertController = [UIAlertController alertControllerWithTitle:@"修改手机号" message:nil preferredStyle:UIAlertControllerStyleAlert];
            COLWeakSelf(self)
            [self.alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                COLStrongSelf(self)
                textField.placeholder = @"请输入新的手机号";
                textField.text = self.tel;
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alertTextFieldDidChange:) name:UITextFieldTextDidChangeNotification object:textField];
            }];
            UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction *actionConfirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                UITextField *nickNameTextField = _alertController.textFields.firstObject;
                self.tel = [[NSString alloc]initWithFormat:@"%@",nickNameTextField.text];
                 [self.tableView reloadData];
            }];
            actionConfirm.enabled  = NO;
            
            [self.alertController addAction:actionCancel];
            [self.alertController addAction:actionConfirm];
            [self presentViewController:self.alertController animated:YES completion:nil];
        }
            
            break;
        case 4:
        {
            DateChooseView *view = [[DateChooseView alloc] init];
            view.delegate = self;
            [view showWithDate:@"2016-11-12"];
        }
            
            break;
        case 5:
        {
            //实名认证状态
            UIViewController *statusVC = [[COLMediator sharedInstance] identityStatusController];
            [self.navigationController pushViewController:statusVC animated:YES];
        }
            
            break;
            
        default:
            break;
    }
   
}

#pragma mark - Input Delegate

- (void)alertTextFieldDidChange:(NSNotification *)notification{
    UIAlertController *alertController = (UIAlertController *)self.presentedViewController;
    if (alertController) {
        UITextField *input = alertController.textFields.firstObject;
        UIAlertAction *actionConfirm = alertController.actions.lastObject;
        actionConfirm.enabled = input.text.length > 0;
    }
}

#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return COLTableViewCellSectionDefaultVerticalSpace;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_titles) {
        return [_titles count];
    } else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return COLTableViewCellRowOneLineDefaultHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    
    if (0 == row) {
        AccountAvatarCell *cell = [AccountAvatarCell cellForTableView:tableView];
        [cell setTitle:self.titles[row]];

        cell.headPic.image = _HeadPic;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        AccountCommonCell *cell = [AccountCommonCell cellForTableView:tableView];
        [cell setTitle:self.titles[row]];
        if (row== 1) {
            [cell.infoLabel setText:self.name];
        }
        else if (row== 2) {
            [cell.infoLabel setText:self.sex];
        }
        else if (row== 3) {
            [cell.infoLabel setText:self.tel];
        }
        else if (row== 4) {
            [cell.infoLabel setText:self.birthday];
        }
        
        if (5 == row) {
            [cell showIdentity:YES];
        }
        else {
            [cell showIdentity:NO];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

#pragma mark - DateChooseViewDelegate

- (void)clickConfirm:(NSString *)date {
    self.birthday = [[NSString alloc]initWithFormat:@"%@",date];
    [self.tableView reloadData];
}

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    
    self.accountPresenter = [[AccountPresenter alloc] initWithService:[[AccountService alloc] init]];
    [self.accountPresenter attachView:self];
    [self.accountPresenter getTitles];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setup 

- (void)setup {
    
    UIImageView *img = [[UIImageView alloc]init];
    [img sd_setImageWithURL:[NSURL URLWithString:[AccountService userModel].headImage] placeholderImage:[UIImage imageNamed:@"Identity_icon_name_nor"]];
    self.HeadPic = img.image;
    self.name = [AccountService userModel].name;
    self.sex = [AccountService userModel].sex;
    self.tel = [AccountService userModel].mobile;
    self.birthday = [AccountService userModel].birthday;
    UIBarButtonItem *itemRight = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveAction:)];
    self.navigationItem.rightBarButtonItem = itemRight;
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName: COL_DefaultFont_Size(14)} forState:UIControlStateNormal];
}

#pragma mark - action

- (void)saveAction:(id)sender {
    
}

@end
