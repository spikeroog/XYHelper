//
//  UILabel+XYHelper.m
//  XYHelper
//
//  Created by spikeroog on 2018/12/3.
//  Copyright © 2018 spikeroog. All rights reserved.
//

#import "UILabel+XYHelper.h"
#import <CoreText/CoreText.h>

@implementation UILabel (XYHelper)

/**
 设置间距

 @param columnSpace 间距
 */
- (void)xy_setColumnSpace:(CGFloat)columnSpace {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    // 调整间距
    [attributedString addAttribute:(__bridge NSString *)kCTKernAttributeName value:@(columnSpace) range:NSMakeRange(0, [attributedString length])];
    self.attributedText = attributedString;
}

/**
 设置行距

 @param rowSpace 间距
 */
- (void)xy_setRowSpace:(CGFloat)rowSpace {
    self.numberOfLines = 0;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    // 调整行距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = rowSpace;
    paragraphStyle.baseWritingDirection = NSWritingDirectionLeftToRight;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.text length])];
    self.attributedText = attributedString;
}

@end
