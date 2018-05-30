//
//  IdentityStatusController.m
//  parking
//
//  Created by Robert Xu on 2017/6/1.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "IdentityStatusController.h"
//#import "UIImage+Helper.h"


@interface IdentityStatusController ()

@end

@implementation IdentityStatusController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setWhiteTitleStyle];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self setDefaultTitleStyle];
}

@end
