//
//  GotoprepaidVC.m
//  mat
//
//  Created by 柯思汉 on 17/7/11.
//  Copyright © 2017年 hfy. All rights reserved.
//

#import "GotoprepaidVC.h"
#import "PrepaidCell.h"
#import "TopupsuccessVC.h"
#import "TopupAgreementVC.h"
#import "JFHttpRequestTool.h"
#import "DebugModel.h"
#import "SVProgressHUD.h"
#import "ActivitysModel.h"
#import <AlipaySDK/AlipaySDK.h>
#import "APAuthInfo.h"
#import "APOrderInfo.h"
#import "APRSASigner.h"


@interface GotoprepaidVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic,assign)NSInteger nextselect;
@property (strong, nonatomic) IBOutlet UIButton *wxs;
@property (strong, nonatomic) IBOutlet UIButton *zfbs;
//@property (nonatomic,strong) GotoprepaidModel *gotoprepaidModel;
@property (strong, nonatomic) IBOutlet UIButton *btn;
@property (nonatomic,strong)NSString *depositID;//充值规则
@property (nonatomic,strong)NSString *payType;//weChat，aliPay
@property (nonatomic,strong)NSString *money;
@property (nonatomic,strong)ActivitysModel *model;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *collectionHigh;

@end

@implementation GotoprepaidVC
- (void)viewWillAppear:(BOOL)animated
{
   
}
- (void)viewDidLoad {
    _nextselect=10000;
//    self.gotoprepaidModel.content =;
    [self requestGetGotopreApi];
    [super viewDidLoad];
    self.navigationItem.title=@"充值";
    [self.view addSubview:self.collectionView];
    [self requestActivitys];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)wx:(UIButton *)sender {
    _wxs.selected=!_wxs.selected;
    if (_zfbs.selected==YES) {
        _zfbs.selected=NO;
    }
    self.payType = @"weChat";
}
- (IBAction)zfb:(UIButton *)sender {
    _zfbs.selected=!_zfbs.selected;
    if (_wxs.selected==YES) {
        _wxs.selected=NO;
    }
    self.payType = @"aliPay";
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout= [[UICollectionViewFlowLayout alloc] init];
        
        NSInteger size = DEVICE_WIDTH/3-20;
        layout.itemSize = CGSizeMake(size, 65);
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        layout.minimumLineSpacing = 3;
        layout.minimumInteritemSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[PrepaidCell class] forCellWithReuseIdentifier:@"PrepaidCell"];
        _collectionView.frame = CGRectMake(15, 74, DEVICE_WIDTH-30, 130);
        _collectionView.backgroundColor =[UIColor clearColor];
    }
    return _collectionView;
}
#pragma mark- Collectionview Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
//    return 2;
    if(self.model.content.count%3)
    self.collectionHigh.constant = 65*(self.model.content.count/3+1)+74;
    else
        self.collectionHigh.constant = 65*(self.model.content.count/3)+74;
    return self.model.content.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PrepaidCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"PrepaidCell" forIndexPath:indexPath];
    if (indexPath.row == 1) {
        [cell.money setText:@"100元"];
    }
    ActivitysItem *item =[[ActivitysItem alloc]init];
    item = self.model.content[indexPath.row];
    NSLog(@"row =%ld",indexPath.row);
    cell.money.tag =100+indexPath.row;
    cell.money.text=item.reality;
    cell.giving.tag =1000+indexPath.row;
    cell.giving.text=[[NSString alloc]initWithFormat:@"赠送%@元",item.give];
    cell.btn.tag =10000+indexPath.row;
    [cell.btn addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchDown];
    cell.btn.layer.cornerRadius=5;
    cell.btn.layer.masksToBounds=YES;
    
    return cell;
}
- (void)btn:(UIButton *)sender
{
    UIButton *btn =[self.view viewWithTag:_nextselect];
    btn.layer.borderWidth=0.001;
    
    sender.layer.borderWidth=2;
    sender.layer.borderColor =KF_RGB(12, 190, 61).CGColor;
    
    UILabel *lb =[self.view viewWithTag:_nextselect-10000+100];
    lb.textColor =KF_RGB(11, 11, 11);
    
    UILabel *lb1 =[self.view viewWithTag:sender.tag-10000+100];
    lb1.textColor =KF_RGB(12, 190, 61);
    
    UILabel *lb2 =[self.view viewWithTag:_nextselect-10000+1000];
    lb2.textColor =KF_RGB(125, 125, 125);
    
    UILabel *lb3 =[self.view viewWithTag:sender.tag-10000+1000];
    lb3.textColor =KF_RGB(12, 190, 61);
    
    ActivitysItem *item =[[ActivitysItem alloc]init];
    item = self.model.content[sender.tag-10000];
    NSString *money =[[NSString alloc]initWithFormat:@"立即充值 (到账%d元)",[item.give intValue] +[item.reality intValue]];
//    if(sender.tag == 10000)
//    {
    [_btn setTitle:money forState:UIControlStateNormal];
        self.money =item.reality;
//    }
//    else
//    {
//    [_btn setTitle:@"支付100元" forState:UIControlStateNormal];
//        self.money = @"100";
//    }
    _nextselect=sender.tag;
    
//    self.depositID = item.ID;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
//    UIButton* btn =[self.view viewWithTag:TAGBASE+indexPath.row];
//    [self selbtn:btn];
}
- (void)requestPay:(NSString *)money;
{
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           [AccountService userModel].id,@"userID",
                           money,@"money",
                           @"1520239994",@"ts",
                           @"17890fae0e09ed9197ee0f552c435c2a",@"sign",
                           COLAGRequestAppID,@"appID",
                           nil];
    
    NSLog(@"parm =%@",param);
    JF_WS(weakSelf);
    [JFHttpRequestTool postWithURL:[[NSString alloc]initWithFormat:@"%@/v1/user/debugging/pay",COLAGBaseURL]  params:param success:^(id json) {
        NSLog(@"%@",json[@"message"]);
        if ([json[@"code"] intValue] == 0) {
            
            NSLog(@"json =%@",json);
            [SVProgressHUD showImage:nil status:@"充值成功"];
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        }else {
            //         [self showInfoWithMsg:json[@"message"]];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)requestActivitys;
{
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"1520239994",@"ts",
                           @"17890fae0e09ed9197ee0f552c435c2a",@"sign",
                           COLAGRequestAppID,@"appID",
                           nil];
    
    NSLog(@"parm =%@",param);
    JF_WS(weakSelf);
    [JFHttpRequestTool getWithURL:[[NSString alloc]initWithFormat:@"%@/v1/user/debugging/activitys",COLAGBaseURL]  params:param success:^(id json) {
        NSLog(@"%@",json[@"message"]);
        if ([json[@"code"] intValue] == 0) {
            
            NSLog(@"json =%@",json);
            weakSelf.model.content = [ActivitysItem mj_objectArrayWithKeyValuesArray:json[@"content"]];
            [weakSelf.collectionView reloadData];
        }else {
            //         [self showInfoWithMsg:json[@"message"]];
            
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}


- (IBAction)Topup:(id)sender {
//  [self doAPPay];
    [self requestPay];
//  [self requestPostUsersPaynumApi:self.depositID payType:self.payType];
    [self requestPay:self.money];
    
}
- (IBAction)agree:(id)sender {
    TopupAgreementVC *control =[[TopupAgreementVC alloc]initWithNibName:@"TopupAgreementVC" bundle:nil];
    [self.navigationController pushViewController:control animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)requestGetGotopreApi{
    
   
//    GetGotopreApi *api = [[GetGotopreApi alloc] init];
//    JF_WS(weakSelf);
//    [api sk_startWithWithSuccessBlock:^(YTKBaseRequest *request) {
//
//        NSLog(@"%@",request.responseJSONObject);
//        weakSelf.gotoprepaidModel.content =[GotoprepaidItem mj_objectArrayWithKeyValuesArray:request.responseJSONObject[@"content"]];
//        [weakSelf.collectionView reloadData];
//    }  errorBlock:^(YTKBaseRequest *request) {
//
//         [weakSelf endLoadingTip];
//    } failureBlock:^(NSString *message) {
//         [weakSelf endLoadingTip];
//    }];
//
    
}

- (void)requestPostUsersPaynumApi:(NSString*)depositID payType:(NSString *)payType{
    if (depositID.length==0||payType.length==0) {
        return;
    }
//    [self showLoadingTipWithMsg:@"充值中..."];
//    PostUsersPaynumApi *api = [[PostUsersPaynumApi alloc] initWithuserID:[UserData getUserInfo][@"id"] depositID:depositID payType:payType];
//    JF_WS(weakSelf);
//    [api sk_startWithWithSuccessBlock:^(YTKBaseRequest *request) {
//
//        NSLog(@"%@",request.responseJSONObject);
//        [weakSelf endLoadingTip];
//        [weakSelf showSuccessWithMsg:@"充值成功"];
//        TopupsuccessVC *control =[[TopupsuccessVC alloc]initWithNibName:@"TopupsuccessVC" bundle:nil];
//        [weakSelf.navigationController pushViewController:control animated:YES];
//    }  errorBlock:^(YTKBaseRequest *request) {
//        [weakSelf endLoadingTip];
//        [weakSelf showSuccessWithMsg:@"充值失败"];
//
//    } failureBlock:^(NSString *message) {
//        [weakSelf endLoadingTip];
//        [weakSelf showSuccessWithMsg:@"充值失败"];
//    }];
    
    
}

- (void)requestPay{
    
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"18174df6495dc9ea390d1657efb51f29",@"sign",
                           @"1525402877",@"ts",
                           @"ICETEST0-5F38-4A94-8F5F-78E38356557A",@"appID",
                           nil];
    NSLog(@"parm =%@",param);
    [JFHttpRequestTool postWithURL:@"https://ag.hfycloud.com/v1/alipay/sendAlipay"  params:param success:^(id json) {
        if ([json[@"code"] intValue] == 0) {
            
            NSLog(@"json =%@",json);
            
            //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
            NSString *appScheme = @"parking";
            
            // NOTE: 调用支付结果开始支付
            [[AlipaySDK defaultService] payOrder:json[@"content"] fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                NSLog(@"reslut = %@",resultDic);
            }];
            
        }else {
            //            [self showInfoWithMsg:json[@"message"]];
        }
    } failure:^(NSError *error) {
        
    }];
    
}

//http://192.168.31.11:8081/v1/alipay/sendAlipay
#pragma mark   ==============点击订单模拟支付行为==============
//
// 选中商品调用支付宝极简支付
//
- (void)doAPPay
{
    // 重要说明
    // 这里只是为了方便直接向商户展示支付宝的整个支付流程；所以Demo中加签过程直接放在客户端完成；
    // 真实App里，privateKey等数据严禁放在客户端，加签过程务必要放在服务端完成；
    // 防止商户私密数据泄露，造成不必要的资金损失，及面临各种安全风险；
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *appID = @"2018012502065665";

    // 如下私钥，rsa2PrivateKey 或者 rsaPrivateKey 只需要填入一个
    // 如果商户两个都设置了，优先使用 rsa2PrivateKey
    // rsa2PrivateKey 可以保证商户交易在更加安全的环境下进行，建议使用 rsa2PrivateKey
    // 获取 rsa2PrivateKey，建议使用支付宝提供的公私钥生成工具生成，
    // 工具地址：https://doc.open.alipay.com/docs/doc.htm?treeId=291&articleId=106097&docType=1
    NSString *rsa2PrivateKey = @"MIIEoQIBAAKCAQEAsTojq7/cZYQ48c5tudZu4nAo50+jxvgBd42epelXzyFhski+MEL+LTJw1c/l79QxpOIszNw2/1pODqo6DevVLA2UioOGwKGshthrbBw8vFZrbQsgfLlEP/1QSf4lXmV90Lp3aJuusZ86rmqAKfqIUHfT846H1w51jzCv6C8T4XBaORInj2C+qEs3iA6KTayDpwB8/x29xlBFpcTsQmnz9+D+WluCxAWJt8rMLUcTbjJ/ezOHUzTtDN8EmtDa+xwLpae3vKR0y6vESG7cbH5mgmprQrdi+S1GPRVEx0FOljbS5SDy2HEgFOtrKCvXcc+KBD3tExNhats8lC/CqQVIAQIDAQABAoIBAGrPGDplKeXAlzUb7MMoObGcWPp248SBKRktL6TcCYCapK926bBaX6dLk/c4EWLFppmxecCJI1gny41JCC3lqJahJJmKBQdJKJooCi2govX6u0l/gDfKzBgoiV/enBTU48uM5XQVB2ajCRGeu9kQ1WBxpzpM9w8j9rOyawFqhffB5oQsB/IBT1TRiAfPaMXMyw2CC7U62i5ZwEi3eIFZVYHQaJ9jphqlPlMbCsyNUl8ZZnjVhKoI4Y2QSEbUIGvkEwXexskv9vKYEU0387HT9CPoElUS+ix+doNxVRVWD9HXTpwHkz98ikqXtRhFMVHH1PqtfKZygSKnnWY+38VR1wECgYEA33kPFPD03PoueV/z6HpHojy9OiyydGuNtFMvXKku9qBa274cN5AwDrmzuOa1NfYDjwRJ2D0bc2nGLnRM612brT1kXSHW2HhCCpi4xRlzqzmYM9vUKCyqFTFeUS9igoHYWieFuT5vjrx9Jxaqt1p4MEz959xit/qeRwhn2JyUDZECgYEAywXkXNNKFbZ7FQNZ3k9PbyaTY/XI97FXJUQyZiGM7FpYDitCiAQ7QnwJTyeJGkUNX9dWluTN26xn0JALbHs3sTV4Bl1kfHqEDCK/+DBL/nqn9JiZR9SDU+DDQapFNd8Ozfa6BfgyXKmzy4aGrsMh7MpzpmBuEtbyF0h89+/tG3ECgYAmdcA5u2p46Xm8G95vYTQY4Nk0POMNlEEUCsj46okRmvFoJiTXDzKmJiGfLd18BvX/1B4dYA7sYwTfk9Z1H2weeZVfTeaa5L+A8V3DVikJC+V871VpAJ7Y/OEdmckbattgULL7+Znbd+cWJhmFasWKkoWUNOKshS5eTT0KE5CLcQKBgQCHgwdKbj2lAIhnHjV+DbIXnsgCkKvzqItidIKvaPWHTUY5LubZovlrBx+vldQNlMm4jyNc1JwTZKBmtb7qSdSClA3pMa1A6QX6k7dPEe2njndM7A5jw5VlB0FNMzm/G4PmNik0ktYKw7sevkxnmheq1fcbtoHCUXaF0/yWAa9iAQJ/MIuxHPSQ2+vDy3KQG1DOMtzpyqyPVWAtIVSb+7offCpozIy2nN41No3PvgGewsLAQZG42zx053mm0Tvcre21Yzx1uDLm1J6pLLAwUikpW1LMIJwofKM3yR0EKAy5LeT0pJCzN8ki2RhHhVow5rwk7Er7zelhMsxsWfiRh5UYxA==";
    NSString *rsaPrivateKey = @"";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/

    //partner和seller获取失败,提示
    if ([appID length] == 0 ||
        ([rsa2PrivateKey length] == 0 && [rsaPrivateKey length] == 0))
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                       message:@"缺少appId或者私钥,请检查参数设置"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action){

                                                       }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:^{ }];
        return;
    }

    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    APOrderInfo* order = [APOrderInfo new];

    // NOTE: app_id设置
    order.app_id = appID;

    // NOTE: 支付接口名称
    order.method = @"alipay.trade.app.pay";

    // NOTE: 参数编码格式
    order.charset = @"utf-8";

    // NOTE: 当前时间点
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    order.timestamp = [formatter stringFromDate:[NSDate date]];

    // NOTE: 支付版本
    order.version = @"1.0";

    // NOTE: sign_type 根据商户设置的私钥来决定
    order.sign_type = (rsa2PrivateKey.length > 1)?@"RSA2":@"RSA";

    // NOTE: 商品数据
    order.biz_content = [APBizContent new];
    order.biz_content.body = @"我是测试数据";
    order.biz_content.subject = @"1";
    order.biz_content.out_trade_no = [self generateTradeNO]; //订单ID（由商家自行制定）
    order.biz_content.timeout_express = @"30m"; //超时时间设置
    order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", 0.01]; //商品价格

    //将商品信息拼接成字符串
    NSString *orderInfo = [order orderInfoEncoded:NO];
    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
    NSLog(@"orderSpec = %@",orderInfo);

    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
    //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
    NSString *signedString = nil;
    APRSASigner* signer = [[APRSASigner alloc] initWithPrivateKey:((rsa2PrivateKey.length > 1)?rsa2PrivateKey:rsaPrivateKey)];
    if ((rsa2PrivateKey.length > 1)) {
        signedString = [signer signString:orderInfo withRSA2:YES];
    } else {
        signedString = [signer signString:orderInfo withRSA2:NO];
    }

    // NOTE: 如果加签成功，则继续执行支付
    if (signedString != nil) {
        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
        NSString *appScheme = @"hfmat";

        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                 orderInfoEncoded, signedString];

        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
        }];
    }
}

- (void)doalipay
{
//    //将商品信息赋予AlixPayOrder的成员变量
//    Order* order = [Order new];
//
//    // NOTE: app_id设置
//    order.app_id = appID;
//
//    // NOTE: 支付接口名称
//    order.method = @"alipay.trade.app.pay";
//
//    // NOTE: 参数编码格式
//    order.charset = @"utf-8";
//
//    // NOTE: 当前时间点
//    NSDateFormatter* formatter = [NSDateFormatter new];
//    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    order.timestamp = [formatter stringFromDate:[NSDate date]];
//
//    // NOTE: 支付版本
//    order.version = @"1.0";
//
//    // NOTE: sign_type设置
//    order.sign_type = @"RSA";
//
//    // NOTE: 商品数据
//    order.biz_content = [BizContent new];
//    order.biz_content.body = @"我是测试数据";
//    order.biz_content.subject = @"1";
//    order.biz_content.out_trade_no = [self generateTradeNO]; //订单ID（由商家自行制定）
//    order.biz_content.timeout_express = @"30m"; //超时时间设置
//    order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", 0.01]; //商品价格
//
//    //将商品信息拼接成字符串
//    NSString *orderInfo = [order orderInfoEncoded:NO];
//    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
//    NSLog(@"orderSpec = %@",orderInfo);
//
//    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
//    //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
//    id<DataSigner> signer = CreateRSADataSigner(privateKey);
//    NSString *signedString = [signer signString:orderInfo];
//
//    // NOTE: 如果加签成功，则继续执行支付
//    if (signedString != nil) {
//        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
//        NSString *appScheme = @"alisdkdemo";
//
//        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
//        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
//                                 orderInfoEncoded, signedString];
//
//        // NOTE: 调用支付结果开始支付
//        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
//            NSLog(@"reslut = %@",resultDic);
//        }];
}

#pragma mark   ==============产生随机订单号==============

- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}


//- (GotoprepaidModel*)gotoprepaidModel
//{
//    if (!_gotoprepaidModel) {
//        _gotoprepaidModel=[[GotoprepaidModel alloc]init];
//    }
//    return _gotoprepaidModel;
//}

- (NSString*)depositID
{
    if (!_depositID) {
        _depositID = [[NSString alloc]init];
    }
    return _depositID;
}

- (NSString *)payType
{
    if (!_payType) {
        _payType = [[NSString alloc]init];
        
    }
    return _payType;
}

- (ActivitysModel *)model
{
    if (!_model) {
        _model = [[ActivitysModel alloc]init];
        
    }
    return _model;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
