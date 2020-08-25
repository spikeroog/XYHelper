//
//  MBProgressHUD+XYKit.m
//  XYKit
//
//  Created by Xiao Yuen on 2019/8/21.
//  Copyright © 2019年 Xiao Yuen. All rights reserved.
//

#import "MBProgressHUD+XYKit.h"
#import "UIImage+GIF.h"

#define HUD_DELAY 1.25f
#define HUD_FONT 14.0f

#define HUD_IN_TOP CGPointMake(0.f, +MBProgressMaxOffset)
#define HUD_IN_CENTER CGPointMake(0.f, 0.f)
#define HUD_IN_BOTTOM CGPointMake(0.f, MBProgressMaxOffset)

@implementation MBProgressHUD (XYKit)

#pragma mark + 配置
/**
 是否可以点击背景
 
 @param couldTouch 是否可以点击背景
 @param isKeyWindow 父视图是否是keyWindow

 @return hud
 */
+ (MBProgressHUD *)reuseHudWithCouldTouch:(BOOL)couldTouch
                          isKeyWindow:(BOOL)isKeyWindow {
    
    UIView *view;
    
    if (isKeyWindow) {
        view = [self fetchKeyWindow];
    } else {
//        view = [[UIApplication sharedApplication].windows lastObject];
        view = [self currentVC].view;
    }
    
    // 有hud就替换
    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:self]) {
            return (MBProgressHUD *)subview;
        }
    }
    
    // 没有就创建一个hud
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    // 背景颜色
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = kColorWithRGB16RadixA(0x000000, 1);
    // 字体颜色
    hud.contentColor = kColorWithRGB16Radix(0xffffff);
    
    // hud在屏幕上的位置
    hud.offset = HUD_IN_BOTTOM;
    
    if (couldTouch) { // 可以点击背景，右滑返回等
        hud.userInteractionEnabled = NO;
    } else { // 背景无法被点击
        hud.userInteractionEnabled = YES;
    }
    
    hud.bezelView.layer.cornerRadius = 15;
    hud.bezelView.layer.masksToBounds = YES;
    
    // 设置菊花颜色  只能设置菊花的颜色
    //    hud.activityIndicatorColor = kColorWithRGB16Radix(0xffffff);
    
    hud.label.font = kFontWithAutoSize(HUD_FONT);
    hud.label.textColor = kColorWithRGB16Radix(0xffffff);
    hud.label.numberOfLines = 0;
    hud.detailsLabel.font = kFontWithAutoSize(HUD_FONT);
    hud.detailsLabel.textColor = kColorWithRGB16Radix(0xffffff);
    hud.detailsLabel.numberOfLines = 0;
    
    return hud;
}

#pragma mark - Main

/**
 移除loading hud
 
 @param isKeyWindow 是否是在keyWindow上，YES为keywindow，NO为当前显示的VC
 */
+ (void)removeLoadingHudOnKeyWindow:(BOOL)isKeyWindow {
    if (isKeyWindow) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self hideHUDForView:[self fetchKeyWindow] animated:YES];
        });
    } else {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self hideHUDForView:[self currentVC].view animated:YES];
        });
    }
}

/**
 无提示，简单hud
 */
+ (void)showSimpleHUD {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [self reuseHudWithCouldTouch:YES isKeyWindow:YES];
        hud.offset = HUD_IN_CENTER;
        hud.mode = MBProgressHUDModeIndeterminate;
    });
}

/**
 文本hud
 
 @param text 文本
 */
+ (void)showTextHUD:(NSString *)text {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [self reuseHudWithCouldTouch:YES isKeyWindow:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = text;
        [hud hideAnimated:YES afterDelay:HUD_DELAY];
    });
}

/**
 文本hud显示在可以window上,(用于解决显示hud然后又删除视图操作时的闪退问题)
 
 @param text 文本
 */
+ (void)showTextHUDInKeyWindow:(NSString *)text {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [self reuseHudWithCouldTouch:YES isKeyWindow:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = text;
        [hud hideAnimated:YES afterDelay:HUD_DELAY];
    });
}

/**
 带指示器的hud
 
 @param loadText 文本
 */
+ (void)showLoadingHUD:(NSString *)loadText {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [self reuseHudWithCouldTouch:YES isKeyWindow:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.label.text = loadText;
    });
}

/**
 显示成功hud，带图标
 
 @param text 文本
 */
+ (void)showSuccessHUD:(NSString *)text {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [self reuseHudWithCouldTouch:YES isKeyWindow:YES];
        hud.label.text = text;
        hud.mode = MBProgressHUDModeCustomView;
        hud.customView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"jg_hud_success"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        [hud hideAnimated:YES afterDelay:HUD_DELAY];
    });
}

/**
 显示失败hud，带图标
 
 @param text 文本
 */
+ (void)showErrorHUD:(NSString *)text {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [self reuseHudWithCouldTouch:YES isKeyWindow:YES];
        hud.label.text = text;
        hud.mode = MBProgressHUDModeCustomView;
        hud.customView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"jg_hud_error"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        [hud hideAnimated:YES afterDelay:HUD_DELAY];
    });
}


/**
 显示gif hud
 
 @param type 显示类型
 @param message 目标字符串，url链接或者本地gif名称
 @param text 提示文本
 */
+ (void)showGifHUD:(MBProgressHudGifType)type
           message:(NSString *)message
              text:(nullable NSString *)text {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        MBProgressHUD *hud = [self reuseHudWithCouldTouch:YES isKeyWindow:NO];
        hud.mode = MBProgressHUDModeCustomView;
        hud.bezelView.backgroundColor = kColorWithNull;
        hud.contentColor = kColorWithNull;
        hud.offset = HUD_IN_CENTER;

        if (text) {
            hud.label.text = text;
            hud.label.textColor = [UIColor blackColor];
        }

        __block UIImageView *gifImageView = [[UIImageView alloc] init];
        
        if (type == MBProgressHUDGIfTypeUrl) { // 网络gif
            
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:message]];
                UIImage *image = [UIImage sd_imageWithGIFData:data];
                dispatch_async(dispatch_get_main_queue(), ^{
                    gifImageView.image = image;
                    hud.customView = gifImageView;
                });
            });
            
        } else if (type == MBProgressHUDGIfTypeFile) { // 本地gif
            
            NSString *path = [[NSBundle mainBundle] pathForResource:message ofType:@"gif"];
            NSData *data = [NSData dataWithContentsOfFile:path];
            UIImage *image = [UIImage sd_imageWithGIFData:data];
            gifImageView.image = image;
            hud.customView = gifImageView;
            
        } else if (type == MBProgressHUDGIfTypeImages) { // 本地图片数组
            
            // 设置正在刷新状态的动画图片
            NSMutableArray *requestImages = [NSMutableArray array];
            for (NSInteger i = 0; i < 15; i++) {
                UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dyla_img_loading_%ld", (long)i]];
                [requestImages addObject:image];
            }
            
            gifImageView.animationImages = requestImages;
            gifImageView.animationDuration = 1;
            gifImageView.animationRepeatCount = 0;
            [gifImageView startAnimating];
            hud.customView = gifImageView;
        }
    });

}

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
            failure:(void(^)(NSError *error))failure {
    
    MBProgressHUD *hud = [self reuseHudWithCouldTouch:NO isKeyWindow:YES];
    hud.mode = MBProgressHUDModeDeterminate;
    hud.label.text = title;
    if (isShowCancelBtn) {
        [hud.button setTitle:@"取消" forState:UIControlStateNormal];
        [hud.button addTarget:hud action:@selector(didClickCancelButton) forControlEvents:UIControlEventTouchUpInside];
    } else {
        hud.button.hidden = YES;
    }
    
    [PPNetworkHelper downloadWithURL:downloadUrl fileDir:@"Download" progress:^(NSProgress *progress) {
        
        NSLog(@"=====%lld", progress.completedUnitCount);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            hud.progress = progress.completedUnitCount;
        });
        
    } success:^(NSString *filePath) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD showTextHUD:@"下载成功"];
        });
        
        success(filePath);
        
    } failure:^(NSError *error) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD showTextHUD:@"下载失败"];
        });
        
        failure(error);
        
    }];
    
}

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
           failure:(void(^)(NSError *error))failure {
    
    MBProgressHUD *hud = [self reuseHudWithCouldTouch:NO isKeyWindow:YES];
    hud.mode = MBProgressHUDModeDeterminateHorizontalBar;
    hud.label.text = title;
    if (isShowCancelBtn) {
        [hud.button setTitle:@"取消" forState:UIControlStateNormal];
        [hud.button addTarget:hud action:@selector(didClickCancelButton) forControlEvents:UIControlEventTouchUpInside];
    } else {
        hud.button.hidden = YES;
    }
    
    [PPNetworkHelper downloadWithURL:downloadUrl fileDir:@"Download" progress:^(NSProgress *progress) {
        
        NSLog(@"=====%lld", progress.completedUnitCount);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            hud.progress = progress.fractionCompleted;
        });
        
    } success:^(NSString *filePath) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD showTextHUD:@"下载成功"];
        });
        
        success(filePath);
        
    } failure:^(NSError *error) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD showTextHUD:@"下载失败"];
        });
        
        failure(error);
        
    }];
}
        

#pragma mark + 进度hud公共方法

+ (void)didClickCancelButton {
    kLog(@"=====click cancel button=====");
}

/**
 进度hud递增method
 
 @param hub hud
 @param complete 回调
 */
+ (void)doSomeWorkWithProgress:(MBProgressHUD *)hub complete:(void(^)(void))complete {
    float progress = 0.0f;
    while (progress < 1.0f) {
        progress += 0.01f;
        dispatch_async(dispatch_get_main_queue(), ^{
            hub.progress = progress;
        });
        usleep(50000);
    }
    complete();
}

#pragma mark + 获取当前Window试图

/** 获取当前控制器 */
+ (UIViewController *)currentVC {
    UIViewController *currVC = nil;
    UIViewController *rootVC = kKeyWindow.rootViewController;
    do {
        if ([rootVC isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nav = (UINavigationController *)rootVC;
            UIViewController *vc = [nav.viewControllers lastObject];
            currVC = vc;
            rootVC = vc.presentedViewController;
            continue;
        } else if ([rootVC isKindOfClass:[UITabBarController class]]) { 
            UITabBarController *tabVC = (UITabBarController *)rootVC;
            currVC = tabVC;
            rootVC = [tabVC.viewControllers objectAtIndex:tabVC.selectedIndex];
            continue;
        }
    } while (rootVC != nil);
    
    return currVC;
}


/** 获取最上层的window */
- (UIWindow *)topLevelWindow {
    UIWindow *topWindow = kKeyWindow;
    for (UIWindow *window in [[UIApplication sharedApplication].windows  reverseObjectEnumerator]) {
        if ([window isEqual:topWindow]) {
            continue;
        }
        if (window.windowLevel > topWindow.windowLevel && window.hidden != YES ) {
            topWindow = window;
        }
    }
    return topWindow;
}

/** 获取keyWindow */
+ (UIWindow *)fetchKeyWindow {
    UIWindow * keyWindow = kKeyWindow;
    if(!keyWindow){
        keyWindow = [UIApplication sharedApplication].windows.firstObject;
    }
    return keyWindow;
}

@end
