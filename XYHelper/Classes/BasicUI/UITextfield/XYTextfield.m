//
//  XYTextfield.m
//  XYHelper
//
//  Created by spikeroog on 2019/8/13.
//  Copyright © 2019年 spikeroog. All rights reserved.
//

#import "XYTextfield.h"
#import <YYCategories/YYCategories.h>

#define TF_Separation 10

@implementation XYTextfield

//- (NSAttributedString *)attributedPlaceholder:(NSAttributedString *)attributedPlaceholder {
//    return [[NSAttributedString alloc] initWithString:attributedPlaceholder.string attributes:@{NSForegroundColorAttributeName:self.xy_placeholderColor}];
//}

/// 显示时 居左居右居上居下间距
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectMake(self.leftView.width+TF_Separation*2, 0, bounds.size.width-TF_Separation*3-self.leftView.width-self.rightView.width, bounds.size.height);
}

/// 编辑时 居左居右居上居下间距
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectMake(self.leftView.width+TF_Separation*2, 0, bounds.size.width-TF_Separation*3-self.leftView.width-self.rightView.width, bounds.size.height);
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds {
    
    CGRect textRect = [super leftViewRectForBounds:bounds];
    textRect.origin.x += TF_Separation;
    return textRect;
}

- (CGRect)rightViewRectForBounds:(CGRect)bounds {
    CGRect textRect = [super rightViewRectForBounds:bounds];
    textRect.origin.x -= TF_Separation;
    return textRect;
}

/// 清空按钮
- (CGRect)clearButtonRectForBounds:(CGRect)bounds {
    CGRect clearButtonRect = [super clearButtonRectForBounds:bounds];
    clearButtonRect.origin.x -= TF_Separation*1.2f;
    return clearButtonRect;
}

@end
