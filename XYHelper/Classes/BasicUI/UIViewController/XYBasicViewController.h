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

#pragma mark - 隐藏导航栏
/// 隐藏导航栏，默认NO，此为假隐藏，但是导航栏的高度还在
@property (nonatomic, assign) BOOL navBarHidden;

/// 隐藏导航栏 默认NO，此为真隐藏，导航栏高度将消失，适用于pageView模块的"真"隐藏导航栏
@property (nonatomic, assign) BOOL xy_NavHiddenForReal;

#pragma mark - 导航栏字体颜色，字体大小
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

/// 导航栏标题字体
@property (nonatomic, strong) UIFont *navItemTitleFont;
/// 导航栏按钮字体
@property (nonatomic, strong) UIFont *barItemTextFont;


#pragma mark - 状态栏相关
/// 隐藏状态栏
@property(nonatomic,assign) BOOL statusBarHiden;
/// 状态栏样式 状态栏颜色，0为黑色，1为白色
@property(nonatomic,assign) UIStatusBarStyle barStyle;

#pragma mark - 导航栏右侧多个按钮样式
/// 导航栏多个右侧按钮的点击回调
@property (nonatomic, copy) XYNavigationRightBarItemsHandle rightItemsHandle;

#pragma mark - 导航栏背景透明、背景毛玻璃
/// 设置导航栏背景透明
- (void)navBarAlphaZero;
/// 设置导航栏背景透明度,0-1
- (void)navBarAlphaWithValue:(CGFloat)value;

/// 设置导航栏背景毛玻璃效果，建议传入0.75-0.8左右的值
- (void)navVisualEffectWithValue:(CGFloat)value
                   originalColor:(UIColor *)originalColor;

#pragma mark - 导航栏左侧按钮、右侧按钮的显示与隐藏、圆角、点击回调
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

#pragma mark - 开发相关
- (void)setUpUi;
- (void)setUpNetwork;

@end

NS_ASSUME_NONNULL_END
