//
//  XYTimerManager.m
//  XYHelper
//
//  Created by spikeroog on 2020/3/30.
//  Copyright © 2020年 spikeroog. All rights reserved.
//

#import "XYTimerManager.h"

@interface XYTimerTarget : NSObject
@property (assign, nonatomic) SEL selector;
@property (strong, nonatomic) dispatch_block_t timerRunBlock;
@end

@implementation XYTimerTarget

- (id)init {
    self = [super init];
    if (self) {
        _selector = @selector(update:);
    } return self;
}

- (void)update:(NSTimer *)timer {
    if (_timerRunBlock) {
        _timerRunBlock();
    }
}

- (void)dealloc {
}

@end

@interface XYTimerManager ()
@property (strong ,nonatomic) XYTimerTarget *timerTarget;
@end

@implementation XYTimerManager

+ (XYTimerManager *)timerWithTimeInterval:(NSTimeInterval)timeInterval delegate:(id<XYTimerDelegate>)delegate userInfo:(id)userInfo repeats:(BOOL)repeats {
    return [XYTimerManager timerWithTimeInterval:timeInterval delegate:delegate userInfo:userInfo repeats:repeats runLoopMode:NSRunLoopCommonModes];
}

+ (XYTimerManager *)timerWithTimeInterval:(NSTimeInterval)timeInterval delegate:(id<XYTimerDelegate>)delegate userInfo:(id)userInfo repeats:(BOOL)repeats runLoopMode:(NSRunLoopMode)runLoopMode {
    XYTimerManager *result = [[XYTimerManager alloc] initWithTimeInterval:timeInterval delegate:delegate userInfo:userInfo repeats:repeats runLoopMode:runLoopMode];
    return result;
}

- (id)initWithTimeInterval:(NSTimeInterval)timeInterval delegate:(id<XYTimerDelegate>)delegate userInfo:(nullable id)userInfo repeats:(BOOL)repeats runLoopMode:(NSRunLoopMode)runLoopMode {
    self = [super init];
    if (self) {
        _delegate = delegate;
        
        __weak typeof(self) _self = self;
        _timerTarget = [[XYTimerTarget alloc] init];
        [_timerTarget setTimerRunBlock:^{
            [_self timerRun];
        }];
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:_timerTarget selector:_timerTarget.selector userInfo:userInfo repeats:repeats];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:runLoopMode];
    } return self;
}

- (void)timerRun {
    if ([_delegate respondsToSelector:@selector(timerUpdate:)]) {
        [_delegate timerUpdate:self];
    }
}

- (void)dealloc {
    _delegate = nil;
    [_timer invalidate];
    _timer = nil;
    _timerTarget = nil;
}

- (void)destroyTimer {
    _delegate = nil;
    [_timer invalidate];
    _timer = nil;
    _timerTarget = nil;
}

@end
