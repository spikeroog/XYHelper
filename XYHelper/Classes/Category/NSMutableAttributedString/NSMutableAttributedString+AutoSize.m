//
//  NSMutableAttributedString+AutoSize.m
//  XYKit
//
//  Created by Xiao Yuen on 2018/11/27.
//  Copyright © 2018 Xiao Yuen. All rights reserved.
//

#import "NSMutableAttributedString+AutoSize.h"

@implementation NSMutableAttributedString (AutoSize)

/**
 label的文字一段大一段小（字体大小，颜色不同）
 
 @param string 内容
 @param color 颜色
 @param font 字体
 */
- (void)appendString:(NSString *)string withColor:(UIColor *)color font:(UIFont *)font {
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange range = NSMakeRange(0, string.length);
    [attString addAttribute:NSFontAttributeName value:font range:range];
    [attString addAttribute:NSForegroundColorAttributeName value:color range:range];
    [self appendAttributedString:attString];
}

@end
