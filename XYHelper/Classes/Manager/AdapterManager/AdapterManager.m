//
//  AdapterManager.m
//  XYHelper
//
//  Created by spikeroog on 2018/11/30.
//  Copyright © 2018 spikeroog. All rights reserved.
//  控制器打印dealloc信息

#import "AdapterManager.h"
#import <Aspects/Aspects.h>
#import "XYKitMarco.h"

@implementation AdapterManager

+ (void)load {
    /* + (void)load 会在应用启动的时候自动被runtime调用，通过重载这个方法来实现最小的对业务方的“代码入侵” */
    [super load];
    [AdapterManager sharedInstance];
}

/*
 按道理来说，这个sharedInstance单例方法是可以放在头文件的，但是对于目前这个应用来说，暂时还没有放出去的必要
 当业务方对这个单例产生配置需求的时候，就可以把这个函数放出去
 */
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static AdapterManager *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[AdapterManager alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        @weakify(self);
        // xocde11.1会闪退，暂时注释等作者更新版本
        [UIViewController aspect_hookSelector:NSSelectorFromString(@"dealloc")
                                  withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> info) {
                                      [self dealloc:[info instance]];
                                  }
                                        error:NULL];
        
    }
    return self;
}

- (void)dealloc:(UIViewController *)viewController {
    /*
     你可以使用这个方法进行打日志，初始化基础业务相关的内容
     去掉RTNavigationController包含的多余的打印信息
     在这里去除你不想打印的控制器
     */
//    if ([viewController isKindOfClass:[RTContainerController class]] || [viewController isKindOfClass:[RTContainerNavigationController class]]) {
//        return ;
//    }
    kLog(@"[(控制器)%@ dealloc(释放)]", [viewController class]);
}

@end
