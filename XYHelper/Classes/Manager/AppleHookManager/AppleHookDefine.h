//
//  AppleHookDefine.h
//  syapp
//
//  Created by spikeroog on 2021/12/1.
//  Copyright © 2021 spikeroog. All rights reserved.
//  用户行为检测、记录、上传
/**
 didFinishLaunchingWithOptions添加：
 [UIApplication hookUIApplication];
 [UIViewController hookUIViewController];
 [UINavigationController hookUINavigationController_push];
 [UINavigationController hookUINavigationController_pop];
 
 applicationWillTerminate添加上传日志代码
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppleHookDefine : NSObject
@property (nonatomic, strong) NSMutableArray *anitaAry;

/// Get Network Time
+ (NSString *)getCurrentNetworkTime;
/// Get IP Address
+ (NSString *)getIPAddress;

+ (AppleHookDefine *)shareInstance;

@end

NS_ASSUME_NONNULL_END
