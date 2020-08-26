//
//  NetWorkStatusManager.m
//  XYHelper
//
//  Created by spikeroog on 2019/2/13.
//  Copyright © 2019 spikeroog. All rights reserved.
//

#import "NetWorkStatusManager.h"
// 判断手机网络状态
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

@implementation NetWorkStatusManager

+ (instancetype) shareInstanced {
    static NetWorkStatusManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[NetWorkStatusManager alloc] init];
    });
    return manager;
}

/**
 实时监听网络变化
 
 @param handle 返回变化后的网络状态
 */
- (void)addNetWorkStatusObserver:(void(^)(NSString *netWorkStatusStr, PPNetworkStatusType status))handle {
    // 实时获取网络状态,通过Block回调实时获取(此方法可多次调用)
    [PPNetworkHelper networkStatusWithBlock:^(PPNetworkStatusType status) {
        switch (status) {
            case PPNetworkStatusUnknown:         // 未知网络
                handle(@"Unknown", PPNetworkStatusUnknown);
                break;
            case PPNetworkStatusNotReachable:    // 无网络
                handle(@"NotReachable", PPNetworkStatusNotReachable);
                break;
            case PPNetworkStatusReachableViaWWAN: // 手机网络
                handle([NetWorkStatusManager fetchViaWWANType], PPNetworkStatusReachableViaWWAN);
                break;
            case PPNetworkStatusReachableViaWiFi: // WIFI
                handle(@"ViaWiFi", PPNetworkStatusReachableViaWiFi);
                break;
        }
    }];
}

/**
 获取手机网络类型
 */
+ (NSString *)fetchViaWWANType {
    
    // 默认未知网络
    NSString *netconnType = @"Unknown";
    
    // 获取手机网络类型
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    NSString *currentStatus = info.currentRadioAccessTechnology;
    
    if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyGPRS"]) {
        
        netconnType = @"GPRS";
        
    } else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyEdge"]) {
        
        netconnType = @"2.75G EDGE";
        
    } else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyWCDMA"]) {
        
        netconnType = @"3G";
        
    } else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSDPA"]) {
        
        netconnType = @"3.5G HSDPA";
        
    } else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSUPA"]) {
        
        netconnType = @"3.5G HSUPA";
        
    } else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMA1x"]) {
        
        netconnType = @"2G";
        
    } else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORev0"]) {
        
        netconnType = @"3G";
        
    } else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevA"]) {
        
        netconnType = @"3G";
        
    } else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevB"]) {
        
        netconnType = @"3G";
        
    } else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyeHRPD"]) {
        
        netconnType = @"HRPD";
        
    } else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyLTE"]) {
        
        netconnType = @"4G";
        
    }
    
    return netconnType;
}


@end
