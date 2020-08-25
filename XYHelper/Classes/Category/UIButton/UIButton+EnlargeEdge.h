//
//  UIButton+EnlargeEdge.h
//  XYKit
//
//  Created by Xiao Yuen on 2018/11/27.
//  Copyright © 2018 Xiao Yuen. All rights reserved.
//  扩大button的点击范围

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (EnlargeEdge)

/** 设置可点击范围到按钮边缘的距离 */
- (void)setEnlargeEdge:(CGFloat)size;

/** 设置可点击范围到按钮上、右、下、左的距离 */
- (void)setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left;

@end

NS_ASSUME_NONNULL_END
