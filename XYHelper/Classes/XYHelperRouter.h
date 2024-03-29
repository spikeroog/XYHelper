//
//  XYHelperRouter.h
//  XYHelper
//
//  Created by spikeroog on 2019/8/21.
//  Copyright © 2019年 spikeroog All rights reserved.
//  系统导航栏相关

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYHelperRouter : NSObject

#pragma mark - 导航栏颜色获取
+ (UIColor *)navBgColor;
#pragma mark - 导航栏字体颜色获取
+ (UIColor *)navTitleColor;
#pragma mark - 导航栏标题字体
+ (UIFont *)navTitleFont;
#pragma mark - 导航栏按钮字体
+ (UIFont *)navBarItemFont;
#pragma mark - 状态栏颜色获取, 0为黑色，1为白色
+ (NSInteger)statusBarStyle;

/** 获取当前显示的导航栏 */
+ (UINavigationController *)currentNavC;
/** 获取当前显示VC */
+ (UIViewController *)currentVC;
/** 获取最上层的window */
+ (UIWindow *)topLevelWindow;
/** 获取keyWindow */
+ (UIWindow *)fetchKeyWindow;
/** 通过view获取其显示的VC */
+ (UIViewController *)findBelongVCFormView:(UIView *)view;

#pragma mark - 跳转到某个类
+ (void)pushViewController:(__kindof UIViewController *)viewController;
+ (void)pushViewController:(__kindof UIViewController *)viewController completion:(void(^)())completion;

#pragma mark - 跳转到某个类(多次点击不会重复跳转，但这个类只会存在一个)
+ (void)pushViewControllerNoRepeat:(__kindof UIViewController *)viewController;

#pragma mark - 删除层级中的某个控制器
+ (void)deleteViewControllerWithName:(NSString *)viewControllerName;

#pragma mark - 返回上一级控制器
+ (void)popController;

#pragma mark - 返回根目录控制器
+ (void)popToRootController;

#pragma mark - 返回到某个可能存在的控制器，无法回滚到根目录控制器
+ (void)popToMaybeExistControllerWithName:(NSString *)viewControllerName;

@end

NS_ASSUME_NONNULL_END
