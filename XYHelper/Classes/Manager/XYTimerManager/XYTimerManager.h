//
//  XYTimerManager.h
//  XYHelper
//
//  Created by spikeroog on 2020/3/30.
//  Copyright © 2020年 spikeroog. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class XYTimerManager;
@protocol XYTimerDelegate <NSObject>
@optional
- (void)timerUpdate:(XYTimerManager *)timer;
@end

@interface XYTimerManager : NSObject

+ (XYTimerManager *)timerWithTimeInterval:(NSTimeInterval)timeInterval delegate:(id<XYTimerDelegate>)delegate userInfo:(nullable id)userInfo repeats:(BOOL)repeats;
+ (XYTimerManager *)timerWithTimeInterval:(NSTimeInterval)timeInterval delegate:(id<XYTimerDelegate>)delegate userInfo:(nullable id)userInfo repeats:(BOOL)repeats runLoopMode:(NSRunLoopMode)runLoopMode;

@property (strong, nonatomic, readonly) NSTimer *timer;
@property (weak, nonatomic, readonly) id<XYTimerDelegate> delegate;

- (void)destroyTimer;

@end

NS_ASSUME_NONNULL_END
