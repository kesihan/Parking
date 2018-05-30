//
//  HomeController.m
//  parking
//
//  Created by Robert Xu on 2017/5/18.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "HomeController.h"
#import "HomeBottomCell.h"
#import "EBCardCollectionViewLayout.h"
#import <MAMapKit/MAMapKit.h>
#import "CustomAnnotationView.h"
#import "CustomPointAnnotation.h"
#import "SVProgressHUD.h"

//Mediator
#import "COLMediator+Logon.h"
#import "COLMediator+ParkingList.h"
#import "COLMediator+ParkingDetail.h"
#import "COLMediator+Search.h"
#import "COLMediator+Home.h"

#import "HomePresenter.h"

//
#import "UIView+Helper.h"
#import "COLMap.h"
#import "COLMapNavi.h"
#import "EAIntroView.h"
#import "COLFirstLaunch.h"
#import "CommonTools.h"

#import "StoptimeView.h"//计时控件
#import "StopInfodetailView.h"//停车详细情况
#import "WaitingPayVC.h"//付款界面
#import "ParktimeView.h"//停车计时小控件
#import "Getnavigationrealtime.h"
#import "AccountService.h"
#import <AFNetworking.h>
#import "JFHttpRequestTool.h"
#import "SearchController.h"
#define DEVICE_WIDTH ([UIScreen mainScreen].bounds.size.width)//设备宽
#define DEVICE_HEIGHT ([UIScreen mainScreen].bounds.size.height)//设备高
//地图缩放级别
static NSInteger kZoomLevel = 15;

@interface HomeController () <UITextFieldDelegate, UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, HomeBottomCellDelegate, MAMapViewDelegate, EAIntroDelegate, HomePresenterDelegate, MAMapViewDelegate>

@property (strong, nonatomic) HomePresenter *homePresenter;

@property (weak, nonatomic) IBOutlet UICollectionView *bottomCollectionView;
@property (weak, nonatomic) IBOutlet UIView *bottomHelperView;
@property (strong, nonatomic) UIViewController *modalVC;

//顶部工具条
@property (weak, nonatomic) IBOutlet UIView *topBarBackground;
@property (weak, nonatomic) IBOutlet UIImageView *userAvatar;
@property (weak, nonatomic) IBOutlet UITextField *searchInput;
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;

//地图
@property (weak, nonatomic) IBOutlet MAMapView *mapView;
@property (weak, nonatomic) CustomAnnotationView* lastAnnotation;
@property (assign, nonatomic) CLLocationDegrees lastLatitude;
@property (assign, nonatomic) CLLocationDegrees lastLongitude;

@property (weak, nonatomic) IBOutlet UIView *filterPanel;
@property (weak, nonatomic) IBOutlet UIButton *filterAllButton;
@property (weak, nonatomic) IBOutlet UIButton *filterFreeSpaceButton;

@property (strong, nonatomic) NSMutableArray<NearbyParkingModel *> *parkingList;
@property (strong, nonatomic) NSMutableArray *annotationList;

@property (strong, nonatomic) CLLocation *currentLocation;
@property (assign, nonatomic) BOOL isUserTapAnnotation;
@property (nonatomic,strong)StoptimeView *stoptimeView;
@property (nonatomic,strong)StopInfodetailView *stopInfodetailView;
@property (nonatomic,strong)ParktimeView *parktimeView;
@property (nonatomic,strong)NSTimer *timer;//记录停车时间
@property (nonatomic,assign)NSInteger stoptime;
@property (nonatomic,strong)NSDictionary *location_dic;
@property (nonatomic,strong)NSDictionary *location_new;
@end

@implementation HomeController

#pragma mark - setup

- (void)setup {
    
    //数据初始化
    self.parkingList = [NSMutableArray arrayWithCapacity:1];
    self.annotationList = [NSMutableArray arrayWithCapacity:1];
    
    [self setupGuide];
    
    // 设置导航控制器的代理为self
    self.navigationController.delegate = self;
    
    
    // 底部
    UIOffset anOffset = UIOffsetMake(0,0);
    [(EBCardCollectionViewLayout *)self.bottomCollectionView.collectionViewLayout setOffset:anOffset];
    [(EBCardCollectionViewLayout *)self.bottomCollectionView.collectionViewLayout setLayoutType:EBCardCollectionLayoutHorizontal];
    
    //顶部用户头像添加响应方法
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(menuAction:)];
    [self.userAvatar addGestureRecognizer:tap];
    self.userAvatar.userInteractionEnabled = YES;
    [self.userAvatar sd_setImageWithURL:[NSURL URLWithString:[AccountService userModel].headImage] placeholderImage:[UIImage imageNamed:@"Identity_icon_name_nor"]];
    //输入框
    self.searchInput.delegate = self;
    
    
    //设置阴影
    [self.topBarBackground setDefaultShadow];
    
    //自定义地图
    [AMapServices sharedServices].enableHTTPS = YES;
    
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollowWithHeading;
    _mapView.showsScale = NO;
    _mapView.showsCompass = NO;
    _mapView.rotateCameraEnabled= NO;
    
    MAUserLocationRepresentation *r = [[MAUserLocationRepresentation alloc] init];
    r.showsAccuracyRing = YES;
    r.showsHeadingIndicator = NO;
    r.image = [UIImage imageNamed:@"home_icon_currentloc_nor"];
    [self.mapView updateUserLocationRepresentation:r];
    
    //配置定位
    [[COLMap sharedCOLMap] configureSingleLoc];
    
    //Presenter
    self.homePresenter = [[HomePresenter alloc] initWithService:[[HomeService alloc] init]];
    [self.homePresenter attachView:self];
    
    //隐藏过滤器
    self.filterPanel.hidden = YES;
    
    //隐藏底部详情
    self.bottomCollectionView.hidden = YES;
    
    [[COLMap sharedCOLMap] startSingleLocWithReGeocode:NO CompletionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        [self.mapView setCenterCoordinate:location.coordinate animated:YES];
        [self.mapView setZoomLevel:kZoomLevel animated:YES];
    }];
    
    
}

#pragma mark - UINavigationControllerDelegate
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    
    [self.navigationController pushViewController:[[COLMediator sharedInstance] searchController] animated:YES];
    return NO;
}


#pragma mark - action

- (IBAction)menuAction:(id)sender {
    //判断是否已经登录
    BOOL switchButton = [self.homePresenter isUserLogin];
    if (switchButton) {
        [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    } else {
        [self.navigationController pushViewController:[[COLMediator sharedInstance] logonController] animated:YES];
    }
}

- (IBAction)parkingListAction:(id)sender {
    //附近停车场列表
    NSString *lng = [NSString stringWithFormat:@"%lf", self.lastLongitude];
    NSString *lat = [NSString stringWithFormat:@"%lf", self.lastLatitude];
    [self.navigationController pushViewController:[[COLMediator sharedInstance] parkingListControllerWithLng:lng lat:lat] animated:YES];
}

- (IBAction)trafficAction:(id)sender {
    _mapView.showTraffic = _mapView.isShowTraffic ? NO : YES;
}

- (IBAction)filterAction:(id)sender {
    self.filterPanel.hidden = !self.filterPanel.hidden;
}

//全部
- (IBAction)filterAllAction:(id)sender {
    [self setFilterButtonSelect:(UIButton *)sender];
}

//有空车位
- (IBAction)filterFreeSpaceAction:(id)sender {
    [self setFilterButtonSelect:(UIButton *)sender];
}

- (void)setFilterButtonSelect:(UIButton *)button {
    if (self.filterAllButton == button) {
        //选中
        [self.filterAllButton setTitleColor:UIColorFromRGB(0x3EB4F8) forState:UIControlStateNormal];
        //未选中
        [self.filterFreeSpaceButton setTitleColor:UIColorFromRGB(0x8A8A8A) forState:UIControlStateNormal];
    } else {
        //选中
        [self.filterAllButton setTitleColor:UIColorFromRGB(0x8A8A8A) forState:UIControlStateNormal];
        //未选中
        [self.filterFreeSpaceButton setTitleColor:UIColorFromRGB(0x3EB4F8) forState:UIControlStateNormal];
        
    }
}

//点击居中
- (IBAction)centerAction:(id)sender {
    COLWeakSelf(self)
    [[COLMap sharedCOLMap] startSingleLocWithReGeocode:NO CompletionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        COLStrongSelf(self)
        [self.mapView setCenterCoordinate:location.coordinate animated:YES];
        //        NSLog(@"%f %f", location.coordinate.latitude, location.coordinate.longitude);
        //        CLLocation *end = [[CLLocation alloc] initWithLatitude:24.466727 longitude:118.183004];
        //导航界面
        //        [self.navigationController pushViewController:[[COLMediator sharedInstance] homeNaviControllerWithParams:@{@"start": location, @"end": end}] animated:YES];
        //后台获取导航数据
        //        [[COLMapNavi sharedCOLMapNavi] startNaviWithStartPoint:location endPoint:end];
    }];
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NearbyParkingModel *model = self.parkingList[indexPath.row];
    [self showParkingDetailWithDetail:model];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.isUserTapAnnotation) {
        CustomPointAnnotation *annotation = self.annotationList[indexPath.row];
        //放大当前AnnotionView
        CustomAnnotationView *view = (CustomAnnotationView *)[self.mapView viewForAnnotation:annotation];
        [self scaleCurrentAnnotationView:view];
        //规划路线
        CLLocationCoordinate2D destCoordinate = annotation.coordinate;
        [self addPolylineBy:destCoordinate];
    } else {
        self.isUserTapAnnotation = NO;
    }
}


#pragma mark -

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.parkingList count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeBottomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeBottomCell"
                                                                     forIndexPath:indexPath];
    [cell showData:self.parkingList[indexPath.row]];
    cell.index = indexPath.row;
    cell.delegate = self;
    return cell;
}

- (BOOL)shouldAutorotate {
    [self.bottomCollectionView.collectionViewLayout invalidateLayout];
    
    BOOL retVal = YES;
    return retVal;
}

#pragma mark - HomeBottomCellDelegate

- (void)homeBottomCellSwipeUpAtIndexPath:(NSIndexPath *)indexPath parkingDetail:(NearbyParkingModel *)detail {
    [self showParkingDetailWithDetail:detail];
}
//导航开始 按钮
- (void)homeBottomNaviButtonClickedWithLng:(NSString *)lng lat:(NSString *)lat {
    
    CLLocation *end = [[CLLocation alloc] initWithLatitude:[lat doubleValue] longitude:[lng doubleValue]];
    [self.navigationController pushViewController:[[COLMediator sharedInstance] homeNaviControllerWithParams:@{@"start": self.currentLocation, @"end": end}] animated:YES];
}

- (void)homeBottomCollectButtonClickedWithParkingID:(NSString *)parkingID {
    [self.homePresenter addCollectionByParkingID:parkingID];
}
- (void)time:(NSTimer*)timer
{
    _stoptime++;
    
    [self.stoptimeView.time setTitle:[self getOvertime:[[NSString alloc]initWithFormat:@"%ld",_stoptime]] forState:UIControlStateNormal];
    [self.stopInfodetailView.time setText:[self getOvertime:[[NSString alloc]initWithFormat:@"%ld",_stoptime]]];
    [self.parktimeView.time setText:[self getOvertime:[[NSString alloc]initWithFormat:@"%ld",_stoptime]]];
}
//将时间数据（毫秒）转换为天和小时
- (NSString*)getOvertime:(NSString*)mStr
{
    long msec = [mStr longLongValue];
    
    if (msec <= 0)
    {
        return @"";
    }
    
    //    NSInteger d = msec/1000/60/60/24;
    NSInteger h = msec/60/60%24;
    NSInteger  m = msec/60%60;
    NSInteger  s = msec%60;
    
    NSString *_tStr = @"";
    NSString *_mStr = @"";
    NSString *_hStr = @"";
    NSString *_sStr = @"";
    NSString *_hTimeType = @"defaultColor";
    
    if (h <10)
    {
        _hStr = [NSString stringWithFormat:@"0%ld",h];
    }
    else
    {
        _hStr = [NSString stringWithFormat:@"%ld",h];
    }
    if (m < 10)
    {
        _mStr = [NSString stringWithFormat:@"0%ld",m];
    }
    else
    {
        _mStr = [NSString stringWithFormat:@"%ld",m];
    }
    if (s < 10)
    {
        _sStr = [NSString stringWithFormat:@"0%ld",s];
    }
    else
    {
        _sStr = [NSString stringWithFormat:@"%ld",s];
    }
    
    //小于2小时 高亮显示
    if (h > 0 && h < 2)
    {
        _hTimeType = @"hightColor";
    }
    
    
    _tStr = [NSString stringWithFormat:@" %@:%@:%@",_hStr,_mStr,_sStr];
    
    return _tStr;
}

#pragma mark - lifecycle
- (void)viewWillAppear:(BOOL)animated
{
    //    [self interfaceOrientation:UIInterfaceOrientationPortrait];
    
    self.stopInfodetailView.hidden = YES;
    _timer =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(time:) userInfo:nil repeats:YES ];
    [self.view addSubview:self.stoptimeView];
    [self.view addSubview:self.stopInfodetailView];
    [self.view addSubview:self.parktimeView];
    self.stoptimeView.hidden = YES;
    self.parktimeView.hidden = YES;
    _stoptime = 0;
    [self requestGetnavigationrealtime];
    [self.mapView reloadMap];
    [self.homePresenter attachView:self];
    self.bottomCollectionView.hidden = YES;
    [self.mapView removeOverlays:self.mapView.overlays];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [_timer invalidate];
    _timer = nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    
    NSNotificationCenter * login = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [login addObserver:self selector:@selector(searController:) name:@"searController" object:nil];
    
}
- (void)searController:(NSNotification *)notice
{
    self.lastLatitude = 0;
    self.lastLongitude = 0;
    NSDictionary *resultDic = notice.userInfo;
    self.location_dic = [[NSDictionary alloc]initWithDictionary:resultDic];
    NSString *latitude = [[NSString alloc]initWithFormat:@"%@",resultDic[@"latitude"]];
    NSString *longitude = [[NSString alloc]initWithFormat:@"%@",resultDic[@"longitude"]];
    CLLocationCoordinate2D center = (CLLocationCoordinate2D){[latitude floatValue], [longitude floatValue]};
    [self.mapView setCenterCoordinate:center animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)dealloc {
    
    [_homePresenter detachView];
}

#pragma mark - getter and setter

- (void)setupGuide {
    
    //判断是否是第一次启动
    if ([COLFirstLaunch isFirstLaunch]) {
        EAIntroPage *page1 = [EAIntroPage page];
        page1.bgImage = [UIImage imageNamed:@"home_image_guide1_nor"];
        EAIntroPage *page2 = [EAIntroPage page];
        page2.bgImage = [UIImage imageNamed:@"home_image_guide2_nor"];
        EAIntroPage *page3 = [EAIntroPage page];
        page3.bgImage = [UIImage imageNamed:@"home_image_guide3_nor"];
        EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.view.bounds andPages:@[page1,page2,page3]];
        intro.tapToNext = YES;
        [intro setDelegate:self];
        [intro showInView:self.view animateDuration:0.0];
    }
}

- (void)showParkingDetailWithDetail:(NearbyParkingModel *)detail {
    //从下往上push的效果
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController pushViewController:[[COLMediator sharedInstance] parkingDetailControllerWithParams:@{@"detail": detail}] animated:NO];
}

#pragma mark - MAMapViewDelegate
//自定义annotation
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[CustomPointAnnotation class]])
    {
        CustomPointAnnotation *cus = annotation;
        static NSString *pointReuseIndentifier = @"CustomAnnotationView";
        CustomAnnotationView* annotationView = (CustomAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.titleLabel.text = cus.title;
        annotationView.subTitleLabel.text = cus.subtitle;
        annotationView.draggable = NO;        //设置标注可以拖动，默认为NO
        annotationView.color = cus.colorNumber;
        //小的( 0, 0, 27, 40)
        
        annotationView.tag = cus.index;
        
        return annotationView;
    }
    return nil;
}

//点击地图回调
- (void)mapView:(MAMapView *)mapView didSingleTappedAtCoordinate:(CLLocationCoordinate2D)coordinate {
    [self becomeNormalAnimateWithView:self.lastAnnotation];
    self.bottomCollectionView.hidden = YES;
    self.stopInfodetailView.hidden =YES;
    self.parktimeView.hidden = YES;
    if([[UserData getType] isEqualToString:@"in"])
        self.stoptimeView.hidden =NO;
    else
        self.stoptimeView.hidden =YES;
    //删除折线
    [self.mapView removeOverlays:self.mapView.overlays];
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view {
    
    //如果是用户的定位点则不处理
    if ([view isKindOfClass:[NSClassFromString(@"MAUserLocationView") class]]) {
        return;
    } else {
        //如果已经被点击过则不处理
        if (view == self.lastAnnotation) {
            return;
        }
        
        self.isUserTapAnnotation = YES;
        NSInteger index = view.tag;
        
        //判断是否已经显示
        if (self.bottomCollectionView.isHidden) {
            self.bottomCollectionView.hidden = NO;
            
            self.stoptimeView.hidden = YES;
            //bottomCollectionView 为no
            if([[UserData getType] isEqualToString:@"in"])
                self.parktimeView.hidden = NO;
            else
                self.parktimeView.hidden = YES;
            
            [self.bottomCollectionView reloadData];
            //直接显示对应的item
            [self.bottomCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
        } else {
            //动画效果滚动到对应的item
            //            [self.bottomCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
            //            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
            if (index >=self.parkingList.count) {
                return;
            }
            //最新注释
            //            [self.bottomCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
        }
        
        //放大当前AnnotionView
        [self scaleCurrentAnnotationView:(CustomAnnotationView *)view];
        //规划路线
        CLLocationCoordinate2D destCoordinate = view.annotation.coordinate;
        [self addPolylineBy:destCoordinate];
        
    }
}

//放大当前annotion
- (void)scaleCurrentAnnotationView:(CustomAnnotationView *)view
{
    
    if (self.lastAnnotation != nil) {
        
        //缩小上一个pin
        [self becomeNormalAnimateWithView:self.lastAnnotation];
    }
    //放大当前pin
    self.lastAnnotation = (CustomAnnotationView *)view;
    [self becomeBiggerAnimateWithView:view];
    
}

//绘制规划路线
- (void)addPolylineBy:(CLLocationCoordinate2D)destCoordinate
{
    CLLocation *destLocation = [[CLLocation alloc] initWithLatitude:destCoordinate.latitude longitude:destCoordinate.longitude];
    COLWeakSelf(self)
    [[COLMapNavi sharedCOLMapNavi] startNaviWithStartPoint:_currentLocation endPoint:destLocation resultBlock:^(BOOL success, NSString *message, NSInteger routeLength, NSInteger routeTime, NSArray<AMapNaviPoint *> *routeCoordinates) {
        COLStrongSelf(self)
        
        int count = (int)[routeCoordinates count];
        //添加路径Polyline
        CLLocationCoordinate2D coords[count];
        
        for (int i = 0; i < count; i++)
        {
            AMapNaviPoint *coordinate = [routeCoordinates objectAtIndex:i];
            coords[i].latitude = [coordinate latitude];
            coords[i].longitude = [coordinate longitude];
        }
        //构造折线对象
        MAPolyline *commonPolyline = [MAPolyline polylineWithCoordinates:coords count:count];
        //在地图上添加折线对象
        [self.mapView removeOverlays:self.mapView.overlays];
        [self.mapView addOverlay:commonPolyline];
    }];
}

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay {
    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        
        polylineRenderer.lineWidth    = 4.f;
        polylineRenderer.strokeColor  = COL_COLOR_LIGHT_BLUE;
        polylineRenderer.lineJoinType = kMALineJoinRound;
        polylineRenderer.lineCapType  = kMALineCapRound;
        
        return polylineRenderer;
    }
    return nil;
}

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {
    if (updatingLocation) {
        _currentLocation = userLocation.location;
        
        //        [SVProgressHUD showImage:nil status:[[NSString alloc]initWithFormat:@"经度%lf,维度%lf",userLocation.location.coordinate.longitude,userLocation.location.coordinate.latitude]];
    }
}
//导航定位
- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    //获取中心店经纬度
    NSLog(@"%lf %lf", mapView.region.center.latitude, mapView.region.center.longitude);
    
    NSString *latitude = [NSString stringWithFormat:@"%lf", mapView.region.center.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%lf", mapView.region.center.longitude];
    self.location_new = [[NSDictionary alloc]initWithObjectsAndKeys:latitude,@"latitude",longitude,@"longitude", nil];
    if ([self.location_dic allKeys].count)
    {
        latitude = [NSString stringWithFormat:@"%@", self.location_dic[@"latitude"]];
        longitude = [NSString stringWithFormat:@"%@", self.location_dic[@"longitude"]];
        //        self.lastLatitude = 0;
    }
    
    
    if (!(mapView.region.center.latitude == self.lastLatitude && mapView.region.center.longitude == self.lastLongitude))
    {
        
        //        if (self.bottomCollectionView.isHidden) {
        [self.homePresenter getNearbyParkingListByLng:longitude lat:latitude];
        //        }
    }
    self.lastLatitude = mapView.region.center.latitude;
    self.lastLongitude = mapView.region.center.longitude;
}

#pragma mark - tools

//添加一个点
- (void)addPointInMapWithTitle:(NSString *)title
                      subTitle:(NSString *)subTitle
                      latitude:(CLLocationDegrees)latitude
                     longitude:(CLLocationDegrees)longitude
                         index:(NSInteger)index
                   colorNumber:(NSInteger)colorNumber {
    CustomPointAnnotation *pointAnnotation = [[CustomPointAnnotation alloc] init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    pointAnnotation.title = title;//价格
    pointAnnotation.subtitle = subTitle;//空位
    pointAnnotation.index = index;
    pointAnnotation.colorNumber = colorNumber;
    
    [self.annotationList addObject:pointAnnotation];;
    [_mapView addAnnotation:pointAnnotation];
}

//批量添加点


#pragma mark - HomePresenterDelegate

- (void)homeAddCollectionSuccess:(BOOL)success message:(NSString *)message {
    [COLToast showToast:message];
}

- (void)homeNearbyParkingListDidLoadedSuccess:(BOOL)success message:(NSString *)message nearbyParkingList:(NSArray<NearbyParkingModel *> *)parkingList {
    //清除地图上所有标注
    [_mapView removeAnnotations:_mapView.annotations];
    
    self.parkingList = [NSMutableArray arrayWithArray:parkingList];
    [self.annotationList removeAllObjects];
    
    NSInteger i = 0;
    for (NearbyParkingModel *parkingModel in parkingList) {
        NSInteger freePlace = parkingModel.carportIdle;
        NSInteger totalPlace = parkingModel.carportNum;
        
        NSString *price = parkingModel.jdprice;
        if (parkingModel.jdprice == nil || [parkingModel.jdprice length] <= 0) {
            price = @"0";
        }
        
        NSString *title = [NSString stringWithFormat:@"￥%@", price];//价格
        NSString *subtitle = [NSString stringWithFormat:@"空%ld", (long)freePlace];;//空位
        
        CUSPinAnnotationColor colorNumber = [CommonTools getColorByFree:freePlace total:totalPlace];
        
        [self addPointInMapWithTitle:title
                            subTitle:subtitle
                            latitude:[parkingModel.addressLatitude doubleValue]
                           longitude:[parkingModel.addressLongitude doubleValue]
                               index:i
                         colorNumber:colorNumber];
        i++;
    }
    
    int j = 0;
    for (NearbyParkingModel *parkingModel in parkingList) {
        if (parkingModel.best == 1) {
            break;
        }
        j ++;
    }
    
    if (self.annotationList && [self.annotationList count] > 0) {
        CustomPointAnnotation *annotation = (CustomPointAnnotation *)self.annotationList[j];
        [self.mapView selectAnnotation:annotation animated:YES];
    }
}

#pragma mark - 动画方法

-(void)becomeBiggerAnimateWithView:(UIView *)view
{
    [UIView animateWithDuration:0.2 animations:^{
        view.transform = CGAffineTransformMakeScale(1.3, 1.3); //放大
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            view.transform = CGAffineTransformMakeScale(1.0, 1.0); //缩小
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                view.transform = CGAffineTransformMakeScale(1.3, 1.3); //正常
            } completion:^(BOOL finished) {
                
            }];
        }];
    }];
}

-(void)becomeNormalAnimateWithView:(UIView *)view
{
    [UIView animateWithDuration:0.2 animations:^{
        view.transform = CGAffineTransformMakeScale(1.0, 1.0); //正常
    } completion:^(BOOL finished) {
    }];
}

- (StoptimeView *)stoptimeView
{
    _stoptimeView.frame =CGRectMake(0, DEVICE_HEIGHT- 50,DEVICE_WIDTH, 50);
    if (!_stoptimeView) {
        _stoptimeView =  [[[NSBundle mainBundle] loadNibNamed:@"StoptimeView" owner:self options:nil] lastObject];
        _stoptimeView.frame =CGRectMake(0, DEVICE_HEIGHT- 50,DEVICE_WIDTH, 50);
        COLWeakSelf(self);
        _stoptimeView.block = ^(NSInteger index)
        {
            weakself.stopInfodetailView.hidden = NO;
        };
    }
    return _stoptimeView;
}

- (StopInfodetailView*)stopInfodetailView
{
    if (!_stopInfodetailView) {
        _stopInfodetailView =  [[[NSBundle mainBundle] loadNibNamed:@"StopInfodetailView" owner:self options:nil] lastObject];
        _stopInfodetailView.frame =CGRectMake(0, DEVICE_HEIGHT- 370,DEVICE_WIDTH, 370);
        COLWeakSelf(self);
        _stopInfodetailView.block = ^(NSInteger index)
        {
            WaitingPayVC *control = [[WaitingPayVC alloc]initWithNibName:@"WaitingPayVC" bundle:nil];
            [weakself.navigationController pushViewController:control animated:YES];
        };
    }
    return _stopInfodetailView;
}

- (ParktimeView*)parktimeView
{
    if (!_parktimeView) {
        _parktimeView =  [[[NSBundle mainBundle] loadNibNamed:@"ParktimeView" owner:self options:nil] lastObject];
        _parktimeView.frame =CGRectMake(DEVICE_WIDTH -100, DEVICE_HEIGHT- 160,100, 40);
        
    }
    return _parktimeView;
}

- (void)requestGetnavigationrealtime{
    
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           [AccountService userModel].id,@"userID",
                           self.stopInfodetailView.time.text,@"str",
                           @"4c81a74e011cecad4262dba65c26960f",@"sign",
                           @"1504598086",@"ts",
                           @"ICETEST0-5F38-4A94-8F5F-78E38356557A",@"appID",
                           nil];
    NSLog(@"parm =%@",param);
    [JFHttpRequestTool getWithURL:@"https://ag.hfycloud.com/v1/navigation/realtime"  params:param success:^(id json) {
        if ([json[@"code"] intValue] == 0) {
            
            NSLog(@"json =%@",json);
            
        }else {
            //            [self showInfoWithMsg:json[@"message"]];
        }
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)requestGetnavigationleave{
    
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           [AccountService userModel].id,@"userID",
                           [UserData getIntime],@"tin",
                           @"4c81a74e011cecad4262dba65c26960f",@"sign",
                           @"1504598086",@"ts",
                           @"ICETEST0-5F38-4A94-8F5F-78E38356557A",@"appID",
                           nil];
    NSLog(@"parm =%@",param);
    [JFHttpRequestTool getWithURL:@"https://ag.hfycloud.com/v1/navigation/realtime"  params:param success:^(id json) {
        if ([json[@"code"] intValue] == 0) {
            
            NSLog(@"json =%@",json);
            
        }else {
            //            [self showInfoWithMsg:json[@"message"]];
        }
    } failure:^(NSError *error) {
        
    }];
    
}




@end

