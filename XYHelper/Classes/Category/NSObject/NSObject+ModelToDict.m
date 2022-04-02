//
//  NSObject+ModelToDict.m
//  XYHelper
//
//  Created by spikeroog on 2020/1/6.
//  Copyright © 2020 spikeroog. All rights reserved.
//

#import "NSObject+ModelToDict.h"
#import <objc/runtime.h>

@implementation NSObject (ModelToDict)

+ (NSDictionary *)dictFromModel:(id)model {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    //    NSArray *allkeys = [model allKeys];
    NSMutableArray *keys = [NSMutableArray array];
    NSMutableArray *attributes = [NSMutableArray array];
    unsigned int outCount;
    objc_property_t *properties = class_copyPropertyList([model class], &outCount);
    for (int i = 0; i < outCount; i ++) {
        objc_property_t property = properties[i];
        // 通过property_getName函数获得属性的名字
        NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        [keys addObject:propertyName];
        // 通过property_getAttributes函数可以获得属性的名字和@encode编码
        NSString * propertyAttribute = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
        [attributes addObject:propertyAttribute];
    }
    free(properties);
    [keys enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [dict setValue:[model valueForKey:keys[idx]] forKey:keys[idx]];
    }];
    return dict;
}

@end
