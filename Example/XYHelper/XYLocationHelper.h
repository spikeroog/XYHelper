//
//  XYLocationHelper.h
//  XYHelper
//
//  Created by spikeroog on 2018/5/23.
//  Copyright © 2018年 spikeroog. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

extern NSNotificationName const kLocationHelperDidResponseNotification;

@interface XYLocationHelper : NSObject

+ (instancetype)sharedInstance;

/**
 * 请求位置
 * 定位不管是否成功都会发送kLocationHelperDidResponseNotification通知
 * 成功会通过location来记录获取到的位置，获取到位置后会自动结束定位
 */
- (void)start;
- (void)stop; // 结束定位

/**
 * 获取到的位置
 */
@property (strong, nonatomic, readonly) CLLocation *location;
@property (strong, nonatomic, readonly) CLPlacemark *placemark;

/**
 国家
 */
@property (strong, nonatomic) NSString *country;
/**
 省份
 */
@property (strong, nonatomic) NSString *province;
/**
 城市
 */
@property (strong, nonatomic) NSString *city;

@end
