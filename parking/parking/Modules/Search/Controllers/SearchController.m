//
//  SearchController.m
//  parking
//
//  Created by Robert Xu on 2017/5/25.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "SearchController.h"
#import "DLTabedSlideView.h"
#import "SearchHistoryController.h"
#import "SearchCollectionController.h"
#import "COLSearchBar.h"
#import "SearchCell.h"
#import "HomeController.h"
#import "COLMediator+Home.h"



@interface SearchController () <DLTabedSlideViewDelegate, AMapSearchDelegate, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet DLTabedSlideView *tabedSlideView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) AMapSearchAPI *searchAPI;
@property (strong, nonatomic) NSMutableArray *poiList;

@property (strong, nonatomic) COLSearchBar *searchBar;

@property (nonatomic,strong)UITextField *searchfield;
@end

@implementation SearchController

#pragma mark - UITableViewDelegate



#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.poiList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchCell *cell = [SearchCell cellForTableView:tableView];
    [cell showData:_poiList[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return COLTableViewCellRowTwoLineDefaultHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",self.poiList[indexPath.row]);
    AMapPOI *poi = [[AMapPOI alloc]init];
    poi = self.poiList[indexPath.row];

    NSDictionary *userInfo = [[NSDictionary alloc]initWithObjectsAndKeys:[[NSString alloc]initWithFormat:@"%lf",poi.location.latitude],@"latitude",[[NSString alloc]initWithFormat:@"%lf",poi.location.longitude],@"longitude", nil];
    NSNotification *notification =[NSNotification notificationWithName:@"searController" object:nil userInfo:userInfo];
    // 3.通过 通知中心 发送 通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
    [self.navigationController popViewControllerAnimated:YES];
    [self setHistory:poi];
    
}

//设置历史信息
- (void)setHistory:(AMapPOI*)poi
{
    NSMutableDictionary *historical =[[NSMutableDictionary alloc]initWithDictionary:[UserData getHistorical]];
    NSMutableArray *arr =[[NSMutableArray alloc]initWithArray:historical[@"historical"]];
//    AMapGeoPoint *location =dic[@"location"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:poi.name forKey:@"name"];
    [dic setValue:poi.address forKey:@"address"];
    [dic setValue:[[NSString alloc]initWithFormat:@"%f",poi.location.longitude] forKey:@"longitude"];
    [dic setValue:[[NSString alloc]initWithFormat:@"%f",poi.location.latitude] forKey:@"latitude"];
    [arr addObject:dic];
    
    NSDictionary *historicaldic =[[NSDictionary alloc]initWithObjectsAndKeys:arr,@"historical", nil];
    
    [UserData setHistorical:historicaldic];
}

#pragma mark - DLTabedSlideViewDelegate

- (NSInteger)numberOfTabsInDLTabedSlideView:(DLTabedSlideView *)sender{
    return 2;
}
- (UIViewController *)DLTabedSlideView:(DLTabedSlideView *)sender controllerAt:(NSInteger)index{
    switch (index) {
        case 0:
        {
//            COLWeakSelf(self)
            SearchHistoryController *history = [[SearchHistoryController alloc] init];
            return history;
        }
        case 1:
        {
//            COLWeakSelf(self)
            SearchCollectionController *collection = [[SearchCollectionController alloc] init];
            return collection;
        }
            
        default:
            return nil;
    }
}

#pragma mark - setup

- (void)setup {
    _tabedSlideView.delegate = self;
    _tabedSlideView.baseViewController = self;
    _tabedSlideView.tabItemNormalColor = COL_COLOR_TEXT_DEFAULT_LIGHT;
    _tabedSlideView.tabItemSelectedColor = COL_COLOR_TEXT_DEFAULT;
    _tabedSlideView.tabbarTrackColor = COL_COLOR_LIGHT_BLUE;
    _tabedSlideView.tabbarBottomSpacing = 0.0f;
    DLTabedbarItem *item1 = [DLTabedbarItem itemWithTitle:@"历史记录" image:nil selectedImage:nil];
    DLTabedbarItem *item2 = [DLTabedbarItem itemWithTitle:@"我的收藏" image:nil selectedImage:nil];
    _tabedSlideView.tabbarItems = @[item1, item2];
    [_tabedSlideView buildTabbar];
    
    _tabedSlideView.selectedIndex = 0;
    //搜索条
    self.searchBar = [[COLSearchBar alloc] initWithFrame:CGRectMake(50, 26, COL_SCREEN_WIDTH - 100, 30)];
    self.searchBar.textInput.delegate = self;
    self.searchBar.textInput.returnKeyType = UIReturnKeySearch;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
//    [self.navigationItem setTitleView:self.searchBar];
    [[[UIApplication sharedApplication]keyWindow]addSubview:self.searchBar];
    //初始化高德搜索API
    self.searchAPI = [[AMapSearchAPI alloc] init];
    self.searchAPI.delegate = self;
    
    self.poiList = [NSMutableArray arrayWithCapacity:1];
    self.tableView.hidden = YES;
//    [self setTextFiled:CGRectMake(40, 25, COL_SCREEN_WIDTH-60, 30)];

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
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
- (void)textFieldTextDidChange:(NSNotification*)aNotification {
    if ([[self.searchBar.textInput.text col_trim] length] > 0) {
        // 开始搜索显示搜索搜索View 并搜索
        self.tableView.hidden = NO;
        [self startSearchWithKeyword:self.searchBar.textInput.text];
    } else {
        self.tableView.hidden = YES;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return YES;
}

#pragma mark - action

- (void)startSearchWithKeyword:(NSString *)keyword {
    COLWeakSelf(self)
    [[COLMap sharedCOLMap] startSingleLocWithReGeocode:YES CompletionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        COLStrongSelf(self)
        if (regeocode) {
            [self searchWithKeyword:keyword city:regeocode.city];
        } else {
            [self searchWithKeyword:keyword city:@"北京"];
        }
    }];
}

- (void)searchWithKeyword:(NSString *)keyword city:(NSString *)city {
    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
    request.keywords            = keyword;
    request.city                = city;
    request.types               = @"";
    request.requireExtension    = YES;
    /*  搜索SDK 3.2.0 中新增加的功能，只搜索本城市的POI。*/
    request.cityLimit           = YES;
    request.requireSubPOIs      = YES;
    [self.searchAPI AMapPOIKeywordsSearch:request];
}

#pragma mark - AMapSearchDelegate
/* POI 搜索回调. */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if (response.pois.count == 0)
    {
        return;
    }
    
    self.poiList = [NSMutableArray arrayWithCapacity:response.pois.count];
    [self.poiList addObjectsFromArray:response.pois];
    
    [self.tableView reloadData];
}

- (void)setTextFiled:(CGRect)frame
{
    self.searchfield = [[UITextField alloc]initWithFrame:frame];
    self.searchfield.borderStyle = UITextBorderStyleRoundedRect;
    self.searchfield.backgroundColor = [UIColor whiteColor];
    self.searchfield.placeholder = @"请输入目的地或停车场名称";
    self.searchfield.font = [UIFont fontWithName:@"Arial" size:13.0f];
    self.searchfield.textColor = COL_COLOR_TEXT_DEFAULT_LIGHT;
    self.searchfield.textAlignment = NSTextAlignmentLeft;
    self.searchfield.keyboardType = UIKeyboardTypeDefault;
    self.searchfield.returnKeyType =UIReturnKeySearch;
    self.searchfield.delegate = self;
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
    [self.view addSubview:self.searchfield];
    [self.view bringSubviewToFront:self.searchfield];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.searchBar removeFromSuperview];
}

@end
