//
//  XYOperationQueue.m
//  XYOperation
//
//  Created by spikeroog on 2020/8/21.
//  Copyright © 2020 spikeroog. All rights reserved.
//

#import "XYOperationQueue.h"

@interface XYOperationQueue ()

@property (strong, nonatomic, readwrite) NSMutableArray <XYOperation *>*operations; // 保存所有待执行的任务
@property (strong, nonatomic, readwrite) NSMutableArray <XYOperation *>*currentOprations; // 正在执行的任务
@end

@implementation XYOperationQueue

- (id)init {
    self = [super init];
    if (self) {
        _maxConcurrentOperationCount = 1;
        _operations = [NSMutableArray array];
        _currentOprations = [NSMutableArray array];
    } return self;
}

- (void)addOperation:(XYOperation *)operation {
    if (operation) {
        [operation setValue:self forKey:@"queue"];
        [_operations addObject:operation];
        [_operations sortUsingComparator:^NSComparisonResult(XYOperation *obj1, XYOperation *obj2) {
            return [@(obj2.priority) compare:@(obj1.priority)];
        }];
    }
    [self _run];
}

- (void)_operationDidComplete:(XYOperation *)operation {
    [_currentOprations removeObject:operation];
    [self _run];
}

- (void)_run {
    while ((_currentOprations.count < _maxConcurrentOperationCount) && (_operations.count > 0)) {
        XYOperation *op = _operations.firstObject;
        [_operations removeObject:op];
        [_currentOprations addObject:op];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [op performSelector:NSSelectorFromString(@"_main")];
#pragma clang diagnostic pop
    }
}

@end
