//
//  FYFPhotoAuthorization.h
//  Pods
//
//  Created by 范云飞 on 2022/8/3.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, FYFPHAuthorizationStatus) {
    /// 默认还没做出选择
    FYFPHAuthorizationStatusNotDetermined = 0,
    /// 客户端未被授权访问硬件的媒体类型
    FYFPHAuthorizationStatusRestricted,
    /// 用户已经明确否认了这一照片数据的应用程序访问
    FYFPHAuthorizationStatusDenied,
    /// 用户已经授权应用访问照片数据
    FYFPHAuthorizationStatusAuthorized,
    /// ios14部分照片权限
    FYFPHAuthorizationStatusLimited
};

NS_ASSUME_NONNULL_BEGIN

@interface FYFPhotoAuthorization : NSObject

/// 获取相册权限
/// @param handler handler description
+ (void)requestPhotosAuthorizationWithHandler:(void(^)(FYFPHAuthorizationStatus status))handler;

@end

NS_ASSUME_NONNULL_END
