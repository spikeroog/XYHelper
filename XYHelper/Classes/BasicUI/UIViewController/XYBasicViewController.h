//
//  XYBaseViewController.h
//  XYHelper
//
//  Created by Xiao Yuan on 2019/12/11.
//  Copyright © 2020 spikeroog. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^XYNavigationRightBarItemsHandle) (NSInteger idx);

@interface XYBasicViewController : UIViewController

/// 隐藏导航栏，默认NO
@property (nonatomic, assign) BOOL isHiddenNav;

/// 导航栏背景颜色
@property (nonatomic, strong) UIColor *navBgColor;
/// 导航栏背景图片
@property (nonatomic, copy) NSString *navBgImageStr;
/// 导航栏标题颜色
@property (nonatomic, strong) UIColor *navTitleColor;

/// 导航栏标题
@property (nonatomic, copy) NSString *navTitle;
/// 导航栏标题图片
@property (nonatomic, strong) UIImage *titleViewImage;

/// 左侧按钮文字
@property (nonatomic, copy) NSString *leftBarItemTitle;
/// 左侧按钮图片
@property (nonatomic, strong) UIImage *leftBarItemImage;

/// 左侧按钮自定义间距图片
@property (nonatomic, strong) UIImage *leftBarItemDistanceImage;

/// 右侧按钮文字
@property (nonatomic, copy) NSString *rightBarItemTitle;
/// 右侧按钮图片
@property (nonatomic, strong) UIImage *rightBarItemImage;

/// 导航栏多个右侧按钮的点击回调
@property (nonatomic, copy) XYNavigationRightBarItemsHandle rightItemsHandle;


/// 左侧按钮隐藏
- (void)leftBarItemHidden;
/// 单个右侧按钮隐藏
- (void)rightBarItemHidden;

/// 多个右侧按钮隐藏
/// @param itemsArray 导航栏右侧按钮数组
- (void)rightBarItemHiddenWithArray:(NSArray<NSNumber *> *)itemsArray;

/// 创建导航栏多个右侧按钮
/// @param titleArr 标题
/// @param imageArr 图片string
- (void)rigBarItemsWithTitleArr:(nullable NSArray *)titleArr
                       imageArr:(nullable NSArray *)imageArr;


/// 点击导航栏多个右侧按钮的回调
/// @param complete 回调
- (void)clickRigBarItemsHandle:(void(^)(NSInteger index))complete;


/// 导航栏左侧按钮点击
- (void)leftActionInController;
/// 导航栏右侧按钮点击
- (void)rightActionInController;

/// 设置leftBarItem圆角
- (void)setCornersLeftBarItem;
/// 设置rightBarItem圆角
- (void)setCornersRightBarItem;

#pragma mark - 单个界面设置是否禁用右滑手势
- (void)interactivePopDisabled:(BOOL)disabled;

@end

NS_ASSUME_NONNULL_END
