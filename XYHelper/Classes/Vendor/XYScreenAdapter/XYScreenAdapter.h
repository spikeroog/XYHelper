//
//  XYScreenAdapter.h
//  XYScreenAdapter
//
//  Created by spikeroog on 2020/11/6.
//  Copyright © 2020年 spikeroog. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// 根据名字设置字体
#define kFontWithNameSize(fontName, fontSize) ([UIFont fontWithName:fontName size:fontSize])
// 正常的字体
#define kFontWithSize(size) ([UIFont systemFontOfSize:size])
// 屏幕适配的字体
#define kFontWithAutoSize(size) ([UIFont systemFontOfSize:tRealFontSize(size)])
// 加粗字体
#define kFontBoldWithSize(size) ([UIFont boldSystemFontOfSize:size])
// 加粗屏幕适配的字体
#define kFontBoldWithAutoSize(size) ([UIFont boldSystemFontOfSize:tRealFontSize(size)])
// 斜体
#define kItalicFontWithSize(size) ([UIFont italicSystemFontOfSize:size])

/** ---- 屏幕适配 ----
 */
#define kAutoCs(number) tRealLength(number)

/** 适配手机类型 */
typedef NS_ENUM(NSInteger,XYScreenAdapterPhoneType) {
    /** 320 * 480 */
    XYScreenAdapterPhoneType_iPhone3GS_4_4S    = 0,
    /** 320 * 568 */
    XYScreenAdapterPhoneType_iPhone5_5C_5S_5SE = 1,
    /** 375 * 667 */
    XYScreenAdapterPhoneType_iPhone6_6S_7_8_SE = 2,
    /** 414 * 736 */
    XYScreenAdapterPhoneType_iPhone6Plus_6SPlus_7Plus_8Plus = 3,
    /** 375 * 812 */
    XYScreenAdapterPhoneType_iPhoneX_XS_11Pro_12mini_13mini        = 4,
    /** 414 * 896 */
    XYScreenAdapterPhoneType_iPhoneXSMax_XR_11_11ProMax     = 5,
    /** 390 * 844 */
    XYScreenAdapterPhoneType_iPhone12_12Pro_13Pro_14                 = 6,
    /** 428 * 926 */
    XYScreenAdapterPhoneType_iPhone12ProMax_13ProMax_14Plus                 = 7,
    /** 393 * 852 */
    XYScreenAdapterPhoneType_iPhone14Pro                 = 8,
    /** 430 * 932 */
    XYScreenAdapterPhoneType_iPhone14ProMax                = 9,
    /** 其他 */
    XYScreenAdapterPhoneTypeOther                           = 10,
};

/** 所需适配机型-屏幕宽 */
UIKIT_EXTERN CGFloat const SCREEN_WIDTH_iPhone3GS_4_4S;
UIKIT_EXTERN CGFloat const SCREEN_WIDTH_iPhone5_5C_5S_5SE;
UIKIT_EXTERN CGFloat const SCREEN_WIDTH_iPhone6_6S_7_8_SE;
UIKIT_EXTERN CGFloat const SCREEN_WIDTH_iPhone6Plus_6SPlus_7Plus_8Plus;
UIKIT_EXTERN CGFloat const SCREEN_WIDTH_iPhoneX_XS_11Pro_12mini_13mini;
UIKIT_EXTERN CGFloat const SCREEN_WIDTH_iPhoneXSMax_XR_11_11ProMax;
UIKIT_EXTERN CGFloat const SCREEN_WIDTH_iPhone12_12Pro_13Pro_14;
UIKIT_EXTERN CGFloat const SCREEN_WIDTH_iPhone14Pro;
UIKIT_EXTERN CGFloat const SCREEN_WIDTH_iPhone12ProMax_13ProMax_14Plus;
UIKIT_EXTERN CGFloat const SCREEN_WIDTH_iPhone14ProMax;


/** 所需适配机型-屏幕高 */
UIKIT_EXTERN CGFloat const SCREEN_HEIGHT_iPhone3GS_4_4S;
UIKIT_EXTERN CGFloat const SCREEN_HEIGHT_iPhone5_5C_5S_5SE;
UIKIT_EXTERN CGFloat const SCREEN_HEIGHT_iPhone6_6S_7_8_SE;
UIKIT_EXTERN CGFloat const SCREEN_HEIGHT_iPhone6Plus_6SPlus_7Plus_8Plus;
UIKIT_EXTERN CGFloat const SCREEN_HEIGHT_iPhoneX_XS_11Pro_12mini_13mini;
UIKIT_EXTERN CGFloat const SCREEN_HEIGHT_iPhoneXSMax_XR_11_11ProMax;
UIKIT_EXTERN CGFloat const SCREEN_HEIGHT_iPhone12_12Pro_13Pro_14;
UIKIT_EXTERN CGFloat const SCREEN_HEIGHT_iPhone14Pro;
UIKIT_EXTERN CGFloat const SCREEN_HEIGHT_iPhone12ProMax_13ProMax_14Plus;
UIKIT_EXTERN CGFloat const SCREEN_HEIGHT_iPhone14ProMax;


/** 屏幕宽度 */
static inline CGFloat tScreenWidth() {
    return [UIScreen mainScreen].bounds.size.width;
}

/** 幕高度 */
static inline CGFloat tScreenHeight() {
    return [UIScreen mainScreen].bounds.size.height;
}

/** 当前屏幕类型 */
static inline XYScreenAdapterPhoneType tCurrentType() {
    if (tScreenHeight() == SCREEN_HEIGHT_iPhone3GS_4_4S) return XYScreenAdapterPhoneType_iPhone3GS_4_4S;
    if (tScreenHeight() == SCREEN_HEIGHT_iPhone5_5C_5S_5SE) return XYScreenAdapterPhoneType_iPhone5_5C_5S_5SE;
    if (tScreenHeight() == SCREEN_HEIGHT_iPhone6_6S_7_8_SE) return XYScreenAdapterPhoneType_iPhone6_6S_7_8_SE;
    if (tScreenHeight() == SCREEN_HEIGHT_iPhone6Plus_6SPlus_7Plus_8Plus) return XYScreenAdapterPhoneType_iPhone6Plus_6SPlus_7Plus_8Plus;
    if (tScreenHeight() == SCREEN_HEIGHT_iPhoneX_XS_11Pro_12mini_13mini) return XYScreenAdapterPhoneType_iPhoneX_XS_11Pro_12mini_13mini;
    if (tScreenHeight() == SCREEN_HEIGHT_iPhoneXSMax_XR_11_11ProMax) return XYScreenAdapterPhoneType_iPhoneXSMax_XR_11_11ProMax;
    if (tScreenHeight() == SCREEN_HEIGHT_iPhone12_12Pro_13Pro_14) return XYScreenAdapterPhoneType_iPhone12_12Pro_13Pro_14;
    if (tScreenHeight() == SCREEN_HEIGHT_iPhone12ProMax_13ProMax_14Plus) return XYScreenAdapterPhoneType_iPhone12ProMax_13ProMax_14Plus;
    if (tScreenHeight() == SCREEN_HEIGHT_iPhone14Pro) return
        XYScreenAdapterPhoneType_iPhone14Pro;
    if (tScreenHeight() == SCREEN_HEIGHT_iPhone14ProMax) return
        XYScreenAdapterPhoneType_iPhone14ProMax;

    return XYScreenAdapterPhoneTypeOther;
}

/** 屏幕适配 */
@interface XYScreenAdapter : NSObject

/** 屏幕默认类型 默认为XYScreenAdapterPhoneType_iPhone6_6S_7_8 */
@property (nonatomic) XYScreenAdapterPhoneType defaultType;

/** 屏幕宽度 */
@property (nonatomic,readonly) CGFloat defaultScreenWidth;

/** 屏幕高度 */
@property (nonatomic,readonly) CGFloat defaultScreenHeight;

/** 共享适配器 */
+ (instancetype)shareAdapter;

@end

/**
 注：屏幕及字体是以屏幕宽度来适配的
 */

/** 真实字体大小 */
static inline CGFloat tRealFontSize(CGFloat defaultSize) {
    if ([XYScreenAdapter shareAdapter].defaultType == tCurrentType())
        return defaultSize;
    return tScreenWidth() / [XYScreenAdapter shareAdapter].defaultScreenWidth * defaultSize;
}

/** 真实长度 */
static inline CGFloat tRealLength(CGFloat defaultLength) {
    if ([XYScreenAdapter shareAdapter].defaultType == tCurrentType())
        return defaultLength;
    return tScreenWidth()/[XYScreenAdapter shareAdapter].defaultScreenWidth * defaultLength;
}
