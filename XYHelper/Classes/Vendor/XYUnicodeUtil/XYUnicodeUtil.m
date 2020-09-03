//
//  XYUnicodeUtil.m
//
//  Created by spikeroog on 2019/3/31.
//  Copyright © 2017年 spikeroog. All rights reserved.
//

#import "XYUnicodeUtil.h"
#import <objc/runtime.h>

static inline void zxp_swizzleSelector(Class class, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    if (class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@implementation NSString (XYUnicodeUtil)

- (NSString *)stringByReplaceUnicode {
    NSMutableString *convertedString = [self mutableCopy];
    [convertedString replaceOccurrencesOfString:@"\\U"
                                     withString:@"\\u"
                                        options:0
                                          range:NSMakeRange(0, convertedString.length)];
    
    CFStringRef transform = CFSTR("Any-Hex/Java");
    CFStringTransform((__bridge CFMutableStringRef)convertedString, NULL, transform, YES);
    return convertedString;
}

@end

@implementation NSArray (XYUnicodeUtil)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        zxp_swizzleSelector(class, @selector(description), @selector(zxp_description));
        zxp_swizzleSelector(class, @selector(descriptionWithLocale:), @selector(zxp_descriptionWithLocale:));
        zxp_swizzleSelector(class, @selector(descriptionWithLocale:indent:), @selector(zxp_descriptionWithLocale:indent:));
    });
}

/**
 *  可以把以下的方法放到一个NSObject的category中
 *  然后在需要的类中进行swizzle
 */

- (NSString *)zxp_description {
    return [[self zxp_description] stringByReplaceUnicode];
}

- (NSString *)zxp_descriptionWithLocale:(nullable id)locale {
    return [[self zxp_descriptionWithLocale:locale] stringByReplaceUnicode];
}

- (NSString *)zxp_descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level {
    return [[self zxp_descriptionWithLocale:locale indent:level] stringByReplaceUnicode];
}

@end

@implementation NSDictionary (XYUnicodeUtil)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        zxp_swizzleSelector(class, @selector(description), @selector(zxp_description));
        zxp_swizzleSelector(class, @selector(descriptionWithLocale:), @selector(zxp_descriptionWithLocale:));
        zxp_swizzleSelector(class, @selector(descriptionWithLocale:indent:), @selector(zxp_descriptionWithLocale:indent:));
    });
}

- (NSString *)zxp_description {
    return [[self zxp_description] stringByReplaceUnicode];
}

- (NSString *)zxp_descriptionWithLocale:(nullable id)locale {
    return [[self zxp_descriptionWithLocale:locale] stringByReplaceUnicode];
}

- (NSString *)zxp_descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level {
    return [[self zxp_descriptionWithLocale:locale indent:level] stringByReplaceUnicode];
}

@end

@implementation NSSet (XYUnicodeUtil)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        zxp_swizzleSelector(class, @selector(description), @selector(zxp_description));
        zxp_swizzleSelector(class, @selector(descriptionWithLocale:), @selector(zxp_descriptionWithLocale:));
        zxp_swizzleSelector(class, @selector(descriptionWithLocale:indent:), @selector(zxp_descriptionWithLocale:indent:));
    });
}

- (NSString *)zxp_description {
    return [[self zxp_description] stringByReplaceUnicode];
}

- (NSString *)zxp_descriptionWithLocale:(nullable id)locale {
    return [[self zxp_descriptionWithLocale:locale] stringByReplaceUnicode];
}

- (NSString *)zxp_descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level {
    return [[self zxp_descriptionWithLocale:locale indent:level] stringByReplaceUnicode];
}

@end

