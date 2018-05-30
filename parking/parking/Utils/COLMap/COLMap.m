//
//  COLMap.m
//  parking
//
//  Created by Robert Xu on 2017/6/8.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import "COLMap.h"

#define DefaultLocationTimeout  6
#define DefaultReGeocodeTimeout 3

@interface COLMap () <AMapLocationManagerDelegate>

@property (strong, nonatomic) AMapLocationManager *locationManager;
@property (copy, nonatomic) AMapLocatingCompletionBlock completionBlock;

@end

@implementation COLMap

COLSingletonM(COLMap)

- (void)configureSingleLoc {
    
    self.locationManager = [[AMapLocationManager alloc] init];
    [self.locationManager setDelegate:self];
    //设置期望定位精度
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    //设置不允许系统暂停定位
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    //设置允许在后台定位
    [self.locationManager setAllowsBackgroundLocationUpdates:NO];
    //设置定位超时时间
    [self.locationManager setLocationTimeout:DefaultLocationTimeout];
    //设置逆地理超时时间
    [self.locationManager setReGeocodeTimeout:DefaultReGeocodeTimeout];
    //设置开启虚拟定位风险监测，可以根据需要开启
    [self.locationManager setDetectRiskOfFakeLocation:NO];
}

- (void)startSingleLocWithReGeocode:(BOOL)willReGeocode CompletionBlock:(COLMapCompletionBlock)completion
{
    self.completionBlock = ^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error)
    {
        if (error != nil && error.code == AMapLocationErrorLocateFailed)
        {
            //定位错误：此时location和regeocode没有返回值，不进行annotation的添加
            NSLog(@"定位错误:{%ld - %@};", (long)error.code, error.localizedDescription);
            return;
        }
        else if (error != nil
                 && (error.code == AMapLocationErrorReGeocodeFailed
                     || error.code == AMapLocationErrorTimeOut
                     || error.code == AMapLocationErrorCannotFindHost
                     || error.code == AMapLocationErrorBadURL
                     || error.code == AMapLocationErrorNotConnectedToInternet
                     || error.code == AMapLocationErrorCannotConnectToHost))
        {
            //逆地理错误：在带逆地理的单次定位中，逆地理过程可能发生错误，此时location有返回值，regeocode无返回值，进行annotation的添加
            NSLog(@"逆地理错误:{%ld - %@};", (long)error.code, error.localizedDescription);
        }
        else if (error != nil && error.code == AMapLocationErrorRiskOfFakeLocation)
        {
            //存在虚拟定位的风险：此时location和regeocode没有返回值，不进行annotation的添加
            NSLog(@"存在虚拟定位的风险:{%ld - %@};", (long)error.code, error.localizedDescription);
            return;
        }
        else
        {
            //没有错误：location有返回值，regeocode是否有返回值取决于是否进行逆地理操作，进行annotation的添加
            completion(location, regeocode, error);
        }
    };
    //进行单次定位请求
    [self.locationManager requestLocationWithReGeocode:willReGeocode completionBlock:self.completionBlock];
}

- (void)stop {
    //停止定位
    [self.locationManager stopUpdatingLocation];
    [self.locationManager setDelegate:nil];
}

- (void)dealloc {
    [_locationManager stopUpdatingLocation];
    [_locationManager setDelegate:nil];
    _completionBlock = nil;
}

@end
