//
//  AddCarController.m
//  parking
//
//  Created by Robert Xu on 2017/5/25.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "AddCarController.h"
#import "AddCarPresenter.h"

@interface AddCarController () <UITextFieldDelegate, AddCarPresenterDelegate>

@property (strong, nonatomic) AddCarPresenter *addCarPresenter;

@property (weak, nonatomic) IBOutlet UITextField *inputN1;
@property (weak, nonatomic) IBOutlet UITextField *inputN2;
@property (weak, nonatomic) IBOutlet UITextField *inputN3;
@property (weak, nonatomic) IBOutlet UITextField *inputN4;
@property (weak, nonatomic) IBOutlet UITextField *inputN5;
@property (weak, nonatomic) IBOutlet UITextField *inputN6;
@property (weak, nonatomic) IBOutlet UITextField *inputN7;
@property (weak, nonatomic) IBOutlet UITextField *inputN8;
@property (weak, nonatomic) IBOutlet UIView *placeholderViewForN8;

@property (weak, nonatomic) IBOutlet UIButton *minTypeButton;
@property (weak, nonatomic) IBOutlet UIButton *midTypeButton;
@property (weak, nonatomic) IBOutlet UIButton *maxTypeButton;


@property (strong, nonatomic) NSArray<UITextField *> *inputArray;
@property (assign, nonatomic) NSInteger  index;
@property (assign, nonatomic) NSUInteger currentSelectType;

@end

@implementation AddCarController

#pragma mark - AddCarPresenterDelegate

- (void)addCarAddedSuccess:(BOOL)success message:(NSString *)message {
    if (success) {
        //设置默认车辆 || 刷新
        [COLToast showToast:message];
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [COLToast showToast:message];
    }
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

- (void)dealloc {
    [_addCarPresenter detachView];
}

# pragma mark - setup 

- (void)setup {
    
    self.currentSelectType = 0;
    
    self.addCarPresenter = [[AddCarPresenter alloc] initWithService:[[CarService alloc] init]];
    [self.addCarPresenter attachView:self];
    
    self.inputArray = @[_inputN1, _inputN2, _inputN3, _inputN4, _inputN5, _inputN6, _inputN7, _inputN8];
}

#pragma mark - action

- (IBAction)minTypeAction:(UIButton *)sender {
    [self setButtonBlue:sender];
    [self setButtonWhite:self.midTypeButton];
    [self setButtonWhite:self.maxTypeButton];
    self.currentSelectType = 0;
}

- (IBAction)midTypeAction:(UIButton *)sender {
    [self setButtonBlue:sender];
    [self setButtonWhite:self.minTypeButton];
    [self setButtonWhite:self.maxTypeButton];
    self.currentSelectType = 1;
}

- (IBAction)maxTypeAction:(UIButton *)sender {
    [self setButtonBlue:sender];
    [self setButtonWhite:self.minTypeButton];
    [self setButtonWhite:self.midTypeButton];
    self.currentSelectType = 2;
}

- (IBAction)submitAction:(UIButton *)sender {
    
    //获取车牌号
    NSString *num1 = [self.inputN1.text col_trim];
    NSString *num2 = [self.inputN2.text col_trim];
    NSString *num3 = [self.inputN3.text col_trim];
    NSString *num4 = [self.inputN4.text col_trim];
    NSString *num5 = [self.inputN5.text col_trim];
    NSString *num6 = [self.inputN6.text col_trim];
    NSString *num7 = [self.inputN7.text col_trim];
    //绿色能源号码
    NSString *greenNumber = [self.inputN8.text col_trim];
    NSString *plateNumber = @"";
    if ([greenNumber length] > 0) {
        //有填写
        plateNumber = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@", num1, num2, num3, num4, num5, num6, num7, greenNumber];
    } else {
        
        plateNumber = [NSString stringWithFormat:@"%@%@%@%@%@%@%@", num1, num2, num3, num4, num5, num6, num7];
    }
    
    NSString *currentCarType = @"min";
    switch (self.currentSelectType) {
        case 0:
            currentCarType = @"min";
            break;
        case 1:
            currentCarType = @"mid";
            break;
        case 2:
            currentCarType = @"max";
            break;
            
        default:
            break;
    }
    
    [self.addCarPresenter adCarByPlateNo:plateNumber type:currentCarType];
}

- (void)setButtonBlue:(UIButton *)button {
    [button setBackgroundColor:UIColorFromRGB(0x3EB4F8)];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (void)setButtonWhite:(UIButton *)button {
    [button setBackgroundColor:[UIColor whiteColor]];
    [button setTitleColor:UIColorFromRGB(0x111111) forState:UIControlStateNormal];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == self.inputN8) {
        self.placeholderViewForN8.hidden = YES;
    } else {
        self.placeholderViewForN8.hidden = NO;
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.inputN8) {
        self.placeholderViewForN8.hidden = YES;
    } else {
        self.placeholderViewForN8.hidden = NO;
    }
    
    //    NSLog(@"string  ***%@",string);
    if (string.length > 0 && _index == 0) {
        _inputArray[0].text = string;
        _index = [self forinArr:0 array:_inputArray];
        return NO;
    }else if(string.length > 0 && _index == 1){
        _inputArray[1].text = string;
        _index = [self forinArr:1 array:_inputArray];
        return NO;
    }else if(string.length > 0 && _index == 2){
        _inputArray[2].text = string;
        _index = [self forinArr:2 array:_inputArray];
        return NO;
    }else if(string.length > 0 && _index == 3){
        _inputArray[3].text = string;
        _index = [self forinArr:3 array:_inputArray];
        return NO;
    }else if(string.length > 0 && _index == 4){
        _inputArray[4].text = string;
        _index = [self forinArr:4 array:_inputArray];
        return NO;
    }else if(string.length > 0 && _index == 5){
        _inputArray[5].text = string;
        _index = [self forinArr:5 array:_inputArray];
        return NO;
    }
    else if(string.length > 0 && _index == 6){
        _inputArray[6].text = string;
        _index = [self forinArr:6 array:_inputArray];
        return NO;
    }
    
    else
        return YES;
}

- (NSInteger)forinArr:(NSInteger )j array:(NSArray *)_arr{
    NSInteger k = 0;
    BOOL isChang = NO;
    for (NSInteger i = j; i < _arr.count; i++) {
        if([_arr[i] text].length == 0)
        {
            k = i;
            [_arr[i] becomeFirstResponder];
//            NSLog(@"%lu",k);
            isChang = YES;
            break;
        };
    }
    if (!isChang) {
        for (NSInteger i = 0; i < _arr.count; i++) {
            if([_arr[i] text].length == 0)
            {
                k = i;
                [_arr[i] becomeFirstResponder];
//                NSLog(@"%lu",[_arr[i] text].length);
                isChang = YES;
                break;
            };
        }
    }
    NSLog(@"%ld",(long)k);
    if (!isChang) {
        [self.view endEditing:YES];
        return 6;
    }else
        return k;
}

@end
