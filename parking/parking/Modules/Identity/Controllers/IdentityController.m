//
//  IdentityController.m
//  parking
//
//  Created by Robert Xu on 2017/5/19.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "IdentityController.h"
#import "UITextField+Helper.h"

@interface IdentityController ()

@property (weak, nonatomic) IBOutlet UITextField *nameInput;
@property (weak, nonatomic) IBOutlet UITextField *idcardInput;

@end

@implementation IdentityController

#pragma mark - IBOutlet


#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setup 

- (void)setup {
    [self.nameInput setPlaceholderColor:UIColorFromRGB(0xC7C7C7) font:COL_DefaultFont_Size(14.0f)];
    [self.idcardInput setPlaceholderColor:UIColorFromRGB(0xC7C7C7) font:COL_DefaultFont_Size(14.0f)];
    
    
    UIBarButtonItem *itemRight = [[UIBarButtonItem alloc] initWithTitle:@"跳过" style:UIBarButtonItemStylePlain target:self action:@selector(toHomeAction:)];
    self.navigationItem.rightBarButtonItem = itemRight;
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName: COL_DefaultFont_Size(14)} forState:UIControlStateNormal];
}

#pragma mark - action

- (void)toHomeAction:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
