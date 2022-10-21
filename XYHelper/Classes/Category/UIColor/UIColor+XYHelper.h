//
//  UIColor+XYHelper.h
//  XYHelper
//
//  Created by spikeroog on 2019/8/19.
//  Copyright © 2019年 spikeroog. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYHelperMarco.h"
#import "XYScreenAdapter.h"

NS_ASSUME_NONNULL_BEGIN

/**项目使用频率高的颜色*/
// 字体颜色
#define kColor333333 kColorWithRGB16Radix(0x333333)
#define kColor666666 kColorWithRGB16Radix(0x666666)
#define kColor999999 kColorWithRGB16Radix(0x999999)
#define kColorE8E8E8 kColorWithRGB16Radix(0xe8e8e8)
#define kColorBBBBBB kColorWithRGB16Radix(0xbbbbbb)


// 导航栏颜色
#define kWhiteStyleNavBgColor kColorWithRGB16Radix(0xffffff)
#define kBlackStyleNavBgColor kColorWithRGB16Radix(0x2d2d30)

// viewController tableView collectionView 背景颜色
#define kWhiteStyleViewControllerBgColor kColorWithRGB16Radix(0xf8f8f8)
#define kBlackStyleViewControllerBgColor kColorWithRGB16Radix(0x222225)

// cell分割线的颜色
#define kWhiteStyleCellSeparatorColor kColorWithRGB16Radix(0xe6e6e6)
#define kBlackStyleCellSeparatorColor kColorWithRGB16Radix(0x171719)


@interface UIColor (XYHelper)

/**
 获取textfield默认的placeholderColor
 
 @return placeholderColor
 */
+ (UIColor *)textfieldPlaceholderColor;

/**
 获取横向渐变颜色
 传入两个颜色
 
 @param beginColor 开始颜色
 @param endColor 终止颜色
 @return 渐变颜色
 */
+ (UIColor *)transitionColorWithColor:(UIColor *)beginColor
                          andEndColor:(UIColor *)endColor;

/**
 获取纵向渐变颜色
 传入两个颜色
 
 @param beginColor 开始颜色
 @param endColor 终止颜色
 @return 渐变颜色
 */
+ (UIColor *)transitionVerColorWithColor:(UIColor *)beginColor
                             andEndColor:(UIColor *)endColor;


@end

NS_ASSUME_NONNULL_END
