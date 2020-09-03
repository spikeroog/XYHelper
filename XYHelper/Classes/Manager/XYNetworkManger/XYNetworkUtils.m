//
//  XYNetworkUtils.m
//  XYHelper
//
//  Created by spikeroog on 2020/8/27.
//

#import "XYNetworkUtils.h"
#import "XYHelperMarco.h"
#import "XYScreenAdapter.h"

@implementation XYNetworkUtils

#pragma mark - 二进制数据流转json
+ (NSString *)responseObjectToJson:(id)responseObject {
    NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

#pragma mark - 请求参数排序， 签名参数排序
/// 请求参数排序（升序）
/// @param dict 参数字典
+ (NSString *)stringSortByDic:(NSDictionary *)dict {
    
    NSArray *keys = [dict allKeys];
    
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch]; // 升序
    }];
    
    NSString *paramStr;
    for (NSString *categoryId in sortedArray) {
        id value = [dict objectForKey:categoryId];
        if([value isKindOfClass:[NSDictionary class]]) {
            value = [self stringSortByDic:value];
        }
        if ([paramStr length] != 0) {
            paramStr = [paramStr stringByAppendingString:@","];
        }
        paramStr = [paramStr stringByAppendingFormat:@"%@:%@",categoryId,value];
    }
    kLog(@"\n====请求参数:%@",paramStr);
    return paramStr;
}

/// 加签参数排序（升序）
/// @param param 参数字典
+ (NSString *)sortSignWithParam:(NSMutableDictionary *)param {
    
    NSMutableString *contentString = [NSMutableString string];
    
    NSArray *keys = [param allKeys];
    
    // key按字母顺序升序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    // 拼接字符串
    [sortedArray enumerateObjectsUsingBlock:^(NSString *_Nonnull categoryId, NSUInteger idx, BOOL * _Nonnull stop) {
        
        // 如果value值为字典，则将value值转json字符串
        if ([param.allValues[idx] isKindOfClass:[NSDictionary class]]) {
            NSError *error = nil;
            NSDictionary* bizDict = param.allValues[idx];
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:bizDict options:NSJSONWritingPrettyPrinted error: &error];
            NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
            NSString *jsonString1 = [[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding];
            NSString *jsonString2 = [jsonString1 stringByReplacingOccurrencesOfString:@" : " withString:@":"];
            [param setValue:jsonString2 forKey:param.allKeys[idx]];
        }
        
        // 最后一个元素不加&
        if (idx < sortedArray.count - 1) {
            [contentString appendFormat:@"%@=%@&", categoryId, [param valueForKey:categoryId]];
        } else {
            [contentString appendFormat:@"%@=%@", categoryId, [param valueForKey:categoryId]];
        }
        
    }];
    
    // 裁剪：空格换行符
    NSString *handleStr = [contentString mutableCopy];
    handleStr = [handleStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    handleStr = [handleStr stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    handleStr = [handleStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    kLog(@"\n====加签参数:%@",handleStr);
    return handleStr;
}


@end
