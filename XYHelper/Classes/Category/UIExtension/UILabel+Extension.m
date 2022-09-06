//
//  UILabel+Extension.h
//  BiBiClick
//
//  Created by spikeroog on 2017/8/2.
//  Copyright © 2017年 spikeroog. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)

/// 创建 UILabel
///
/// @param title     标题
/// @param color     标题颜色
/// @param font  字体
///
/// @return UILabel(文本水平居中)
+ (instancetype)ui_labelWithTitle:(NSString *)title color:(UIColor *)color font:(UIFont *)font {
    return [self ui_labelWithTitle:title color:color font:font alignment:NSTextAlignmentCenter numberOfLine:0];
}

/// 创建 UILabel
///
/// @param title     标题
/// @param color     标题颜色
/// @param font  字体
/// @param alignment 对齐方式
///
/// @return UILabel
+ (instancetype)ui_labelWithTitle:(NSString *)title color:(UIColor *)color font:(UIFont *)font alignment:(NSTextAlignment)alignment numberOfLine:(NSInteger)numberOfLine {
    
    UILabel *label = [[UILabel alloc] init];
    
    label.text = title;
    label.textColor = color;
    label.font = font;
    label.numberOfLines = numberOfLine;
    label.textAlignment = alignment;
    
    [label sizeToFit];
    
    return label;
}

@end
