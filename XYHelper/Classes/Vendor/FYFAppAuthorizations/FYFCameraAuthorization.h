//
//  FYFCameraAuthorization.h
//  Pods
//
//  Created by 范云飞 on 2022/8/3.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, FYFAVAuthorizationStatus) {
    /// 用户尚未选择关于客户端是否可以访问硬件
    FYFAVAuthorizationStatusNotDetermined = 0,
    /// 客户端未被授权访问硬件的媒体类型。用户不能改变客户机的状态,可能由于活跃的限制,如家长控制
    FYFAVAuthorizationStatusRestricted    = 1,
    /// 明确拒绝用户访问硬件支持的媒体类型的客户
    FYFAVAuthorizationStatusDenied        = 2,
    /// 客户端授权访问硬件支持的媒体类型
    FYFAVAuthorizationStatusAuthorized    = 3
};


NS_ASSUME_NONNULL_BEGIN

@interface FYFCameraAuthorization : NSObject

/// 获取相机权限
/// @param completionHandler completionHandler description
+ (void)requestAuthorizationStatusForVideoWithCompletionHandler:(void(^)(FYFAVAuthorizationStatus status))completionHandler;

@end

NS_ASSUME_NONNULL_END

