//
//  UINavigationController+XYNavigation.m
//  XYKit
//
//  Created by Xiao Yuen on 2019/12/10.
//  Copyright © 2020 Xiao Yuen. All rights reserved.
//

#import "UINavigationController+XYNavigation.h"

@implementation UINavigationController (XYNavigation)

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated completion: (void (^)(void))completion {
    [CATransaction setCompletionBlock:completion];
    [CATransaction begin];
    [self pushViewController:viewController animated:animated];
    [CATransaction commit];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated completion: (void (^)(void))completion {
    UIViewController *poppedViewController;
    [CATransaction setCompletionBlock:completion];
    [CATransaction begin];
    poppedViewController = [self popViewControllerAnimated:animated];
    [CATransaction commit];
    return poppedViewController;
}

- (NSArray<__kindof UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated completion: (void (^)(void))completion {
    NSArray<__kindof UIViewController *> *viewControllers;
    [CATransaction setCompletionBlock:completion];
    [CATransaction begin];
    viewControllers = [self popToViewController:viewController animated:animated];
    [CATransaction commit];
    return viewControllers;
}

- (NSArray<__kindof UIViewController *>* )popToRootViewControllerAnimated:(BOOL)animated completion:(void (^)(void))completion {
    NSArray<__kindof UIViewController *> *viewControllers;
    [CATransaction setCompletionBlock:completion];
    [CATransaction begin];
    viewControllers = [self popToRootViewControllerAnimated:animated];
    [CATransaction commit];
    return viewControllers;
}

@end
