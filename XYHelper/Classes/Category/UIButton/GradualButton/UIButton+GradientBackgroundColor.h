//
//  UIButton+GradientBackgroundColor.h
//  XYHelper
//
//  Created by spikeroog on 2020/3/14.
//  Copyright © 2020 spikeroog. All rights reserved.
//  两侧向中间的渐变颜色

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (GradientBackgroundColor)

/// 两侧向中间的渐变颜色
- (void)gradientBackgroundColor:(NSArray <UIColor *>*)colors;

@end

NS_ASSUME_NONNULL_END
