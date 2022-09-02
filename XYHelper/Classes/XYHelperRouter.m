//
//  XYHelperRouter.m
//  XYHelper
//
//  Created by spikeroog on 2019/8/21.
//  Copyright © 2019年 spikeroog All rights reserved.
//

#import "XYHelperRouter.h"
#import <HBDNavigationBar/HBDNavigationBar.h>
#import <HBDNavigationBar/HBDNavigationController.h>
#import <HBDNavigationBar/UIViewController+HBD.h>

#import "XYHelperMarco.h"
#import "XYScreenAdapter.h"
#import "UINavigationController+XYHelper.h"

@implementation XYHelperRouter

#pragma mark - 导航栏颜色获取
+ (UIColor *)navBgColor {
    return [XYHelperRouter currentVC].hbd_barTintColor;
}

#pragma mark - 获取当前Window试图
/** 获取当前显示的导航栏 */
+ (UINavigationController *)currentNavC {
    UIViewController *viewVC = kKeyWindow.rootViewController;
    UINavigationController *naVC;
    if ([viewVC isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabbar = (UITabBarController *)viewVC;
        naVC = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        if (naVC.presentedViewController) {
            while (naVC.presentedViewController) {
                naVC = (UINavigationController *)naVC.presentedViewController;
            }
        }
    } else if ([viewVC isKindOfClass:[UINavigationController class]]) {
        naVC  = (UINavigationController *)viewVC;
        if (naVC.presentedViewController) {
            while (naVC.presentedViewController) {
                naVC = (UINavigationController *)naVC.presentedViewController;
            }
        }
    } else if ([viewVC isKindOfClass:[UIViewController class]]) {
        if (viewVC.navigationController) {
            return viewVC.navigationController;
        }
        return  (UINavigationController *)viewVC;
    }
    return naVC;
}

/** 获取当前显示VC */
+ (UIViewController *)currentVC {
    UIViewController *currVC = nil;
    UIViewController *rootVC = kKeyWindow.rootViewController;
    if ([rootVC isKindOfClass:[UINavigationController class]] || [rootVC isKindOfClass:[UITabBarController class]]) {
        do {
            if ([rootVC isKindOfClass:[UINavigationController class]]) {
                UINavigationController *nav = (UINavigationController *)rootVC;
                UIViewController *vc = [nav.viewControllers lastObject];
                currVC = vc;
                rootVC = vc.presentedViewController;
                continue;
            } else if ([rootVC isKindOfClass:[UITabBarController class]]) {
                UITabBarController *tabVC = (UITabBarController *)rootVC;
                currVC = tabVC;
                rootVC = [tabVC.viewControllers objectAtIndex:tabVC.selectedIndex];
                continue;
            }
        } while (rootVC != nil);
        return currVC;
    } else {
        return rootVC;
    }
}

/** 获取最上层的window */
+ (UIWindow *)topLevelWindow {
    UIWindow *topWindow = kKeyWindow;
    for (UIWindow *window in [[UIApplication sharedApplication].windows  reverseObjectEnumerator]) {
        if ([window isEqual:topWindow]) {
            continue;
        }
        if (window.windowLevel > topWindow.windowLevel && window.hidden != YES ) {
            topWindow = window;
        }
    }
    return topWindow;
}

/** 获取keyWindow */
+ (UIWindow *)fetchKeyWindow {
    UIWindow * keyWindow = kKeyWindow;
    if(!keyWindow){
        keyWindow = [UIApplication sharedApplication].windows.firstObject;
    }
    return keyWindow;
}

/** 通过view获取其显示的VC */
+ (UIViewController *)findBelongVCFormView:(UIView *)view {
    UIResponder *responder = view;
    while ((responder = [responder nextResponder]))
        if ([responder isKindOfClass: [UIViewController class]]) {
            return (UIViewController *)responder;
        }
    return nil;
}

#pragma mark - 跳转到某个类

/**
 跳转到某个类
 跳转控制器建议传控制器对象，这样就不用再封装的方法里面设置控制器的属性
 @param viewController 控制器
 */
+ (void)pushViewController:(__kindof UIViewController *)viewController {
    // 防止因为点击多次而重复跳转同一个视图
    if ([[XYHelperRouter currentVC] isMemberOfClass:[viewController class]]) {
        return;
    }
    [[XYHelperRouter currentNavC] pushViewController:viewController animated:YES];
}

+ (void)pushViewController:(__kindof UIViewController *)viewController completion:(void(^)())completion {
    // 防止因为点击多次而重复跳转同一个视图
    if ([[XYHelperRouter currentVC] isMemberOfClass:[viewController class]]) {
        return;
    }
    
    [[XYHelperRouter currentNavC] pushViewController:viewController animated:YES completion:^{
        completion();
    }];
}

#pragma mark - 跳转到某个类(跳转的时候，如果这个类存在，就返回到这个类的位置)
+ (void)pushViewControllerNoRepeat:(__kindof UIViewController *)viewController {
    // 防止因为点击多次而重复跳转同一个视图
    if ([[XYHelperRouter currentVC] isMemberOfClass:[viewController class]]) {
        return;
    }
    /// 防止跳转界面时重复跳转，即界面a,b,c,d，我们希望界面d再跳转界面c的时候不会重复跳转，
    /// 而是返回到界面c
    NSArray *viewControllers = [XYHelperRouter currentNavC].viewControllers;
    for (UIViewController *controller in viewControllers) {
        if ([controller isKindOfClass:[viewController class]]) {
            [[XYHelperRouter currentNavC] popToViewController:controller animated:YES];
            return;
        }
    }
    [[XYHelperRouter currentNavC] pushViewController:viewController animated:YES];
}

#pragma mark - 删除层级中的某个控制器
/**
 删除层级中的某个控制器
 而删除或者返回某个控制器，建议传控制器名称，尽量不要直接传控制器，如：[vController new]，这样会额外开辟一份控制器的内存
 
 @param viewControllerName 控制器名称
 */
+ (void)deleteViewControllerWithName:(NSString *)viewControllerName {
    // 取得NavigationController下的viewController数组
    NSMutableArray <__kindof UIViewController *> *navArray = [[NSMutableArray alloc] initWithArray:[XYHelperRouter currentNavC].viewControllers];
    NSMutableArray <__kindof UIViewController *> *tmpArray = [NSMutableArray new];
    tmpArray = navArray.mutableCopy;
    // ios字典和数组forin遍历时不能执行removeobject操作，不然会crash掉，但是for循环可以。
    [navArray enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([NSStringFromClass([obj class]) isEqualToString:viewControllerName]) {
            [tmpArray removeObjectAtIndex:idx];
            kLog(@"删除控制器%@成功", viewControllerName);
        }
    }];
    
    navArray = tmpArray.mutableCopy;

    [[XYHelperRouter currentNavC] setViewControllers:navArray animated:YES];
}

#pragma mark - 返回上一级控制器
+ (void)popController {
    [[XYHelperRouter currentNavC] popViewControllerAnimated:YES];
}

#pragma mark - 返回根目录控制器
+ (void)popToRootController {
    [[XYHelperRouter currentNavC] popToRootViewControllerAnimated:YES];
}

#pragma mark - 返回到某个可能存在的控制器，带回调和不带回调，无法回滚到根目录控制器

/**
 返回到某个可能存在的控制器
 而删除或者返回某个控制器，建议传控制器名称，尽量不要直接传控制器，如：[vController new]，这样会额外开辟一份控制器的内存
 
 @param viewControllerName 控制器名称
 */
+ (void)popToMaybeExistControllerWithName:(NSString *)viewControllerName {
    for (UIViewController *controller in [XYHelperRouter currentNavC].viewControllers) {
        if ([NSStringFromClass([controller class]) isEqualToString:viewControllerName]) {
            // 包含该要查找的视图
            [[XYHelperRouter currentNavC] popToViewController:controller animated:YES];
            return;
        }
    }
    kLog(@"控制器%@是TabBar包含Controller或不存在或已被删除，无法回退", viewControllerName);
}

@end
