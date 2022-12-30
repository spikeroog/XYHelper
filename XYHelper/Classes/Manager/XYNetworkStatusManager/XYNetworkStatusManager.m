//
//  XYNetworkStatusManager.m
//  XYHelper
//
//  Created by spikeroog on 2019/2/13.
//  Copyright © 2019 spikeroog. All rights reserved.
//

#import "XYNetworkStatusManager.h"

@implementation XYNetworkStatusManager

+ (instancetype) shareInstanced {
    static XYNetworkStatusManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[XYNetworkStatusManager alloc] init];
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
                handle(@"未知网络", PPNetworkStatusUnknown);
                break;
            case PPNetworkStatusNotReachable:    // 无网络
                handle(@"无网络", PPNetworkStatusNotReachable);
                break;
            case PPNetworkStatusReachableViaWWAN: // 手机网络
                handle(@"手机网络", PPNetworkStatusReachableViaWWAN);
                break;
            case PPNetworkStatusReachableViaWiFi: // WIFI
                handle(@"WIFI", PPNetworkStatusReachableViaWiFi);
                break;
        }
    }];

}

@end
