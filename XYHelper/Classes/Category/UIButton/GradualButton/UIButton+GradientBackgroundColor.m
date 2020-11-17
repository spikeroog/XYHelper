//
//  UIButton+GradientBackgroundColor.m
//  XYHelper
//
//  Created by spikeroog on 2020/3/14.
//  Copyright © 2020 spikeroog. All rights reserved.
//

#import "UIButton+GradientBackgroundColor.h"
#import "UIView+JHDrawCategory.h"

@implementation UIButton (GradientBackgroundColor)

- (void)gradientBackgroundColor:(NSArray <UIColor *>*)colors {
    if (colors.count == 0) {
        return;
    }
    
    for (UIColor *color in colors) {
        if (![color isKindOfClass:[UIColor class]]) {
            return;
        }
    }
    
    if (colors.count == 1) {
        self.backgroundColor = colors[0];
    }
    
    CALayer *layer = [self jh_gradientLayer:self.bounds color:colors location:@[@(0.3)] direction:CAGradientLayerDirection_FromLeftToRight];
    NSLog(@"%@:\n%@",self.titleLabel.text,self.layer.sublayers);
    
    CALayer *labelLayer = nil;
    for (CALayer *l in self.layer.sublayers) {
        NSString *s = NSStringFromClass([l class]);
        if ([s isEqualToString:@"_UILabelLayer"]) {
            labelLayer = l;
            break;
        }
    }

    // 避免渐变色 覆盖 标题
    [self.layer insertSublayer:layer below:labelLayer];
}

@end

/*
 
 有标题时
 self.titleLabel.text.length >= 0
 (
     "<_UILabelLayer: 0x2811e4c80>",
     "<CAGradientLayer: 0x28303aea0>"
 )
 (
     "<_UILabelLayer: 0x280cd13b0>",
     "<CAGradientLayer: 0x282d17800>"
 )
 
 没有标题时
 (
     "<CAGradientLayer: 0x28364bfc0>",
     "<_UILabelLayer: 0x281794c30>"
 )
 */
