//
//  NSString+Extension.h
//  XYKit
//
//  Created by Xiao Yuen on 2018/12/18.
//  Copyright © 2018 Xiao Yuen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Extension)

#pragma mark - 判断字符串是否为空
+ (BOOL)isNull:(NSString *)string;

#pragma mark - 将带有中文的地址转成utf-8地址
+ (NSString *)xy_transitionChinesePath:(NSString *)path;

#pragma mark - 计算上次日期距离现在多久
+ (NSString *)xy_timeIntervalFromLastTime:(NSString *)lastTime
                        lastTimeFormat:(NSString *)format1
                         ToCurrentTime:(NSString *)currentTime
                     currentTimeFormat:(NSString *)format2;

#pragma mark - MD5加密 16位 大写
+ (NSString *)MD5ForUpper16Bate:(NSString *)str;
#pragma mark - MD5加密 32位 大写
+ (NSString *)MD5ForUpper32Bate:(NSString *)str;

@end

NS_ASSUME_NONNULL_END
