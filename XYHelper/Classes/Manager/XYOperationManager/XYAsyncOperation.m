//
//  XYAsyncOperation.m
//  XYHelper
//
//  Created by spikeroog on 2020/5/29.
//  Copyright © 2020 spikeroog. All rights reserved.
//

#import "XYAsyncOperation.h"

@implementation XYAsyncOperation
@synthesize finished = _finished;
@synthesize executing = _executing;

- (id)initWithDelegate:(id<XYAsyncOperationDelegate>)delegate {
    self = [super init];
    if (self) {
        _delegate = delegate;
    } return self;
}

- (id)initWithBlock:(void (^)(XYAsyncOperation * _Nonnull))block {
    self = [super init];
    if (self) {
        _asyncOperationDidStartBlock = block;
    } return self;
}

+ (XYAsyncOperation *)operationWithBlock:(void (^)(XYAsyncOperation * _Nonnull))block {
    return [[XYAsyncOperation alloc] initWithBlock:block];
}

- (void)start {
    if (self.cancelled) {
        [self finishOperation];
        return;
    }
    [self _setFinished:NO];
    [self _setExecuting:YES];
    
    if (_asyncOperationDidStartBlock) {
        _asyncOperationDidStartBlock(self);
    }
    if ([_delegate respondsToSelector:@selector(asyncOperationDidStart:)]) {
        [_delegate asyncOperationDidStart:self];
    }
}

- (void)finishOperation {
    [self _setFinished:YES];
    [self _setExecuting:NO];
}

- (void)_setFinished:(BOOL)finished {
    [self willChangeValueForKey:@"isFinished"];
    _finished = finished;
    [self didChangeValueForKey:@"isFinished"];
}

- (void)_setExecuting:(BOOL)executing {
    [self willChangeValueForKey:@"isExecuting"];
    _executing = executing;
    [self didChangeValueForKey:@"isExecuting"];
}

@end
