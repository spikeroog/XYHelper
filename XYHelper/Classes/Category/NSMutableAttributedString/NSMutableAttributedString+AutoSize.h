//
//  NSMutableAttributedString+AutoSize.h
//  XYKit
//
//  Created by Xiao Yuen on 2018/11/27.
//  Copyright © 2018 Xiao Yuen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableAttributedString (AutoSize)

/**
 label的文字一段大一段小（字体大小，颜色不同）
 
 @param string 内容
 @param color 颜色
 @param font 字体
 */
- (void)appendString:(NSString *)string withColor:(UIColor *)color font:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
