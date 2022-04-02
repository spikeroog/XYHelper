//
//  CALayer+XYHelper.m
//  XYHelper
//
//  Created by spikeroog on 2019/8/19.
//  Copyright © 2019年 spikeroog. All rights reserved.
//

#import "CALayer+XYHelper.h"

@implementation CALayer (XYHelper)

- (void)setBorderColorFromUIColor:(UIColor *)color {
    self.borderColor = color.CGColor;
}

@end
