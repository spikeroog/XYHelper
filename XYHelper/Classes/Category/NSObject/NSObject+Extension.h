//
//  NSObject+Extension.h
//  XYKit
//
//  Created by Xiao Yuen on 2018/12/18.
//  Copyright © 2018 Xiao Yuen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Extension)
// 类名
- (NSString *)className;
+ (NSString *)className;

// 父类名称
- (NSString *)superClassName;
+ (NSString *)superClassName;

// 实例属性字典
-(NSDictionary *)propertyDictionary;

// 属性名称列表
- (NSArray*)propertyKeys;
+ (NSArray *)propertyKeys;

// 属性详细信息列表
- (NSArray *)propertiesInfo;
+ (NSArray *)propertiesInfo;

// 格式化后的属性列表
+ (NSArray *)propertiesWithCodeFormat;

// 方法列表
- (NSArray*)methodList;
+ (NSArray*)methodList;

- (NSArray*)methodListInfo;

// 创建并返回一个指向所有已注册类的指针列表
+ (NSArray *)registedClassList;
// 实例变量
+ (NSArray *)instanceVariable;

// 协议列表
- (NSDictionary *)protocolList;
+ (NSDictionary *)protocolList;

- (BOOL)hasPropertyForKey:(NSString*)key;
- (BOOL)hasIvarForKey:(NSString*)key;
@end

NS_ASSUME_NONNULL_END
