//
//  XYOperation.m
//  XYOperation
//
//  Created by spikeroog on 2020/8/21.
//  Copyright © 2020 spikeroog. All rights reserved.
//

#import "XYOperation.h"
#import "XYOperationQueue.h"

@interface XYOperation ()

@property (weak, nonatomic) id <XYOperationDelegate>delegate;
@property (strong, nonatomic) XYOperationBlock block;
@end

@implementation XYOperation

- (id)init {
    self = [super init];
    if (self) {
    } return self;
}

- (void)_main {
    if ([_delegate respondsToSelector:@selector(main:)]) {
        [_delegate main:self];
    }
    if (_block) {
        _block(self);
    }
}

- (void)complete {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [_queue performSelector:NSSelectorFromString(@"_operationDidComplete:") withObject:self];
#pragma clang diagnostic pop
}

@end


@implementation XYOperation (Block)

- (id)initWithBlock:(XYOperationBlock)block {
    self = [super init];
    if (self) {
        _block = block;
    } return self;
}

+ (id)operationWithBlock:(XYOperationBlock)block {
    return [[XYOperation alloc] initWithBlock:block];
}

@end


@implementation XYOperation (Delegate)

- (id)initWithDelegate:(id<XYOperationDelegate>)delegate {
    self = [super init];
    if (self) {
        _delegate = delegate;
    } return self;
}

+ (id)operationWithDelegate:(id<XYOperationDelegate>)delegate {
    return [[XYOperation alloc] initWithDelegate:delegate];
}

@end
