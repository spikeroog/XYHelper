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
#define kBoldFontWithSize(size) ([UIFont boldSystemFontOfSize:size])
// 加粗屏幕适配的字体
#define kBoldFontWithAutoSize(size) ([UIFont boldSystemFontOfSize:tRealFontSize(size)])
// 斜体
#define kItalicFontWithSize(size) ([UIFont italicSystemFontOfSize:size])

/** ---- 屏幕适配 ----
 */
#define kAutoCs(number) tRealLength(number)

/** 适配手机类型 */
typedef NS_ENUM(NSInteger,XYScreenAdapterPhoneType) {
    /** iPhone3GS_4_4S */
    XYScreenAdapterPhoneType_iPhone3GS_4_4S    = 0,
    /** iPhone5_5C_5S_5SE */
    XYScreenAdapterPhoneType_iPhone5_5C_5S_5SE = 1,
    /** iPhone6_6S_7_8 */
    XYScreenAdapterPhoneType_iPhone6_6S_7_8_SE = 2,
    /** iPhone6Plus_6SPlus_7Plus_8Plus */
    XYScreenAdapterPhoneType_iPhone6Plus_6SPlus_7Plus_8Plus = 3,
    /** iPhoneX_XS_11Pro_12mini */
    XYScreenAdapterPhoneType_iPhoneX_XS_11Pro_12mini        = 4,
    /** iPhoneXSMax_XR_11_11ProMax */
    XYScreenAdapterPhoneType_iPhoneXSMax_XR_11_11ProMax     = 5,
    /** iPhone12_12Pro */
    XYScreenAdapterPhoneType_iPhone12_12Pro                 = 6,
    /** iPhone12ProMax */
    XYScreenAdapterPhoneType_iPhone12ProMax                 = 7,
    /** 其他 */
    XYScreenAdapterPhoneTypeOther                           = 8,
};

/** 所需适配机型-屏幕宽 */
UIKIT_EXTERN CGFloat const SCREEN_WIDTH_iPhone3GS_4_4S;
UIKIT_EXTERN CGFloat const SCREEN_WIDTH_iPhone5_5C_5S_5SE;
UIKIT_EXTERN CGFloat const SCREEN_WIDTH_iPhone6_6S_7_8_SE;
UIKIT_EXTERN CGFloat const SCREEN_WIDTH_iPhone6Plus_6SPlus_7Plus_8Plus;
UIKIT_EXTERN CGFloat const SCREEN_WIDTH_iPhoneX_XS_11Pro_12mini;
UIKIT_EXTERN CGFloat const SCREEN_WIDTH_iPhoneXSMax_XR_11_11ProMax;
UIKIT_EXTERN CGFloat const SCREEN_WIDTH_iPhone12_12Pro;
UIKIT_EXTERN CGFloat const SCREEN_WIDTH_iPhone12ProMax;

/** 所需适配机型-屏幕高 */
UIKIT_EXTERN CGFloat const SCREEN_HEIGHT_iPhone3GS_4_4S;
UIKIT_EXTERN CGFloat const SCREEN_HEIGHT_iPhone5_5C_5S_5SE;
UIKIT_EXTERN CGFloat const SCREEN_HEIGHT_iPhone6_6S_7_8_SE;
UIKIT_EXTERN CGFloat const SCREEN_HEIGHT_iPhone6Plus_6SPlus_7Plus_8Plus;
UIKIT_EXTERN CGFloat const SCREEN_HEIGHT_iPhoneX_XS_11Pro_12mini;
UIKIT_EXTERN CGFloat const SCREEN_HEIGHT_iPhoneXSMax_XR_11_11ProMax;
UIKIT_EXTERN CGFloat const SCREEN_HEIGHT_iPhone12_12Pro;
UIKIT_EXTERN CGFloat const SCREEN_HEIGHT_iPhone12ProMax;

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
    if (tScreenHeight() == SCREEN_HEIGHT_iPhoneX_XS_11Pro_12mini) return XYScreenAdapterPhoneType_iPhoneX_XS_11Pro_12mini;
    if (tScreenHeight() == SCREEN_HEIGHT_iPhoneXSMax_XR_11_11ProMax) return XYScreenAdapterPhoneType_iPhoneXSMax_XR_11_11ProMax;
    if (tScreenHeight() == SCREEN_HEIGHT_iPhone12_12Pro) return XYScreenAdapterPhoneType_iPhone12_12Pro;
    if (tScreenHeight() == SCREEN_HEIGHT_iPhone12ProMax) return XYScreenAdapterPhoneType_iPhone12ProMax;
    return XYScreenAdapterPhoneTypeOther;
}

/** 屏幕适配 */
@interface XYScreenAdapter : NSObject

/** 屏幕默认类型 默认为XYScreenAdapterPhoneType_iPhone6_6S_7_8 */
@property(nonatomic)XYScreenAdapterPhoneType defaultType;

/** 屏幕宽度 */
@property(nonatomic,readonly)CGFloat defaultScreenWidth;

/** 屏幕高度 */
@property(nonatomic,readonly)CGFloat defaultScreenHeight;

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
