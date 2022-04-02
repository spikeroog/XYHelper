//
//  UIViewController+AEHook.m
//  syapp
//
//  Created by spikeroog on 2021/12/1.
//  Copyright © 2021 spikeroog. All rights reserved.
//

#import "UIViewController+AEHook.h"
#import <objc/runtime.h>
#import "AppleHookDefine.h"

@implementation UIViewController (AEHook)

+ (void)hookUIViewController {
    Method appearMethod = class_getInstanceMethod([self class], @selector(viewDidAppear:));
    Method hookMethod = class_getInstanceMethod([self class], @selector(hook_ViewDidAppear:));
    method_exchangeImplementations(appearMethod, hookMethod);
}

- (void)hook_ViewDidAppear:(BOOL)animated {
    NSString *appearDetailInfo = [NSString stringWithFormat:@" %@ - %@", NSStringFromClass([self class]), @"didAppear"];
    [[AppleHookDefine shareInstance].anitaAry addObject:[NSString stringWithFormat:@"\n请求时间：%@\n详细信息：%@\n", [AppleHookDefine getCurrentNetworkTime], appearDetailInfo]];
    //    NSLog(@"%@", [NSString stringWithFormat:@"\n请求时间：%@\n详细信息：%@\n", [AppleHookDefine getCurrentNetworkTime], appearDetailInfo]);
    
    [self hook_ViewDidAppear:animated];
}

@end
