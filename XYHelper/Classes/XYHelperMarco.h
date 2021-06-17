//
//  XYHelperMarco.h
//  XYHelper
//
//  Created by spikeroog on 2020/8/13.
//  Copyright © 2020 spikeroog. All rights reserved.
//

#ifndef XYHelperMarco_h
#define XYHelperMarco_h

// ----  异形屏
#define kIsBangsScreen ({\
    BOOL isBangsScreen = NO; \
    if (@available(iOS 11.0, *)) { \
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject]; \
    isBangsScreen = window.safeAreaInsets.bottom > 0; \
    } \
    isBangsScreen; \
})

// ----  导航栏高度
#define kNavBarHeight (kIsBangsScreen?88:64)
// ----  电池栏高度
#define kStatusBarHeight (kIsBangsScreen?44:20)
// ----  标签栏高度
#define kTabBarHeight (kIsBangsScreen?83:49)
// ----  刘海屏底部栏的高度
#define kBottomBarHeight (kIsBangsScreen?34:0)

// ---- 弱强引用
#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif

// ----  hex颜色
#define kColorWithRGB16Radix(rgbValue) ([UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0])
// ----  hex颜色及透明度
#define kColorWithRGB16RadixA(rgbValue, a) ([UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a])
// ----  rgb颜色及透明度
#define kColorWithRGB(r,g,b) (kColorWithRGBA(r,g,b,1.0f))
// ----  rgb颜色
#define kColorWithRGBA(r,g,b,a) ([UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a])
// ----  根据名字设置颜色
#define kColorWithName(name) ([UIColor name##Color])
// ----  透明颜色
#define kColorWithNull ([UIColor clearColor])
// ----  随机颜色
#define kColorWithRandom ([UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0])
// ----  图片生成颜色
#define kColorWithImage(image) ([UIColor colorWithPatternImage:image])

// ----  自定义透明度颜色,不会作用在子视图
#define kColorWithOpacity(color, alpha) [color colorWithAlphaComponent:alpha]

// ----  本地图片
#define kImageWithName(name) [UIImage imageNamed:(name)]
// ----  网络图片
#define kImageWithUrl(url) [NSURL URLWithString:url]


// ----  判断ipad
#define kiPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
// ----  判断iPhone5 5s
#define kiPhone5s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) && !kiPad : NO)
// ----  判断iPhone6 6s 7 8
#define kiPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) && !kiPad : NO)
// ----  判断iPhone6p 6sp 7p 8p
#define kiPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) && !kiPad : NO)
// ----  判断iPhoneX iPhoneXS
#define kiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !kiPad : NO)
// ----  判断iPhoneXS MAX
#define kiPhoneXSMAX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !kiPad : NO)
// ----  判断iPhoneXR
#define kiPhoneXR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)

// ----  判断12.9 ipadPro
#define kIpadPro129 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(2048, 2732), [[UIScreen mainScreen] currentMode].size) && kiPad : NO)
// ----  判断11 ipadPro
#define kIpadPro11 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1668, 2388), [[UIScreen mainScreen] currentMode].size) && kiPad : NO)
// ----  判断10.5 ipadPro
#define kIpadPro105 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1668, 2224), [[UIScreen mainScreen] currentMode].size) && kiPad : NO)
// ----  判断9.7 ipad
#define kIpad97 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1536, 2048), [[UIScreen mainScreen] currentMode].size) && kiPad : NO)

// ----  GCD - 一次性执行  使用方法:kDISPATCH_ONCE_BLOCK(^{  });
#define kDISPATCH_ONCE_BLOCK(onceBlock) static dispatch_once_t onceToken; dispatch_once(&onceToken, onceBlock);
// ----  GCD - 在Main线程上运行  使用方法:kDISPATCH_MAIN_THREAD(^{  });
#define kDISPATCH_MAIN_THREAD(mainQueueBlock) dispatch_async(dispatch_get_main_queue(), mainQueueBlock);
// ----  GCD - 开启异步线程  使用:kDISPATCH_GLOBAL_QUEUE_DEFAULT(^{  });
#define kDISPATCH_GLOBAL_QUEUE_DEFAULT(globalQueueBlock) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), globalQueueBlocl);

// ----  获取沙盒 Home目录
#define kPathHome NSHomeDirectory()
// ----  获取沙盒 Library
#define kPathLibrary [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject]
// ----  获取沙盒 Document
#define kPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
// ----  获取沙盒 Cache
#define kPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]
// ----  获取 Temp
#define kPathTemp NSTemporaryDirectory()

// ----  屏幕大小
#ifndef kScreenRect
#define kScreenRect [UIScreen mainScreen].bounds
#endif

// ----  屏幕分辨率
#ifndef kScreenResolutio
#define kScreenResolutio (SCREEN_WIDTH * SCREEN_HEIGHT * [UIScreen mainScreen].scale)
#endif

// ----  宽
#ifndef kScreenWidth
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#endif

// ----  高
#ifndef kScreenHeight
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#endif

// ----  Application
#define kApplication [UIApplication sharedApplication]

// ----  AppDelegate
#define kAppDelegate [[UIApplication sharedApplication] delegate]

// ----  UserDefaults
#define kUserDefaults [NSUserDefaults standardUserDefaults]

// ----  NotificationCenter
#define kNotificationCenter [NSNotificationCenter defaultCenter]

// ----  KeyWindow
#define kKeyWindow [[[UIApplication sharedApplication] windows] objectAtIndex:0]

// ----  App名称
#define kAppName [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]

// ----  项目包名
#define kAppBundleId ([[NSBundle mainBundle] bundleIdentifier] ?: @"")

// ----  手机 iOS系统 版本号
#ifndef kSystemVersion
#define kSystemVersion [[[UIDevice currentDevice] systemVersion] floatValue]
#endif

// ----  获取 APP Version 版本号
#define kAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
// ----  获取 APP Build 版本号
#define kBuildVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]


// ----  字符串是否为空
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO)
// ----  数组是否为空
#define kArrayIsEmpty(array) ((array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0) ? YES : NO)
// ----  字典是否为空
#define kDictIsEmpty(dic) ((dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0) ? YES : NO)
// ----  对象是否为空
#define kObjectIsEmpty(object) ((object == nil \
|| [object isKindOfClass:[NSNull class]] \
|| ([object respondsToSelector:@selector(length)] && [(NSData *)object length] == 0) \
|| ([object respondsToSelector:@selector(count)] && [(NSArray *)object count] == 0)) ? YES : NO)

// ----  获取当前方法名称
#define kMethodName  __PRETTY_FUNCTION__

// ----  获取当前语言名称
#define kLanguageName ([[NSLocale preferredLanguages] firstObject])


// ----  DeBug下打印，Release下不打印
#ifdef DEBUG
#define kLog(...) printf("[%s] %s [第%d行]: %s\n", __TIME__ ,__PRETTY_FUNCTION__ ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String])
#else
#define kLog(...)
#endif

// ----  拼接字符串
#define NSStringFormat(format,...) [NSString stringWithFormat:format,##__VA_ARGS__]

// ----  ---- 消除警告⚠️
#define kMJPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wdeprecated-declarations\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)


#endif /* XYHelperMarco_h */
