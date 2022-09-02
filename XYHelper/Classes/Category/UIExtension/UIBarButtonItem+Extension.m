//
//  UIBarButtonItem+Extension.m
//  ChinaIdea
//
//  Created by spikeroog on 16/6/15.
//  Copyright © 2016年 spikeroog. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
#import "UIButton+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (instancetype)ui_barButtonWithTitle:(NSString *)title imageName:(NSString *)imageName target:(id)target action:(SEL)action {
    
    UIButton *button = [UIButton ui_buttonWithTitle:title imageName:imageName target:target action:action];
    CGRect frame = button.frame;
    frame.size.width += 20;
    button.frame = frame;
    button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
    return [[self alloc] initWithCustomView:button];
}

+ (instancetype)ui_barButtonCenterWithTitle:(NSString *)title imageName:(NSString *)imageName target:(id)target action:(SEL)action {
    
    UIButton *button = [UIButton ui_buttonWithTitle:title imageName:imageName target:target action:action];
    CGRect frame = button.frame;
    frame.size.width += 20;
    button.frame = frame;
    return [[self alloc] initWithCustomView:button];
}

+ (instancetype)ui_barButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor imageName:(NSString *)imageName target:(id)target action:(SEL)action{
    
    UIButton *button = [UIButton ui_buttonWithTitle:title titleColor:titleColor imageName:imageName target:target action:action];
    
    return [[self alloc] initWithCustomView:button];
}

@end
