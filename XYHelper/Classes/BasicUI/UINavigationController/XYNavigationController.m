//
//  XYNavigationController.m
//  XYHelper
//
//  Created by spikeroog on 2019/12/10.
//  Copyright © 2020 spikeroog. All rights reserved.
//

#import "XYNavigationController.h"

@interface XYNavigationController ()
<UINavigationControllerDelegate,
UIGestureRecognizerDelegate>

@end

@implementation XYNavigationController

/**
 如果当前显示的是第一个子控制器，禁止掉[返回手势]
 未解决后果：第一个界面响应右滑卡顿，甚至视图错乱
 
 @param gestureRecognizer 手势
 @return 是否应该响应手势
 */
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    // 如果当前显示的是第一个子控制器,就应该禁止掉[返回手势]
    if (self.childViewControllers.count == 1) {
        return NO;
    } else {
        return self.childViewControllers.count > 1;
    }
}

#pragma mark - 重写push/pop方法
/**
 重写push方法，子页面隐藏tabBar
 
 @param viewController viewController description
 @param animated animated description
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 子界面隐藏tabBar
    if (self.viewControllers.count > 0) {
        [viewController setHidesBottomBarWhenPushed:YES];
    }
    [super pushViewController:viewController animated:animated];
}

/**
 重写pop方法
 
 @param animated animated description
 @return return value description
 */
- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    // 判断即将到栈底
    if (self.viewControllers.count == 0) {
        
    } else {
        
    }
    //  pop出栈
    return [super popViewControllerAnimated:animated];
}

// 当设置了 childViewControllerForStatusBarStyle 后，不会进入这里
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

// 以 topViewController 的 preferredStatusBarStyle 来设置 statusBarStyle
- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}

@end
