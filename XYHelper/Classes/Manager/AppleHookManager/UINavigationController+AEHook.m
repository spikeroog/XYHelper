//
//  UINavigationController+AEHook.m
//  syapp
//
//  Created by spikeroog on 2021/12/1.
//  Copyright © 2021 spikeroog. All rights reserved.
//

#import "UINavigationController+AEHook.h"
#import <objc/runtime.h>
#import "AppleHookDefine.h"

@implementation UINavigationController (AEHook)

+ (void)hookUINavigationController_push {
    Method pushMethod = class_getInstanceMethod([self class], @selector(pushViewController:animated:));
    Method hookMethod = class_getInstanceMethod([self class], @selector(hook_pushViewController:animated:));
    method_exchangeImplementations(pushMethod, hookMethod);
}

- (void)hook_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSString *popDetailInfo = [NSString stringWithFormat: @"%@ - %@ - %@", NSStringFromClass([self class]), @"push", NSStringFromClass([viewController class])];
    
    [[AppleHookDefine shareInstance].anitaAry addObject:[NSString stringWithFormat:@"\n请求时间：%@\n详细信息：%@\n", [AppleHookDefine getCurrentNetworkTime], popDetailInfo]];
    
    //    NSLog(@"%@", [NSString stringWithFormat:@"\n请求时间：%@\n详细信息：%@\n", [AppleHookDefine getCurrentNetworkTime], popDetailInfo]);
    
    [self hook_pushViewController:viewController animated:animated];
}

+ (void)hookUINavigationController_pop {
    Method popMethod = class_getInstanceMethod([self class], @selector(popViewControllerAnimated:));
    Method hookMethod = class_getInstanceMethod([self class], @selector(hook_popViewControllerAnimated:));
    method_exchangeImplementations(popMethod, hookMethod);
}

- (nullable UIViewController *)hook_popViewControllerAnimated:(BOOL)animated {
    NSString *popDetailInfo = [NSString stringWithFormat:@"%@ - %@", NSStringFromClass([self class]), @"pop"];
    
    [[AppleHookDefine shareInstance].anitaAry addObject:[NSString stringWithFormat:@"\n请求时间：%@\n详细信息：%@\n", [AppleHookDefine getCurrentNetworkTime], popDetailInfo]];
    
    //    NSLog(@"%@", [NSString stringWithFormat:@"\n请求时间：%@\n详细信息：%@\n", [AppleHookDefine getCurrentNetworkTime], popDetailInfo]);
    
    return [self hook_popViewControllerAnimated:animated];
}

@end
