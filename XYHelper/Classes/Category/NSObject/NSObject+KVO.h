//
//  NSObject+KVO.h
//  XYKit
//
//  Created by Xiao Yuen on 2018/12/18.
//  Copyright © 2018 Xiao Yuen. All rights reserved.
//

/*
 Usage:
 // 监听方法
 [self listenObj:[MGClient shareInstance] keyPath:@"loginUser" response:^(id oldValue, id newValue) {
 
 }];
 
 // 取消所有对象监听
 [self unListenAll];
 // 取消某个被监听对象的所有监听
 [self unListenObj:[MGClient shareInstance] keyPath:nil];
 // 取消某个对象的某个keypath监听
 [self unListenObj:[MGClient shareInstance] keyPath:@"loginUser"];
 */

#import <Foundation/Foundation.h>

typedef void(^MGKVOBlock)(id oldValue,id newValue);

@interface NSObject (KVO)

/**
 *  对象监听
 *
 *  @param obj          被监听的对象
 *  @param path         路径
 *  @param listenRepose 返回的block
 */
- (void)listenObj:(id)obj keyPath:(NSString *)path response:(MGKVOBlock)listenRepose;

/**
 *  取消监听
 *
 *  @param obj     被监听的对象
 *  @param keyPath 路径
 */
- (void)unListenObj:(id)obj keyPath:(NSString *)keyPath;

/**
 *  取消所有监听
 */
- (void)unListenAll;

@end
