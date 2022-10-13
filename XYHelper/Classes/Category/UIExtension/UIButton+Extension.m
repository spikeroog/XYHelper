//
//  UIButton+Extension.m
//  ChinaIdea
//
//  Created by spikeroog on 16/6/15.
//  Copyright © 2016年 spikeroog. All rights reserved.
//

#import "UIButton+Extension.h"
#import "XYScreenAdapter.h"

/// 标题默认颜色
#define kItemTitleColor ([UIColor colorWithWhite:80.0 / 255.0 alpha:1.0])
/// 标题高亮颜色
#define kItemTitleHighlightedColor ([UIColor orangeColor])
/// 标题字体大小
#define kItemFontSize   kRl(16)


@implementation UIButton (Extension)

+ (instancetype)ui_buttonWithTitle:(NSString *)title imageName:(NSString *)imageName target:(id)target action:(SEL)action {
    
    UIButton *button = [[self alloc] init];
    
    // 设置图像
    if (imageName != nil) {
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        
        NSString *highlighted = [NSString stringWithFormat:@"%@_highlighted", imageName];
        [button setImage:[UIImage imageNamed:highlighted] forState:UIControlStateHighlighted];
    }
    
    // 设置标题
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:kItemTitleColor forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:kItemFontSize];
    
    [button sizeToFit];
    
    // 监听方法
    if (action != nil) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    
    return button;
}

+ (instancetype)ui_buttonWithTitle:(NSString *)title color:(UIColor *)color font:(UIFont *)font imageName:(NSString *)imageName backImageName:(NSString *)backImageName {
    
    UIButton *button = [[UIButton alloc] init];
    
    // 设置标题
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    button.titleLabel.font = font;
    
    // 图片
    if (imageName != nil) {
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        
        NSString *highlighted = [NSString stringWithFormat:@"%@_highlighted", imageName];
        [button setImage:[UIImage imageNamed:highlighted] forState:UIControlStateHighlighted];
    }
    
    // 背景图片
    if (backImageName != nil) {
        [button setBackgroundImage:[UIImage imageNamed:backImageName] forState:UIControlStateNormal];
        
        NSString *backHighlighted = [NSString stringWithFormat:@"%@_highlighted", backImageName];
        [button setBackgroundImage:[UIImage imageNamed:backHighlighted] forState:UIControlStateHighlighted];
    }
    
    return button;
}

+ (instancetype)ui_buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor backImageName:(NSString *)backImageName {
    
    UIButton *button = [[UIButton alloc] init];
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:backImageName] forState:UIControlStateNormal];
    
    return button;
}

+ (instancetype)ui_buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor imageName:(NSString *)imageName target:(id)target action:(SEL)action {
    
    UIButton *button = [[self alloc] init];
    
    // 设置图像
    if (imageName != nil) {
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        
        NSString *highlighted = [NSString stringWithFormat:@"%@_highlighted", imageName];
        [button setImage:[UIImage imageNamed:highlighted] forState:UIControlStateHighlighted];
    }
    
    // 设置标题
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:kItemFontSize];
    
    [button sizeToFit];
    
    // 监听方法
    if (action != nil) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    
    return button;
}


/**
 图片在上文字在下
 */
- (void)ui_verticalArrangement {
    /// 使图片和文字水平居中显示
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    /// 文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [self setTitleEdgeInsets:UIEdgeInsetsMake(self.imageView.frame.size.height ,-self.imageView.frame.size.width, 0.0,0.0)];
    [self setImageEdgeInsets:UIEdgeInsetsMake(-self.titleLabel.frame.size.height, 0.0,0.0, -self.titleLabel.bounds.size.width)];
}

@end
