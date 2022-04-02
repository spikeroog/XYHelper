//
//  UIApplication+AEHook.m
//  syapp
//
//  Created by spikeroog on 2021/12/1.
//  Copyright © 2021 spikeroog. All rights reserved.
//

#import "UIApplication+AEHook.h"
#import <objc/runtime.h>
#import "AppleHookDefine.h"

@implementation UIApplication (AEHook)

+ (void)hookUIApplication {
    Method controlMethod = class_getInstanceMethod([UIApplication class], @selector(sendAction:to:from:forEvent:));
    Method hookMethod = class_getInstanceMethod([self class], @selector(hook_sendAction:to:from:forEvent:));
    method_exchangeImplementations(controlMethod, hookMethod);
}

- (BOOL)hook_sendAction:(SEL)action to:(nullable id)target from:(nullable id)sender forEvent:(nullable UIEvent *)event {
    NSString *actionDetailInfo = [NSString stringWithFormat:@" %@ - %@ - %@", NSStringFromClass([target class]), NSStringFromClass([sender class]), NSStringFromSelector(action)];
    
    [[AppleHookDefine shareInstance].anitaAry addObject:[NSString stringWithFormat:@"\n请求时间：%@\n详细信息：%@\n", [AppleHookDefine getCurrentNetworkTime], actionDetailInfo]];
    
    //    NSLog(@"%@", [NSString stringWithFormat:@"\n请求时间：%@\n详细信息：%@\n", [AppleHookDefine getCurrentNetworkTime], actionDetailInfo]);
    return [self hook_sendAction:action to:target from:sender forEvent:event];
}

@end
