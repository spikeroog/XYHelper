//
//  XYScreenAdapter.m
//  XYScreenAdapter
//
//  Created by spikeroog on 2020/11/6.
//  Copyright © 2020年 spikeroog. All rights reserved.
//

#import "XYScreenAdapter.h"

/** 所需适配机型-屏幕宽 */
CGFloat const SCREEN_WIDTH_iPhone3GS_4_4S       = 320.0f;
CGFloat const SCREEN_WIDTH_iPhone5_5C_5S_5SE    = 320.0f;
CGFloat const SCREEN_WIDTH_iPhone6_6S_7_8_SE    = 375.0f;
CGFloat const SCREEN_WIDTH_iPhone6Plus_6SPlus_7Plus_8Plus  = 414.0f;
CGFloat const SCREEN_WIDTH_iPhoneX_XS_11Pro_12mini_13mini         = 375.0f;
CGFloat const SCREEN_WIDTH_iPhoneXSMax_XR_11_11ProMax      = 414.0f;
CGFloat const SCREEN_WIDTH_iPhone12_12Pro_13Pro_14                 = 390.0f;
CGFloat const SCREEN_WIDTH_iPhone14Pro    = 393.0f;
CGFloat const SCREEN_WIDTH_iPhone12ProMax_13ProMax_14Plus                 = 428.0f;
CGFloat const SCREEN_WIDTH_iPhone14ProMax                 = 430.0f;

/** 所需适配机型-屏幕高 */
CGFloat const SCREEN_HEIGHT_iPhone3GS_4_4S      = 480.0f;
CGFloat const SCREEN_HEIGHT_iPhone5_5C_5S_5SE   = 568.0f;
CGFloat const SCREEN_HEIGHT_iPhone6_6S_7_8_SE   = 667.0f;
CGFloat const SCREEN_HEIGHT_iPhone6Plus_6SPlus_7Plus_8Plus = 736.0f;
CGFloat const SCREEN_HEIGHT_iPhoneX_XS_11Pro_12mini_13mini        = 812.0f;
CGFloat const SCREEN_HEIGHT_iPhoneXSMax_XR_11_11ProMax     = 896.0f;
CGFloat const SCREEN_HEIGHT_iPhone12_12Pro_13Pro_14                 = 844.0f;
CGFloat const SCREEN_HEIGHT_iPhone14Pro    = 852.0f;
CGFloat const SCREEN_HEIGHT_iPhone12ProMax_13ProMax_14Plus                = 926.0f;
CGFloat const SCREEN_HEIGHT_iPhone14ProMax                 = 932.0f;

@implementation XYScreenAdapter

/** 共享适配器 */
+ (instancetype)shareAdapter{
    static dispatch_once_t onceToken;
    static XYScreenAdapter * _instance = nil;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

/** 重载方法 */
- (instancetype)init{
    if (self = [super init]) {
        self.defaultType = XYScreenAdapterPhoneType_iPhone6_6S_7_8_SE;
    }
    return self;
}

/** 设置默认类型 */
- (void)setDefaultType:(XYScreenAdapterPhoneType)defaultType {
    _defaultType = defaultType;
    switch (_defaultType) {
        case XYScreenAdapterPhoneType_iPhone3GS_4_4S:
            _defaultScreenWidth  = SCREEN_WIDTH_iPhone3GS_4_4S;
            _defaultScreenHeight = SCREEN_HEIGHT_iPhone3GS_4_4S;
            break;
        case XYScreenAdapterPhoneType_iPhone5_5C_5S_5SE:
            _defaultScreenWidth  = SCREEN_WIDTH_iPhone5_5C_5S_5SE;
            _defaultScreenHeight = SCREEN_HEIGHT_iPhone5_5C_5S_5SE;
            break;
        case XYScreenAdapterPhoneType_iPhone6_6S_7_8_SE:
            _defaultScreenWidth  = SCREEN_WIDTH_iPhone6_6S_7_8_SE;
            _defaultScreenHeight = SCREEN_HEIGHT_iPhone6_6S_7_8_SE;
            break;
        case XYScreenAdapterPhoneType_iPhone6Plus_6SPlus_7Plus_8Plus:
            _defaultScreenWidth  = SCREEN_WIDTH_iPhone6Plus_6SPlus_7Plus_8Plus;
            _defaultScreenHeight = SCREEN_HEIGHT_iPhone6Plus_6SPlus_7Plus_8Plus;
            break;
        case XYScreenAdapterPhoneType_iPhoneX_XS_11Pro_12mini_13mini:
            _defaultScreenWidth  = SCREEN_WIDTH_iPhoneX_XS_11Pro_12mini_13mini;
            _defaultScreenHeight = SCREEN_HEIGHT_iPhoneX_XS_11Pro_12mini_13mini;
            break;
        case XYScreenAdapterPhoneType_iPhoneXSMax_XR_11_11ProMax:
            _defaultScreenWidth  = SCREEN_WIDTH_iPhoneXSMax_XR_11_11ProMax;
            _defaultScreenHeight = SCREEN_HEIGHT_iPhoneXSMax_XR_11_11ProMax;
            break;
        case XYScreenAdapterPhoneType_iPhone12_12Pro_13Pro_14:
            _defaultScreenWidth  = SCREEN_WIDTH_iPhone12_12Pro_13Pro_14;
            _defaultScreenHeight = SCREEN_HEIGHT_iPhone12_12Pro_13Pro_14;
            break;
        case XYScreenAdapterPhoneType_iPhone12ProMax_13ProMax_14Plus:
            _defaultScreenWidth  = SCREEN_WIDTH_iPhone12ProMax_13ProMax_14Plus;
            _defaultScreenHeight = SCREEN_HEIGHT_iPhone12ProMax_13ProMax_14Plus;
            break;
        case XYScreenAdapterPhoneType_iPhone14Pro:
            _defaultScreenWidth  = SCREEN_WIDTH_iPhone14Pro;
            _defaultScreenHeight = SCREEN_HEIGHT_iPhone14Pro;
            break;
        case XYScreenAdapterPhoneType_iPhone14ProMax:
            _defaultScreenWidth  = SCREEN_WIDTH_iPhone14ProMax;
            _defaultScreenHeight = SCREEN_HEIGHT_iPhone14ProMax;
            break;
        case XYScreenAdapterPhoneTypeOther:
            break;
        default:
            break;
    }
}

@end
