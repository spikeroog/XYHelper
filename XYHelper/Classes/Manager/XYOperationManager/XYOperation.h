//
//  XYOperation.h
//  XYOperation
//
//  Created by spikeroog on 2020/8/21.
//  Copyright © 2020 spikeroog. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class XYOperationQueue;

@interface XYOperation : NSObject

@property (weak, nonatomic, readonly) XYOperationQueue *queue;
@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger priority;
- (void)complete;
@end

#pragma mark - block
typedef void (^XYOperationBlock)(XYOperation *operation);
@interface XYOperation (Block)
- (instancetype)initWithBlock:(XYOperationBlock)block;
+ (instancetype)operationWithBlock:(XYOperationBlock)block;
@end

#pragma mark - delegate
@protocol XYOperationDelegate <NSObject>
- (void)main:(XYOperation *)operation;
@end
@interface XYOperation (Delegate)
- (instancetype)initWithDelegate:(id<XYOperationDelegate>)delegate;
+ (instancetype)operationWithDelegate:(id<XYOperationDelegate>)delegate;
@end

NS_ASSUME_NONNULL_END
