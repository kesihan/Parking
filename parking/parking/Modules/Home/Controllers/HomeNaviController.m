//
//  HomeNaviController.m
//  parking
//
//  Created by Robert Xu on 2017/6/9.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "HomeNaviController.h"
#import "COLMapNavi.h"
#import "SpeechSynthesizer.h"

@interface HomeNaviController () <UINavigationControllerDelegate, AMapNaviDriveManagerDelegate, AMapNaviDriveViewDelegate>

@property (strong, nonatomic) AMapNaviDriveManager *driveManager;
@property (weak, nonatomic) IBOutlet AMapNaviDriveView *driveView;
@property (weak, nonatomic) id delegate;

@end

@implementation HomeNaviController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setup];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 设置导航控制器的代理为self
    self.delegate = self.navigationController.delegate;
    self.navigationController.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // 设置导航控制器的代理为self
//    self.navigationController.delegate = nil;
    self.navigationController.delegate = self.delegate;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self startNaviWithStartPoint:_start endPoint:_end];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - UINavigationControllerDelegate
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}

#pragma mark - setup

- (void)setup {
    
    [self.driveView setDelegate:self];
    [self.driveView setShowMoreButton:NO];
    [self.driveManager addDataRepresentative:self.driveView];
}

#pragma mark - AMapNaviWalkViewDelegate

- (void)driveViewCloseButtonClicked:(AMapNaviDriveView *)driveView {
    //停止导航
    [self.driveManager stopNavi];
    [self.driveManager removeDataRepresentative:self.driveView];
    
    //停止语音
    [[SpeechSynthesizer sharedSpeechSynthesizer] stopSpeak];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)driveViewTrunIndicatorViewTapped:(AMapNaviDriveView *)driveView
{
    NSLog(@"TrunIndicatorViewTapped");
}

- (void)driveView:(AMapNaviDriveView *)driveView didChangeShowMode:(AMapNaviDriveViewShowMode)showMode
{
    NSLog(@"didChangeShowMode:%ld", (long)showMode);
}

#pragma mark - AMapNaviDriveManagerDelegate

- (void)driveManagerOnCalculateRouteSuccess:(AMapNaviDriveManager *)driveManager {
    //显示路径或开启导航
    [self.driveManager startGPSNavi];
}

- (void)driveManager:(AMapNaviDriveManager *)driveManager error:(NSError *)error
{
    NSLog(@"error:{%ld - %@}", (long)error.code, error.localizedDescription);
}

- (void)driveManager:(AMapNaviDriveManager *)driveManager onCalculateRouteFailure:(NSError *)error
{
    NSLog(@"onCalculateRouteFailure:{%ld - %@}", (long)error.code, error.localizedDescription);
}

- (void)driveManager:(AMapNaviDriveManager *)driveManager didStartNavi:(AMapNaviMode)naviMode
{
    NSLog(@"didStartNavi");
}

- (void)driveManager:(AMapNaviDriveManager *)driveManager onArrivedWayPoint:(int)wayPointIndex
{
    NSLog(@"onArrivedWayPoint:%d", wayPointIndex);
}

- (BOOL)driveManagerIsNaviSoundPlaying:(AMapNaviDriveManager *)driveManager
{
    return [[SpeechSynthesizer sharedSpeechSynthesizer] isSpeaking];
}

- (void)driveManager:(AMapNaviDriveManager *)driveManager playNaviSoundString:(NSString *)soundString soundStringType:(AMapNaviSoundType)soundStringType
{
    NSLog(@"playNaviSoundString:{%ld:%@}", (long)soundStringType, soundString);
    
    [[SpeechSynthesizer sharedSpeechSynthesizer] speakString:soundString];
}

- (void)driveManagerDidEndEmulatorNavi:(AMapNaviDriveManager *)driveManager
{
    NSLog(@"didEndEmulatorNavi");
}

- (void)driveManagerOnArrivedDestination:(AMapNaviDriveManager *)driveManager
{
    NSLog(@"onArrivedDestination");
}

#pragma mark - getter & setter

- (AMapNaviDriveManager *)driveManager {
    if (!_driveManager) {
        _driveManager = [COLMapNavi sharedCOLMapNavi].driveManager;
    }
    [_driveManager setPausesLocationUpdatesAutomatically:NO];
    [_driveManager setDelegate:self];
    return _driveManager;
}

#pragma mark - action

- (void)startNaviWithStartPoint:(CLLocation *)start endPoint:(CLLocation *)end {
    
    AMapNaviPoint *startPoint = [AMapNaviPoint locationWithLatitude:start.coordinate.latitude longitude:start.coordinate.longitude];
    AMapNaviPoint *endPoint = [AMapNaviPoint locationWithLatitude:end.coordinate.latitude longitude:end.coordinate.longitude];
    [self.driveManager calculateDriveRouteWithStartPoints:@[startPoint]
                                                endPoints:@[endPoint]
                                                wayPoints:nil
                                          drivingStrategy:AMapNaviDrivingStrategySingleDefault];
}


@end
