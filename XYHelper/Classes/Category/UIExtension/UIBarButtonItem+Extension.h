//
//  UIBarButtonItem+Extension.h
//  ChinaIdea
//
//  Created by spikeroog on 16/6/15.
//  Copyright © 2016年 spikeroog. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

/// 使用图像名称创建自定义视图的 UIBarButtonItem
///
/// @param title 按钮名称(可选)
/// @param imageName 图像名(可选)
/// @param target 监听对象
/// @param action 监听方法(可选)
///
/// @return UIBarButtonItem
+ (instancetype)ui_barButtonWithTitle:(NSString *)title imageName:(NSString *)imageName target:(id)target action:(SEL)action;

/**
 使用图像名称创建自定义视图的 UIBarButtonItem 为了适配iOS 11此button为宽度加了20
 
 @param title 按钮名称(可选)
 @param imageName 图像名(可选)
 @param target 监听对象
 @param action 监听方法(可选)
 @return UIBarButtonItem
 */
+ (instancetype)ui_barButtonCenterWithTitle:(NSString *)title imageName:(NSString *)imageName target:(id)target action:(SEL)action;

/**
 使用图像名称创建自定义视图的 UIBarButtonItem

 @param title 按钮名称(可选)
 @param titleColor 标题颜色
 @param imageName 图像名(可选)
 @param target 监听对象
 @param action 监听方法(可选)
 @return UIBarButtonItem
 */
+ (instancetype)ui_barButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor imageName:(NSString *)imageName target:(id)target action:(SEL)action;


@end
