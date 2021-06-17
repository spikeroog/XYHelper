//
//  XYCacheManager.h
//  XYHelper
//
//  Created by spikeroog on 2020/5/31.
//  Copyright © 2020 spikeroog. All rights reserved.
//  本地缓存文件

#import <Foundation/Foundation.h>
#import "NSString+XYHelper.h"

NS_ASSUME_NONNULL_BEGIN

@interface XYCacheManager : NSObject

/// /Caches/datas
+ (NSString *)BASE_DIR;

/// 缓存文件写入/读取操作
+ (BOOL)setData:(nullable NSData *)data forKey:(NSString *)key;
+ (nullable NSData *)dataForKey:(NSString *)key;
@end


@interface XYCacheManager (Download)

/// 通过文件 url 地址获取对应的缓存文件 key
+ (NSString *)keyFromURL:(NSString *)urlString;

/// 获取文件缓存地址
+ (NSString *)dataFilePathFromURL:(NSString *)urlString;

/// 通过文件地址获取数据 
+ (void)dataForURLString:(NSString *)urlString completBlock:(nullable void(^)(NSData * _Nullable resultData))completBlock;
+ (void)dataForURLString:(NSString *)urlString useCache:(BOOL)useCache completBlock:(nullable void(^)(NSData * _Nullable resultData))completBlock;
@end

NS_ASSUME_NONNULL_END
