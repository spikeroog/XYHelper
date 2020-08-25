//
//  NSObject+KVO.m
//  XYKit
//
//  Created by Xiao Yuen on 2018/12/18.
//  Copyright © 2018 Xiao Yuen. All rights reserved.
//

#import "NSObject+KVO.h"
#import <objc/runtime.h>

static const char listenedObjKVO;

@interface MGKVOTarget : NSObject

// block
@property (nonatomic, copy) MGKVOBlock block;

- (id)initWithBlock:(MGKVOBlock)block;

@end

@interface MGKVO : NSObject

// 被监听的对象
@property (strong, nonatomic) id listenedObj;
// {@"keipath"=>MGKVOTarget}
@property (strong, nonatomic) NSDictionary *keyPathPointBlocks;

+ (instancetype)KVOWithListenedObj:(id)listenedObj
                           keyPath:(NSString *)keyPath
                             block:(MGKVOBlock)block;

@end


@implementation MGKVOTarget

- (id)initWithBlock:(MGKVOBlock)block {
    self = [super init];
    if (self) {
        self.block = block;
    }
    return self;
}
@end

@implementation MGKVO

+ (instancetype)KVOWithListenedObj:(id)listenedObj
                           keyPath:(NSString *)keyPath
                             block:(MGKVOBlock)block {
    MGKVO *kvo = [[MGKVO alloc] init];
    kvo.listenedObj = listenedObj;
    
    MGKVOTarget *target = [[MGKVOTarget alloc] initWithBlock:block];
    NSMutableDictionary *tmp = [[NSMutableDictionary alloc] init];
    [tmp setObject:target forKey:keyPath];
    kvo.keyPathPointBlocks = [NSDictionary dictionaryWithDictionary:tmp];
    return kvo;
}

@end

#pragma mark - NSObject (KVO)

@implementation NSObject (KVO)

- (void)listenObj:(id)obj keyPath:(NSString *)path response:(MGKVOBlock)listenRepose{
    
    MGKVO *kvo = [self getKVOWithlistenedObj:obj];
    
    if (kvo) {
        // 已经添加的keypath不重复添加
        MGKVOTarget *target = [kvo.keyPathPointBlocks objectForKey:path];
        if (target) {
            return;
        }
    }
    
    if (!kvo) {
        kvo = [MGKVO KVOWithListenedObj:obj keyPath:path block:listenRepose];
    }
    
    // 将block添加到target中用于添加到dictionary
    MGKVOTarget *target = [[MGKVOTarget alloc] initWithBlock:listenRepose];
    
    NSMutableDictionary *tmp = [[NSMutableDictionary alloc] initWithDictionary:kvo.keyPathPointBlocks];
    [tmp setValue:target forKey:path];
    
    // 将keypath＝》target字典保存在KVO对象中
    kvo.keyPathPointBlocks = [NSDictionary dictionaryWithDictionary:tmp];
    
    // KVO保存到关联的数组中
    [self saveKVO:kvo];
    // 执行KVO
    [self executeKVOWithObj:obj keyPath:path];
}

- (void)unListenAll {
    
    NSArray *array = objc_getAssociatedObject(self, &listenedObjKVO);
    if (!array) {
        return;
    }
    for (MGKVO *kvo in array) {
        [self unListenObj:kvo.listenedObj keyPath:nil];
    }
}

- (void)unListenObj:(id)obj keyPath:(NSString *)keyPath{
    NSArray *array = objc_getAssociatedObject(self, &listenedObjKVO);
    if (!array) {
        return;
    }
    NSMutableArray *tmp = [NSMutableArray arrayWithArray:array];
    for (MGKVO *kvo in tmp) {
        if (kvo.listenedObj == obj) {
            
            NSMutableDictionary *tmpKeyPathPointBlocks = [NSMutableDictionary dictionaryWithDictionary:kvo.keyPathPointBlocks];
            
            if (keyPath) {
                // 从队列中删除target
                [tmpKeyPathPointBlocks removeObjectForKey:keyPath];
                // 删除keyPath的监听
                [kvo.listenedObj removeObserver:self forKeyPath:keyPath];
            } else {
                // keyPath==nil 移除所有这个对象监听
                NSArray *paths = [tmpKeyPathPointBlocks allKeys];
                for (NSString *path in paths) {
                    // 删除Path的监听
                    [kvo.listenedObj removeObserver:self forKeyPath:path];
                }
                // 从队列中删除所有target
                [tmpKeyPathPointBlocks removeAllObjects];
            }
            
            
            // 当对象没有keyPath被监听时删除KVO对象
            if (tmpKeyPathPointBlocks.count == 0) [tmp removeObject:kvo];
            
            break;
        }
    }
    
    // 当被清空时直接取消关联
    if (tmp.count==0) {
        objc_setAssociatedObject(self, &listenedObjKVO, nil, OBJC_ASSOCIATION_ASSIGN);
    } else {
        objc_setAssociatedObject(self, &listenedObjKVO, [NSArray arrayWithArray:tmp], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

#pragma mark - private

- (MGKVO *)getKVOWithlistenedObj:(id)obj{
    NSArray *array = objc_getAssociatedObject(self, &listenedObjKVO);
    if (!array) {
        array = [NSArray array];
        objc_setAssociatedObject(self, &listenedObjKVO, array, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return nil;
    }
    
    for (MGKVO *kvo in array) {
        if (kvo.listenedObj == obj) {
            return kvo;
        }
    }
    return nil;
}

- (void)saveKVO:(MGKVO *)kvo{
    NSArray *array = objc_getAssociatedObject(self, &listenedObjKVO);
    // 已经存在不需要重复添加
    if ([array containsObject:kvo]) {
        return;
    }
    
    NSMutableArray *tmp = [NSMutableArray arrayWithArray:array];
    [tmp addObject:kvo];
    array = [NSArray arrayWithArray:tmp];
    objc_setAssociatedObject(self, &listenedObjKVO, array, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}


#pragma mark - observer
// 开始监听
- (void)executeKVOWithObj:(id)obj keyPath:(NSString *)keyPath{
    [obj addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
}

// 监听返回
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    id new = [change objectForKey:@"new"];
    id old = [change objectForKey:@"old"];
    
    MGKVO *kvo = [self getKVOWithlistenedObj:object];
    MGKVOTarget *target = [kvo.keyPathPointBlocks objectForKey:keyPath];
    target.block(old, new);
    
}

@end
