//
//  CALayer+XYHelper.h
//  XYHelper
//
//  Created by spikeroog on 2019/8/19.
//  Copyright © 2019年 spikeroog. All rights reserved.
//  使xib中设置borderColor生效 eg: 在xib的User Defined Runtime Attributes的keyPath中设置layer.borderColorFromUIColor (Color) 即可生效

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CALayer (XYHelper)
- (void)setBorderColorFromUIColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
