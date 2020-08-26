//
//  UIControl+FixMultiClick.m
//  UIButtonSwizzling
//
//  Created by spikeroog on 2018/8/9.
//  Copyright © 2018年 spikeroog. All rights reserved.
//

#import "UIControl+FixMultiClick.h"
#import <objc/runtime.h>

@implementation UIControl (FixMultiClick)
+ (void)load{
    Method originalMethod = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    Method newMethod = class_getInstanceMethod(self, @selector(ms_sendAction:to:forEvent:));
    method_exchangeImplementations(originalMethod, newMethod);
}

- (void)setAcceptEventInterval:(NSTimeInterval)acceptEventInterval{
    objc_setAssociatedObject(self, @selector(acceptEventInterval), @(acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSTimeInterval)acceptEventInterval {
    NSTimeInterval interval = 0.2f;
    if(objc_getAssociatedObject(self, @selector(acceptEventInterval))){
        return [objc_getAssociatedObject(self, @selector(acceptEventInterval)) doubleValue];
    }
    return interval;
}

- (void)setAcceptEventTime:(NSTimeInterval)acceptEventTime{
    objc_setAssociatedObject(self, @selector(acceptEventTime), @(acceptEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSTimeInterval)acceptEventTime{
    return [objc_getAssociatedObject(self, @selector(acceptEventTime)) doubleValue];
}

- (void)ms_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    if(![self isKindOfClass:[UIButton class]]){
        [self ms_sendAction:action to:target forEvent:event];
        return;
    }
    //判定是否在间隔时间内
    if (([NSDate date].timeIntervalSince1970 - self.acceptEventTime) < self.acceptEventInterval) {
        return;
    }
    if(self.acceptEventInterval > 0){
        self.acceptEventTime = [NSDate date].timeIntervalSince1970;
    }
    [self ms_sendAction:action to:target forEvent:event];
}
@end
