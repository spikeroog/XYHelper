//
//  CALayer+XibColor.m
//  XYKit
//
//  Created by Xiao Yuen on 2019/8/19.
//  Copyright © 2019年 Xiao Yuen. All rights reserved.
//

#import "CALayer+XibColor.h"

@implementation CALayer (XibColor)

- (void)setBorderColorFromUIColor:(UIColor *)color {
    self.borderColor = color.CGColor;
}
@end
