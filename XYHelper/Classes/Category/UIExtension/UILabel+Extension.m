//
//  UILabel+Extension.h
//  BiBiClick
//
//  Created by spikeroog on 2017/8/2.
//  Copyright © 2017年 spikeroog. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)

+ (instancetype)ui_labelWithTitle:(NSString *)title color:(UIColor *)color fontSize:(CGFloat)fontSize {
    return [self ui_labelWithTitle:title color:color fontSize:fontSize alignment:NSTextAlignmentCenter numberOfLine:0];
}

+ (instancetype)ui_labelWithTitle:(NSString *)title color:(UIColor *)color fontSize:(CGFloat)fontSize alignment:(NSTextAlignment)alignment numberOfLine:(NSInteger)numberOfLine{
    
    UILabel *label = [[UILabel alloc] init];
    
    label.text = title;
    label.textColor = color;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.numberOfLines = numberOfLine;
    label.textAlignment = alignment;
    
    [label sizeToFit];
    
    return label;
}

@end
