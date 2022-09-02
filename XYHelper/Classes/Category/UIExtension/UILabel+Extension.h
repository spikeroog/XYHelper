//
//  UILabel+Extension.h
//  BiBiClick
//
//  Created by spikeroog on 2017/8/2.
//  Copyright © 2017年 spikeroog. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Extension)

/// 创建 UILabel
///
/// @param title     标题
/// @param color     标题颜色
/// @param fontSize  字体大小
///
/// @return UILabel(文本水平居中)
+ (instancetype)ui_labelWithTitle:(NSString *)title color:(UIColor *)color fontSize:(CGFloat)fontSize;

/// 创建 UILabel
///
/// @param title     标题
/// @param color     标题颜色
/// @param fontSize  字体大小
/// @param alignment 对齐方式
///
/// @return UILabel
+ (instancetype)ui_labelWithTitle:(NSString *)title color:(UIColor *)color fontSize:(CGFloat)fontSize alignment:(NSTextAlignment)alignment numberOfLine:(NSInteger)numberOfLine;

@end
