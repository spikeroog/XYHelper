//
//  XYLocationHelper.m
//  XYHelper
//
//  Created by spikeroog on 2018/5/23.
//  Copyright © 2018年 spikeroog. All rights reserved.
//

#import "XYLocationHelper.h"
#import <CoreLocation/CoreLocation.h>

NSNotificationName const kLocationHelperDidResponseNotification = @"kLocationHelperDidResponseNotification_xy";

@interface XYLocationHelper () <CLLocationManagerDelegate>
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (assign, nonatomic) NSInteger locationCounter; // stop清0

@end

@implementation XYLocationHelper

+ (instancetype)sharedInstance; {
    static XYLocationHelper *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[XYLocationHelper alloc] init];
    });
    return instance;
}

- (id)init {
    self = [super init];
    if (self) {
        _locationManager = [[CLLocationManager alloc] init];
        [_locationManager requestWhenInUseAuthorization];
        _locationManager.delegate = self;
        _location = nil;
    } return self;
}


- (void)start {
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    BOOL authorized = (status == kCLAuthorizationStatusAuthorizedWhenInUse);
    if (authorized) {
        _locationCounter = 0;
        [_locationManager startUpdatingLocation];
    } else if (status != kCLAuthorizationStatusNotDetermined) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kLocationHelperDidResponseNotification object:@(0)];
        
        // 提醒用户开启定位权限
        [self remindAuth];
    }
}

- (void)stop {
    [_locationManager stopUpdatingLocation];
    _locationCounter = 0;
#if DEBUG
    kLog(@"已停止定位");
#endif
}

- (void)remindAuth {
#if DEBUG
    kLog(@"定位功能不可用");
    [MBProgressHUD showTextHUD:@"定位功能不可用"];
#endif
}

#pragma mark - location
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations {
    if (locations.count > 0) {
        _locationCounter ++;
        _location = locations.firstObject;
#if DEBUG
        kLog(@"当前定位%@次 位置信息:%@" ,@(_locationCounter) ,_location);
#endif
        if (_locationCounter == 1) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kLocationHelperDidResponseNotification object:@(1)];
        }
        if (_locationCounter >= 3) {
            [self stop];
        }
    }
    
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    // 根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:locations.firstObject completionHandler:^(NSArray *array, NSError *error){
        if (array.count > 0){
            CLPlacemark *placemark = [array objectAtIndex:0];
            // 获取当前城市
            self.city = placemark.locality;
            self.country = placemark.country;
            self.province = placemark.administrativeArea;
        }
        else if (error == nil && [array count] == 0) {
            kLog(@"没有结果返回.");
        }
        else if (error != nil)  {
            // kLog(@"An error occurred = %@", error);
        }
    }];
    
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error; {
#if DEBUG
    kLog(@"定位失败 :%@" ,error);
#endif
    [[NSNotificationCenter defaultCenter] postNotificationName:kLocationHelperDidResponseNotification object:@(0)];
    [self stop];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status != kCLAuthorizationStatusNotDetermined) {
        [self start];
    }
}

@end
