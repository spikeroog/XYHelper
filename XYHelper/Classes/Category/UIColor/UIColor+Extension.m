//
//  UIColor+Extension.m
//  XYKit
//
//  Created by Xiao Yuen on 2019/8/19.
//  Copyright © 2019年 Xiao Yuen. All rights reserved.
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)

/**
 获取textfield默认的placeholderColor
 
 @return placeholderColor
 */
+ (UIColor *)textfieldPlaceholderColor {
    static UIColor *color = nil;
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
       color = [UIColor colorWithRed:0 green:0 blue:0.098039215686274508 alpha:0.22];
    });
    return color;
}

/**
 获取横向渐变颜色
 传入两个颜色
 
 @param beginColor 开始颜色
 @param endColor 终止颜色
 @return 渐变颜色
 */
+ (UIColor *)transitionColorWithColor:(UIColor *)beginColor
                          andEndColor:(UIColor *)endColor {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
    //横向渐变的路径
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)beginColor.CGColor, (__bridge id)endColor.CGColor];//这里颜色渐变
    gradientLayer.locations = @[@0.0, @1.0];//颜色位置
    gradientLayer.startPoint = CGPointMake(0.0, 0.0);
    gradientLayer.endPoint = CGPointMake(1.0, 0.0);
    gradientLayer.frame = view.bounds;
    [view.layer addSublayer:gradientLayer];
    [view.layer insertSublayer:gradientLayer atIndex:0];
    
    UIImage *img = [UIImage xy_convertViewToImage:view];
    return kColorWithImage(img);
}

/**
 获取纵向渐变颜色
 传入两个颜色
 
 @param beginColor 开始颜色
 @param endColor 终止颜色
 @return 渐变颜色
 */
+ (UIColor *)transitionVerColorWithColor:(UIColor *)beginColor
                          andEndColor:(UIColor *)endColor {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
    //横向渐变的路径
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)beginColor.CGColor, (__bridge id)endColor.CGColor];//这里颜色渐变
    gradientLayer.locations = @[@0.0, @1.0];//颜色位置
    gradientLayer.startPoint = CGPointMake(0.0, 0.0);
    gradientLayer.endPoint = CGPointMake(0.0, 1.0);
    gradientLayer.frame = view.bounds;
    [view.layer addSublayer:gradientLayer];
    [view.layer insertSublayer:gradientLayer atIndex:0];
    
    UIImage *img = [UIImage xy_convertViewToImage:view];
    return kColorWithImage(img);
}

+ (UIColor *)customMainNavColor {
    // 设置导航栏背景颜色，将图片设置为高度为1，可提高精确度
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
    imageV.image = kImageWithName(@"");
    imageV.contentMode = UIViewContentModeScaleAspectFill;
    UIImage *img = [UIImage xy_convertViewToImage:imageV];
    return kColorWithImage(img);
}

@end
