//
//  NSString+XYHelper.m
//  XYHelper
//
//  Created by spikeroog on 2018/12/18.
//  Copyright © 2018 spikeroog. All rights reserved.
//

#import "NSString+XYHelper.h"
#import <CommonCrypto/CommonDigest.h> // md5加密

@implementation NSString (XYHelper)

#pragma mark - 将带有中文的地址转成utf-8地址
/**
 将带有中文的地址转成utf-8地址
 
 @param path 带有中文的url
 @return 返回转换后的url
 */
+ (NSString *)xy_transitionChinesePath:(NSString *)path {
    if (!path || ![path isEqual:[NSNull null]]) {
        return @"";
    }
    NSString *urlString = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    return urlString;
}

#pragma mark - 计算上次日期距离现在多久
/**
 计算上次日期距离现在多久
 
 @param lastTime 上次日期(需要和格式对应)
 @param format1 上次日期格式
 @param currentTime 最近日期(需要和格式对应)
 @param format2 最近日期格式
 @return xx分钟前、xx小时前、xx天前
 */
+ (NSString *)xy_timeIntervalFromLastTime:(NSString *)lastTime
                        lastTimeFormat:(NSString *)format1
                         ToCurrentTime:(NSString *)currentTime
                     currentTimeFormat:(NSString *)format2 {
    // 上次时间
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc]init];
    dateFormatter1.dateFormat = format1;
    NSDate *lastDate = [dateFormatter1 dateFromString:lastTime];
    // 当前时间
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc]init];
    dateFormatter2.dateFormat = format2;
    NSDate *currentDate = [dateFormatter2 dateFromString:currentTime];
    return [self xy_timeIntervalFromLastTime:lastDate ToCurrentTime:currentDate];
}

+ (NSString *)xy_timeIntervalFromLastTime:(NSDate *)lastTime ToCurrentTime:(NSDate *)currentTime {
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    // 上次时间
    NSDate *lastDate = [lastTime dateByAddingTimeInterval:[timeZone secondsFromGMTForDate:lastTime]];
    // 当前时间
    NSDate *currentDate = [currentTime dateByAddingTimeInterval:[timeZone secondsFromGMTForDate:currentTime]];
    // 时间间隔
    NSInteger intevalTime = [currentDate timeIntervalSinceReferenceDate] - [lastDate timeIntervalSinceReferenceDate];
    
    // 秒、分、小时、天、月、年
    NSInteger minutes = intevalTime / 60;
    NSInteger hours = intevalTime / 60 / 60;
    NSInteger day = intevalTime / 60 / 60 / 24;
    NSInteger month = intevalTime / 60 / 60 / 24 / 30;
    NSInteger yers = intevalTime / 60 / 60 / 24 / 365;
    
    if (minutes <= 10) {
        return  @"刚刚";
    } else if (minutes < 60){
        return [NSString stringWithFormat: @"%ld分钟前",(long)minutes];
    } else if (hours < 24){
        return [NSString stringWithFormat: @"%ld小时前",(long)hours];
    } else if (day < 30){
        return [NSString stringWithFormat: @"%ld天前",(long)day];
    } else if (month < 12){
        NSDateFormatter * df =[[NSDateFormatter alloc]init];
        df.dateFormat = @"M月d日";
        NSString * time = [df stringFromDate:lastDate];
        return time;
    } else if (yers >= 1){
        NSDateFormatter * df =[[NSDateFormatter alloc]init];
        df.dateFormat = @"yyyy年M月d日";
        NSString * time = [df stringFromDate:lastDate];
        return time;
    }
    return @"";
}

#pragma mark - MD5加密 16位 大写
+ (NSString *)MD5ForUpper16Bate:(NSString *)str {
    NSString *md5Str = [self MD5ForUpper32Bate:str];
    NSString *string;
    for (int i = 0; i < 24; i++) {
        string = [md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    return string;
}

#pragma mark - MD5加密 32位 大写
+ (NSString *)MD5ForUpper32Bate:(NSString *)str {
    // 要进行UTF8的转码
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02X", result[i]];
    }
    return digest;
}

#pragma mark - 判断字符串是否为空
+ (BOOL)isNull:(NSString *)string {
    if (string != nil && ![string isEqual:[NSNull null]] && string.length > 0) {
        return NO;
    } else {
        return YES;
    }
}

@end
