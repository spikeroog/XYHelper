//
//  MBProgressHUD+XYHelper.h
//  XYHelper
//
//  Created by spikeroog on 2019/8/21.
//  Copyright © 2019年 spikeroog. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, MBProgressHudGifType) {
    MBProgressHUDGIfTypeUrl = 0, // 网络gif地址
    MBProgressHUDGIfTypeFile, // 本地gif文件名
    MBProgressHUDGIfTypeImages // 图片数组
};

@interface MBProgressHUD (XYHelper)
<MBProgressHUDDelegate>


/// 移除gif hud
+ (void)removeGifHud;
/// 移除loading hud
+ (void)removeLoadingHud;

/**
 文本hud
 
 @param text 文本
 */
+ (void)showTextHUD:(NSString *)text;

/**
 文本hud显示在window上
 
 @param text 文本
 */
+ (void)showTextHUDInKeyWindow:(NSString *)text;

/**
 无提示，简单hud
 */
+ (void)showSimpleHUD:(BOOL)canTouch;

/**
 带指示器的hud
 
 @param loadText 文本
 */
+ (void)showLoadingHUD:(NSString *)loadText
              canTouch:(BOOL)canTouch;

/**
 显示图片提示hud，带图标
 
 @param text 文本
 */
+ (void)showHintHUD:(NSString *)text
      hintImageName:(NSString *)hintImageName
           canTouch:(BOOL)canTouch;

/**
 显示gif hud
 
 @param type 显示类型
 @param gifImageName 目标字符串，url链接或者本地gif名称
 @param text 提示文本
 */
+ (void)showGifHUD:(MBProgressHudGifType)type
      gifImageName:(NSString *)gifImageName
              text:(nullable NSString *)text;

/// 显示环形下载hud
/// @param title 标题
/// @param downloadUrl 下载链接
/// @param isShowCancelBtn 显示取消按钮
/// @param success 成功回调
/// @param failure 失败回调
+ (void)showRingHUD:(NSString *)title
        downloadUrl:(NSString *)downloadUrl
    isShowCancelBtn:(BOOL)isShowCancelBtn
            success:(void(^)(NSString *filePath))success
            failure:(void(^)(NSError *error))failure;

/// 显示横条下载hud
/// @param title 标题
/// @param downloadUrl 下载链接
/// @param isShowCancelBtn 显示取消按钮
/// @param success 成功回调
/// @param failure 失败回调
+ (void)showPieHUD:(NSString *)title
       downloadUrl:(NSString *)downloadUrl
   isShowCancelBtn:(BOOL)isShowCancelBtn
           success:(void(^)(NSString *filePath))success
           failure:(void(^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
