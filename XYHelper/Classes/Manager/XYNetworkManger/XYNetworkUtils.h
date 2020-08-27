//
//  XYNetworkUtils.h
//  XYHelper
//
//  Created by spikeroog on 2020/8/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYNetworkUtils : NSObject

#pragma mark - 二进制数据流转json
+ (NSString *)responseObjectToJson:(id)responseObject;

/// 加签参数排序（升序）
/// @param param 参数字典
+ (NSString *)sortSignWithParam:(NSMutableDictionary *)param;

/// 请求参数排序（升序）
/// @param dict 参数字典
+ (NSString *)stringSortByDic:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
