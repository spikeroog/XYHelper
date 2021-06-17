//
//  XYAsyncOperation.h
//  XYHelper
//
//  Created by spikeroog on 2020/5/29.
//  Copyright © 2020 spikeroog. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class XYAsyncOperation;
@protocol XYAsyncOperationDelegate <NSObject>
/// 任务开始执行
- (void)asyncOperationDidStart:(XYAsyncOperation *)operation;
@end

@interface XYAsyncOperation : NSOperation

/// delegate
- (id)initWithDelegate:(id<XYAsyncOperationDelegate>)delegate;
@property (weak ,nonatomic ,readonly) id <XYAsyncOperationDelegate>delegate;

/// block
- (id)initWithBlock:(void(^)(XYAsyncOperation *operation))block;
+ (XYAsyncOperation *)operationWithBlock:(void(^)(XYAsyncOperation *operation))block;
@property (strong ,nonatomic ,readonly) void(^asyncOperationDidStartBlock)(XYAsyncOperation *);

/// 主动调用这个方法标记当前任务已结束
- (void)finishOperation;

@end

NS_ASSUME_NONNULL_END
