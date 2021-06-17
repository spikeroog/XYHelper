//
//  XYCacheManager.m
//  XYHelper
//
//  Created by spikeroog on 2020/5/31.
//  Copyright © 2020 spikeroog. All rights reserved.
//

#import "XYCacheManager.h"

@implementation XYCacheManager

+ (NSString *)BASE_DIR {
    NSString *component = @"datas";
    NSString *result = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:component];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirectory;
    BOOL exists = [fileManager fileExistsAtPath:result isDirectory:&isDirectory];
    if (!exists || !isDirectory) {
        [fileManager createDirectoryAtPath:result withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return result;
}

+ (BOOL)setData:(NSData *)data forKey:(NSString *)key {
    if (!key) {
        return NO;
    }
    NSString *filePath = [[self BASE_DIR] stringByAppendingPathComponent:key];
    if (data) {
        return [data writeToFile:filePath atomically:YES];
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager removeItemAtPath:filePath error:nil];
}

+ (NSData *)dataForKey:(NSString *)key {
    if (!key) {
        return nil;
    }
    NSString *filePath = [[self BASE_DIR] stringByAppendingPathComponent:key];
    return [NSData dataWithContentsOfFile:filePath];
}

@end


@implementation XYCacheManager (Download)

+ (NSString *)keyFromURL:(NSString *)urlString {
    if ([urlString isKindOfClass:[NSString class]]) {
        return urlString.MD5;
    }
    return @"";
}

+ (NSString *)dataFilePathFromURL:(NSString *)urlString {
    NSString *key = [XYCacheManager keyFromURL:urlString];
    return [[self BASE_DIR] stringByAppendingPathComponent:key];
}

+ (void)dataForURLString:(NSString *)urlString completBlock:(void (^)(NSData * _Nonnull))completBlock {
    [self dataForURLString:urlString useCache:YES completBlock:completBlock];
}

+ (void)dataForURLString:(NSString *)urlString useCache:(BOOL)useCache completBlock:(void (^)(NSData * _Nullable))completBlock {
    if (!urlString) {
        if (completBlock) completBlock(nil);
        return;
    }
    NSString *key = [XYCacheManager keyFromURL:urlString];
    NSData *cache_data = nil;
    if (useCache) {
        cache_data = [XYCacheManager dataForKey:key];
    }
    if (cache_data) {
        if (completBlock) completBlock(cache_data);
        return;
    }
    
#if DEBUG
    printf("%s\n",@"开始缓存文件".UTF8String);
    printf("%s\n",urlString.UTF8String);
#endif
    
    // 开启下载任务
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
#if DEBUG
        if (!data) {
            printf("%s\n",@"缓存失败".UTF8String);
            printf("%s\n",urlString.UTF8String);
        }
#endif
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data && useCache) {
                [XYCacheManager setData:data forKey:key]; // 写入缓存目录
            }
            if (completBlock) completBlock(data);
        });
    });
}

@end
