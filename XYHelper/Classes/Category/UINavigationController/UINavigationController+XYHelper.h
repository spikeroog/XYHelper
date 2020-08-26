//
//  UINavigationController+XYHelper.h
//  XYHelper
//
//  Created by spikeroog on 2019/12/10.
//  Copyright © 2020 spikeroog. All rights reserved.
//  系统导航栏跳转添加pushViewController&popViewController的completion方法回调

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (XYHelper)

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated completion: (void (^)(void))completion;
- (UIViewController *)popViewControllerAnimated:(BOOL)animated completion: (void (^)(void))completion;
- (NSArray<__kindof UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated completion: (void (^)(void))completion;
- (NSArray<__kindof UIViewController *>* )popToRootViewControllerAnimated:(BOOL)animated completion:(void (^)(void))completion;

@end

NS_ASSUME_NONNULL_END
