//
//  XYAppDelegateManager.m
//  XYHelper
//
//  Created by spikeroog on 2020/8/27.
//  

#import "XYAppDelegateManager.h"
#import "XYNetworkStatusManager.h"
#import "XYHelperMarco.h"
#import "XYScreenAdapter.h"
#import <IQKeyboardManager/IQKeyboardManager.h>

@implementation XYAppDelegateManager

/// 全局基础配置
+ (void)appGlobalSet {
    
#pragma mark - UITableView分组高度默认增加22个像素的高度，导致所有的UI显示异常
    if (@available(iOS 15.0, *)) {
        [UITableView appearance].sectionHeaderTopPadding = 0;
    }
    
#pragma mark - 强制关闭暗黑模式
#if defined(__IPHONE_13_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0
    if (@available(iOS 13.0, *)) {
        kAppDelegate.window.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
    }
#endif
    
#pragma mark - 防止多个button同时点击
    // 避免在一个界面上同时点击多个UIButton导致同时响应多个方法
    [[UIButton appearance] setExclusiveTouch:YES];
    
#pragma mark - 设置网络请求超时时间为5秒
    [PPNetworkHelper setRequestTimeoutInterval:5];

#pragma mark - 配置IQKeyboardManager
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    // enable控制整个功能是否启用
    manager.enable = YES;
    // shouldResignOnTouchOutside控制点击背景是否收起键盘
    manager.shouldResignOnTouchOutside = YES;
    // shouldToolbarUsesTextFieldTintColor 控制键盘上的工具条文字颜色是否用户自定义
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    // enableAutoToolbar控制是否显示键盘上的工具条
    manager.enableAutoToolbar = NO;
    
}

/// 实时监听网络状态
+ (void)netWorkStatusObserver:(void(^)(NSString *netWorkStatusStr, PPNetworkStatusType statusType))complete {
    [[XYNetworkStatusManager shareInstanced] addNetWorkStatusObserver:^(NSString * _Nonnull netWorkStatusStr, PPNetworkStatusType status) {
        kLog(@"\n====检测到网络环境变化，当前网络环境为：%@", netWorkStatusStr);
        complete(netWorkStatusStr, status);
    }];
}

@end
