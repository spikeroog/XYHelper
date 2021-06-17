//
//  XYOperationQueue.h
//  XYOperation
//
//  Created by spikeroog on 2020/8/21.
//  Copyright © 2020 spikeroog. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYOperation.h"

NS_ASSUME_NONNULL_BEGIN

@interface XYOperationQueue : NSObject
@property (assign, nonatomic) NSInteger maxConcurrentOperationCount;
@property (strong, nonatomic, readonly) NSArray <XYOperation *>*operations;
@property (strong, nonatomic, readonly) NSArray <XYOperation *>*currentOprations;
- (void)addOperation:(XYOperation *)operation;
@end

NS_ASSUME_NONNULL_END
