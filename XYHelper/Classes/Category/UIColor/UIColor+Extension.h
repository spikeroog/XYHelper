//
//  UIColor+Extension.h
//  XYKit
//
//  Created by Xiao Yuen on 2019/8/19.
//  Copyright © 2019年 Xiao Yuen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYHelper.h"

NS_ASSUME_NONNULL_BEGIN

/**项目使用频率高的颜色*/

// 主题色 导航栏颜色
#define kMainColor kColorWithRGB(233, 123, 155)
// 字体颜色

#define UIColor333333 kColorWithRGB16Radix(0x333333)
#define UIColor666666 kColorWithRGB16Radix(0x666666)
#define UIColor999999 kColorWithRGB16Radix(0x999999)
// viewController tableView collectionView 背景颜色
#define UIColorTableViewBgColor kColorWithRGB16Radix(0xf5f5f5)
// cell分割线的颜色
#define UIColorCellSeparatorColor kColorWithRGB16Radix(0xE6E6E6)
// 导航栏渐变颜色
#define kLowOrangeColor UIColorWithRGB(239, 130, 62)
#define kHighOrangeColor UIColorWithRGB(237, 105, 57)
#define kGradientColors @[kLowOrangeColor, kHighOrangeColor]


@interface UIColor (Extension)

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

+ (UIColor *)customMainNavColor;

@end

NS_ASSUME_NONNULL_END
