//
//  XYAppDelegateManager.h
//  XYHelper
//
//  Created by spikeroog on 2020/8/27.
//  以下方法请在AppDelete中的DidFinishLaunch中调用

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYAppDelegateManager : NSObject

/// 全局基础配置
+ (void)appGlobalSet;

/// 实时监听网络状态
+ (void)netWorkStatusObserver;
@end

NS_ASSUME_NONNULL_END
