//
//  UILabel+XYHelper.h
//  XYHelper
//
//  Created by spikeroog on 2018/12/3.
//  Copyright © 2018 spikeroog. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (XYHelper)

/**
 *  设置字间距
 */
- (void)yx_setColumnSpace:(CGFloat)columnSpace;

/**
 *  设置行距
 */
- (void)yx_setRowSpace:(CGFloat)rowSpace;

@end

NS_ASSUME_NONNULL_END
