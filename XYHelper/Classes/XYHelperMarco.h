//
//  XYHelperMarco.h
//  XYHelper
//
//  Created by spikeroog on 2020/8/13.
//  Copyright © 2020 spikeroog. All rights reserved.
//

#ifndef XYHelperMarco_h
#define XYHelperMarco_h

#import <os/lock.h>
#import <libkern/OSAtomic.h>
#import "XYmetamacros.h"

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
// ----  获取 APP Bundle Id
#define kAppBundleIdentifier [[NSBundle mainBundle] bundleIdentifier]


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




//#pragma mark - leaks
//
///**
// * \@onExit defines some code to be executed when the current scope exits. The
// * code must be enclosed in braces and terminated with a semicolon, and will be
// * executed regardless of how the scope is exited, including from exceptions,
// * \c goto, \c return, \c break, and \c continue.
// *
// * Provided code will go into a block to be executed later. Keep this in mind as
// * it pertains to memory management, restrictions on assignment, etc. Because
// * the code is used within a block, \c return is a legal (though perhaps
// * confusing) way to exit the cleanup block early.
// *
// * Multiple \@onExit statements in the same scope are executed in reverse
// * lexical order. This helps when pairing resource acquisition with \@onExit
// * statements, as it guarantees teardown in the opposite order of acquisition.
// *
// * @note This statement cannot be used within scopes defined without braces
// * (like a one line \c if). In practice, this is not an issue, since \@onExit is
// * a useless construct in such a case anyways.
// */
//#define onExit \
//    xyh_keywordify \
//    __strong xyh_cleanupBlock_t metamacro_concat(xyh_exitBlock_, __LINE__) __attribute__((cleanup(xyh_executeCleanupBlock), unused)) = ^
//
///**
// * Creates \c __weak shadow variables for each of the variables provided as
// * arguments, which can later be made strong again with #strongify.
// *
// * This is typically used to weakly reference variables in a block, but then
// * ensure that the variables stay alive during the actual execution of the block
// * (if they were live upon entry).
// *
// * See #strongify for an example of usage.
// */
//#define weakify(...) \
//    xyh_keywordify \
//    metamacro_foreach_cxt(xyh_weakify_,, __weak, __VA_ARGS__)
//
///**
// * Like #weakify, but uses \c __unsafe_unretained instead, for targets or
// * classes that do not support weak references.
// */
//#define unsafeify(...) \
//    xyh_keywordify \
//    metamacro_foreach_cxt(xyh_weakify_,, __unsafe_unretained, __VA_ARGS__)
//
///**
// * Strongly references each of the variables provided as arguments, which must
// * have previously been passed to #weakify.
// *
// * The strong references created will shadow the original variable names, such
// * that the original names can be used without issue (and a significantly
// * reduced risk of retain cycles) in the current scope.
// *
// * @code
//
//    id foo = [[NSObject alloc] init];
//    id bar = [[NSObject alloc] init];
//
//    @weakify(foo, bar);
//
//    // this block will not keep 'foo' or 'bar' alive
//    BOOL (^matchesFooOrBar)(id) = ^ BOOL (id obj){
//        // but now, upon entry, 'foo' and 'bar' will stay alive until the block has
//        // finished executing
//        @strongify(foo, bar);
//
//        return [foo isEqual:obj] || [bar isEqual:obj];
//    };
//
// * @endcode
// */
//#define strongify(...) \
//    xyh_keywordify \
//    _Pragma("clang diagnostic push") \
//    _Pragma("clang diagnostic ignored \"-Wshadow\"") \
//    metamacro_foreach(xyh_strongify_,, __VA_ARGS__) \
//    _Pragma("clang diagnostic pop")
//
///*** implementation details follow ***/
//typedef void (^xyh_cleanupBlock_t)(void);
//
//static inline void xyh_executeCleanupBlock (__strong xyh_cleanupBlock_t *block) {
//    (*block)();
//}
//
//#define xyh_weakify_(INDEX, CONTEXT, VAR) \
//    CONTEXT __typeof__(VAR) metamacro_concat(VAR, _weak_) = (VAR);
//
//#define xyh_strongify_(INDEX, VAR) \
//    __strong __typeof__(VAR) VAR = metamacro_concat(VAR, _weak_);
//
//// Details about the choice of backing keyword:
////
//// The use of @try/@catch/@finally can cause the compiler to suppress
//// return-type warnings.
//// The use of @autoreleasepool {} is not optimized away by the compiler,
//// resulting in superfluous creation of autorelease pools.
////
//// Since neither option is perfect, and with no other alternatives, the
//// compromise is to use @autorelease in DEBUG builds to maintain compiler
//// analysis, and to use @try/@catch otherwise to avoid insertion of unnecessary
//// autorelease pools.
//#if DEBUG
//#define xyh_keywordify autoreleasepool {}
//#else
//#define xyh_keywordify try {} @catch (...) {}
//#endif


#endif /* XYHelperMarco_h */
