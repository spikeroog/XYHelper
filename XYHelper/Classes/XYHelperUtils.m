//
//  XYHelperUtils.m
//  XYHelper
//
//  Created by spikeroog on 2018/11/20.
//  Copyright © 2018 spikeroog. All rights reserved.
//

#import "XYHelperUtils.h"

#import <SAMKeychain/SAMKeychain.h>
#import <YYCategories/YYCategories.h>
#import <Masonry/Masonry.h>
#import <ReactiveObjC/ReactiveObjC.h>

#import "XYHelperRouter.h"
#import "UILabel+YBAttributeTextTapAction.h"
#import "UIImage+XYHelper.h"
#import "NSString+XYHelper.h"

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreText/CoreText.h>
#import <sys/utsname.h>
#import <objc/runtime.h>
#import <AdSupport/AdSupport.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <AudioToolbox/AudioToolbox.h>
#import "UIButton+EnlargeEdge.h"
#import "UIButton+XYHelper.h"

@implementation XYHelperUtils

#pragma mark - 判断字符串是否为空
+ (BOOL)isNull:(NSString *)string {
    if (string != nil && ![string isEqual:[NSNull null]] && string.length > 0) {
        return NO;
    } else {
        return YES;
    }
}

#pragma mark - 判断是否是刘海屏
/**
 判断是否是刘海屏
 iOS 10 以下 的系统肯定不是刘海屏
 @return 是否
 */
+ (BOOL)iPhoneNotchScreen {
    
    if (kSystemVersion < 11.0f)  return false;
    
    CGFloat iPhoneNotchDirectionSafeAreaInsets = 0;
    
    if (@available(iOS 11.0, *)) {
        UIEdgeInsets safeAreaInsets = [UIApplication sharedApplication].windows[0].safeAreaInsets;
        
        switch ([UIApplication sharedApplication].statusBarOrientation) {
            case UIInterfaceOrientationPortrait:{
                iPhoneNotchDirectionSafeAreaInsets = safeAreaInsets.top;
            }
                break;
            case UIInterfaceOrientationLandscapeLeft:{
                iPhoneNotchDirectionSafeAreaInsets = safeAreaInsets.left;
            }
                break;
            case UIInterfaceOrientationLandscapeRight:{
                iPhoneNotchDirectionSafeAreaInsets = safeAreaInsets.right;
            }
                break;
            case UIInterfaceOrientationPortraitUpsideDown:{
                iPhoneNotchDirectionSafeAreaInsets = safeAreaInsets.bottom;
            }
                break;
            default:
                iPhoneNotchDirectionSafeAreaInsets = safeAreaInsets.top;
                break;
        }
    } else {
        // Fallback on earlier versions
    }
    return iPhoneNotchDirectionSafeAreaInsets > 20;
}

#pragma mark - 判断app是否第一次启动或者appstore更新后第一次启动
/**
 判断app是否第一次启动或者更新后第一次启动
 
 @return 是否
 */
+ (BOOL)isApplicationFirstLoad {
    
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary]
                                objectForKey:@"CFBundleShortVersionString"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *lastRunVersion = [defaults objectForKey:@"XY_APP_FIRST_INSTALL"];
    
    if (!lastRunVersion) {
        [defaults setObject:currentVersion forKey:@"XY_APP_FIRST_INSTALL"];
        return YES;
    } else if (![lastRunVersion isEqualToString:currentVersion]) {
        [defaults setObject:currentVersion forKey:@"XY_APP_FIRST_INSTALL"];
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - 判断app是否第一次安装时启动
/**
 判断app是否第一次安装时启动
 
 @return 是否
 */
+ (BOOL)isApplicationFirstInstallLoad {
    
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary]
                                objectForKey:@"CFBundleShortVersionString"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *lastRunVersion = [defaults objectForKey:@"XY_APP_FIRST_INSTALL_ONLYONCE"];
    
    if (!lastRunVersion) {
        [defaults setObject:currentVersion forKey:@"XY_APP_FIRST_INSTALL_ONLYONCE"];
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - 系统alert或sheet
/**
 系统alert或sheet
 
 @param title 标题
 @param message 信息
 @param sureMessage 确认文案
 @param cancelMessage 取消文案
 @param thirdMessage 第三个文案
 @param style UIAlertControllerStyle风格 Alert和Sheet
 @param sureHandler 确认回调
 @param cancelHandler 取消回调
 @param thirdHandler 第三个按钮回调
 */
+ (void)showAlertWithTitle:(nullable NSString *)title
                   message:(nullable NSString *)message
               sureMessage:(nullable NSString *)sureMessage
             cancelMessage:(nullable NSString *)cancelMessage
              thirdMessage:(nullable NSString *)thirdMessage
                     style:(UIAlertControllerStyle)style
               sureHandler:(void (^)())sureHandler
             cancelHandler:(void (^)())cancelHandler
              thirdHandler:(void(^)())thirdHandler {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    
    if (sureMessage) {
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:sureMessage style:UIAlertActionStyleDefault handler:sureHandler];
        [alertController addAction:sureAction];
    }
    
    if (cancelMessage) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelMessage style:UIAlertActionStyleCancel handler:cancelHandler];
        [alertController addAction:cancelAction];
    }
    
    if (thirdMessage) {
        UIAlertAction *thirdBtn = [UIAlertAction actionWithTitle:thirdMessage style:UIAlertActionStyleDestructive handler:thirdHandler];
        [alertController addAction:thirdBtn];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[XYHelperRouter currentVC].self presentViewController:alertController animated:YES completion:nil];
    });
}

#pragma mark - 自定义alert或sheet
/**
 自定义alert或sheet
 
 @param title 标题
 @param message 信息
 @param sureMessage 确认文案
 @param cancelMessage 取消文案
 @param thridMessage 第三个按钮文案
 @param style UIAlertControllerStyle风格 Alert和Sheet
 @param sureHandler 确认回调
 @param cancelHandler 取消回调
 @param thirdHandler 第三个按钮回调
 @param sureColor 确认按钮颜色
 @param cancelColor 取消按钮颜色
 */
+ (void)showCustomAlertViewWithTitle:(nullable NSString *)title
                             message:(nullable NSString *)message
                         sureMessage:(nullable NSString *)sureMessage
                       cancelMessage:(nullable NSString *)cancelMessage
                        thirdMessage:(nullable NSString *)thirdMessage
                               style:(UIAlertControllerStyle)style
                         sureHandler:(void (^)())sureHandler
                       cancelHandler:(void (^)())cancelHandler
                        thirdHandler:(void(^)())thirdHandler
                           sureColor:(nullable UIColor *)sureColor
                         cancelColor:(nullable UIColor *)cancelColor {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    
    // 修改title
    if (title) {
        NSMutableAttributedString *alertControllerTitleStr = [[NSMutableAttributedString alloc] initWithString:title];
        [alertControllerTitleStr addAttribute:NSForegroundColorAttributeName value:kColorWithRGB16Radix(0x222222) range:NSMakeRange(0, title.length)];
        [alertControllerTitleStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:17] range:NSMakeRange(0, title.length)];
        [alertController setValue:alertControllerTitleStr forKey:@"attributedTitle"];
    }
    
    // 修改message
    if (message) {
        NSMutableAttributedString *alertControllerMessageStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"\n%@\n",message]];
        [alertControllerMessageStr addAttribute:NSForegroundColorAttributeName value:kColorWithRGB16Radix(0x222222) range:NSMakeRange(1, message.length)];
        [alertControllerMessageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(1, message.length)];
        [alertController setValue:alertControllerMessageStr forKey:@"attributedMessage"];
    }
    
    if (cancelMessage) {
        UIAlertAction *cancleBtn = [UIAlertAction actionWithTitle:cancelMessage style:UIAlertActionStyleCancel handler:
                                    cancelHandler];
        if (cancelColor) {
            [cancleBtn setValue:cancelColor forKey:@"_titleTextColor"];
        } else {
            [cancleBtn setValue:UIColor.grayColor forKey:@"_titleTextColor"];
        }
        [alertController addAction:cancleBtn];
    }
    
    if (sureMessage) {
        UIAlertAction *sureBtn = [UIAlertAction actionWithTitle:sureMessage style:UIAlertActionStyleDefault handler:sureHandler];
        if (sureColor) {
            [sureBtn setValue:sureColor forKey:@"_titleTextColor"];
        } else {
            [sureBtn setValue:UIColor.systemRedColor forKey:@"_titleTextColor"];
        }
        [alertController addAction:sureBtn];
    }
    
    if (thirdMessage) {
        UIAlertAction *thirdMessageBtn = [UIAlertAction actionWithTitle:thirdMessage style:UIAlertActionStyleDestructive handler:thirdHandler];
        if (cancelColor) {
            [thirdMessageBtn setValue:cancelColor forKey:@"_titleTextColor"];
        } else {
            [thirdMessageBtn setValue:kColorWithRGB16Radix(0x9A9A9A) forKey:@"_titleTextColor"];
        }
        [alertController addAction:thirdMessageBtn];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[XYHelperRouter currentVC].self presentViewController:alertController animated:YES completion:nil];
    });
}

#pragma mark - 显示单行单按钮alert
+ (void)showAlertWithTitle:(NSString *)title {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    dispatch_async(dispatch_get_main_queue(), ^{
        [[XYHelperRouter currentVC].self presentViewController:alertController animated:YES completion:nil];
    });
}

#pragma mark - 是否插入了耳机
/**
 获取设备状态，是否插入耳机
 
 @return 如果插入耳机，则返回“YES"
 */
+ (BOOL)isHeadsetPluggedIn {
    AVAudioSessionRouteDescription *route = [[AVAudioSession sharedInstance] currentRoute];
    for (AVAudioSessionPortDescription *desc in [route outputs]) {
        if ([[desc portType] isEqualToString:AVAudioSessionPortHeadphones] || [[desc portType] isEqualToString:AVAudioSessionPortBluetoothLE] || [[desc portType] isEqualToString:AVAudioSessionPortBluetoothA2DP] || [[desc portType] isEqualToString:AVAudioSessionPortBluetoothHFP])
            return YES;
    }
    return NO;
}

#pragma mark - 取得目录下所有文件
/**
 取得目录下所有文件
 
 @param dirString 目录绝对路径，沙盒在app每次启动后路径都会变，所以获取绝对路径需要每次都拼接，比如：
 [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:XXXPathKey]
 @return 文件数组
 */
+ (NSArray *)allFilesAtPath:(NSString *)dirString {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:10];
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSArray *tempArray = [fileMgr contentsOfDirectoryAtPath:dirString error:nil];
    for (NSString *fileName in tempArray) {
        BOOL flag = YES;
        NSString *fullPath = [dirString stringByAppendingPathComponent:fileName];
        if ([fileMgr fileExistsAtPath:fullPath isDirectory:&flag]) {
            if (!flag) {
                [array addObject:fullPath];
            }
        }
    }
    return array;
}

#pragma mark - 注册字体
/**
 注册字体
 下载回来的字体文件如果不做处理是不能直接使用的，使用前需要先注册然后才能使用，注册方式如下：
 @param fontPath 字体存储的绝对路径，沙盒在app每次启动后路径都会变，所以获取绝对路径需要每次都拼接，比如：
 [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:XXXPathKey]
 */
+ (void)registerFont:(NSString *)fontPath {
    NSData *dynamicFontData = [NSData dataWithContentsOfFile:fontPath];
    if (!dynamicFontData) {
        return;
    }
    CFErrorRef error;
    CGDataProviderRef providerRef = CGDataProviderCreateWithCFData((__bridge CFDataRef)dynamicFontData);
    CGFontRef font = CGFontCreateWithDataProvider(providerRef);
    if (! CTFontManagerRegisterGraphicsFont(font, &error)) {
        // 注册失败
        CFStringRef errorDescription = CFErrorCopyDescription(error);
        kLog(@"Failed to load font: %@", errorDescription);
        CFRelease(errorDescription);
    }
    CFRelease(font);
    CFRelease(providerRef);
}

#pragma mark - 银行键盘，键盘输入限制小数后两位
/**
 键盘输入限制小数后两位
 
 这样使用：
 @property (assign, nonatomic) BOOL isFirstChar; // 只需声明，不需要其他的操作，只有下面这一个方法使用到了self.isFirstChar
 
 - (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
 WEAKSELF
 if ([textField isEqual:self.TF]) { // 输入金额限制小数后两位
 BOOL resultType = [XYHelperUtils judgeTextMoneyTypeWithTextField:textField shouldChangeCharactersInRange:range replacementString:string isFirst:self.isFirstChar complete:^(BOOL isFirstChar) {
 weakSelf.isFirstChar = isFirstChar;
 } ];
 return resultType;
 }
 return YES;
 }
 
 @param textField 键盘
 @param range 范围
 @param string 字符
 @param dot 是否为第一个字符
 @param complete 返回是否是第一个字符，重新赋值全局变量
 @return 是否可以继续输入
 */
+ (BOOL)judgeTextMoneyTypeWithTextField:(UITextField *)textField
          shouldChangeCharactersInRange:(NSRange)range
                      replacementString:(NSString *)string
                                isFirst:(BOOL)dot
                               complete:(void (^)(BOOL isFirstChar))complete {
    // 最大位数
    int maxByte = 9;
    // 判断是否输入内容，或者用户点击的是键盘的删除按钮
    if (![string isEqualToString:@""]) {
        // 小数点在字符串中的位置 第一个数字从0位置开始
        NSInteger dotLocation = [textField.text rangeOfString:@"."].location;
        // 判断字符串中是否有小数点，并且小数点不在第一位
        // NSNotFound 表示请求操作的某个内容或者item没有发现，或者不存在
        // range.location 表示的是当前输入的内容在整个字符串中的位置，位置编号从0开始
        if (dotLocation == NSNotFound && range.location != 0) {
            // 取只包含“myDotNumbers”中包含的内容，其余内容都被去掉
            if (range.location >= maxByte) {
                kLog(@"单笔金额不能超过亿位");
                if ([string isEqualToString:@"."] && range.location == maxByte) {
                    return YES;
                }
                return NO;
            } else {
                if (dot == YES) {
                    if ([string isEqualToString:@"."]) {
                        return YES;
                    }
                    return NO;
                } else {
                    NSString *first = [textField.text substringFromIndex:0];
                    if ([first isEqualToString:@"0"]) {
                        if ([string isEqualToString:@"."]) {
                            return YES;
                        }
                        return NO;
                    } else {
                        return YES;
                    }
                }
            }
        } else {
            if ([string isEqualToString:@"."]) {
                NSString *first = [textField.text substringFromIndex:0];
                if ([first isEqualToString:@"0"]) {
                    textField.text = @"0";
                } else if ([first isEqualToString:@""]) {
                    textField.text = @"0";
                } else {
                    if ([string isEqualToString:@"."]) {
                        return NO;
                    }
                    return YES;
                }
            }
            if ([string isEqualToString:@"0"]) {
                dot = YES;
                complete(dot);
            } else {
                dot = NO;
                complete(dot);
            }
        }
        if (dotLocation != NSNotFound && range.location > dotLocation + 2) {
            return NO;
        }
        if (textField.text.length > 11) {
            return NO;
        }
    }
    return YES;
}

#pragma mark - 绘制部分圆角
/**
 使用CAShapeLayer和UIBezierPath，绘制部分圆角
 
 @param targetView 目标View
 @param drawTopLeft 是否绘制上左
 @param drawTopRight 是否绘制上右
 @param drawBottomLeft 是否绘制下左
 @param drawBottomRight 是否绘制下右
 @param cornerRadius 圆角数值
 */
+ (void)advancedEfficientDrawBead:(__kindof UIView *)targetView
                      drawTopLeft:(BOOL)drawTopLeft
                     drawTopRight:(BOOL)drawTopRight
                   drawBottomLeft:(BOOL)drawBottomLeft
                  drawBottomRight:(BOOL)drawBottomRight
                     cornerRadius:(CGFloat)cornerRadius {
    [targetView layoutIfNeeded];
    
    CGSize cornerRadii = CGSizeMake(cornerRadius, cornerRadius);
    UIRectCorner topLeftcorner = MAX_INPUT;
    UIRectCorner topRightcorner = MAX_INPUT;
    UIRectCorner bottomLeftcorner = MAX_INPUT;
    UIRectCorner bottomRightcorner = MAX_INPUT;
    if (drawTopLeft) topLeftcorner = UIRectCornerTopLeft;
    if (drawTopRight) topRightcorner = UIRectCornerTopRight;
    if (drawBottomLeft) bottomLeftcorner = UIRectCornerBottomLeft;
    if (drawBottomRight) bottomRightcorner = UIRectCornerBottomRight;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:targetView.bounds byRoundingCorners:topLeftcorner|topRightcorner|bottomLeftcorner|bottomRightcorner cornerRadii:cornerRadii];
    // CAShapeLayer属于CoreAnimation框架，通过GPU来渲染图形，不消耗内存，节省性能
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = targetView.bounds;
    maskLayer.path = maskPath.CGPath;
    targetView.layer.mask = maskLayer;
}

#pragma mark - 字符串转颜色
/**
 字符串转颜色
 
 @param hexColorStr rgb16进制字符串
 @return 颜色
 */
+ (UIColor *)hexColor:(NSString *)hexColorStr {
    unsigned int red, green, blue, alpha;
    NSRange range;
    range.length = 2;
    @try {
        if ([hexColorStr hasPrefix:@"#"]) {
            hexColorStr = [hexColorStr stringByReplacingOccurrencesOfString:@"#" withString:@""];
        }
        range.location = 0;
        [[NSScanner scannerWithString:[hexColorStr substringWithRange:range]] scanHexInt:&red];
        range.location = 2;
        [[NSScanner scannerWithString:[hexColorStr substringWithRange:range]] scanHexInt:&green];
        range.location = 4;
        [[NSScanner scannerWithString:[hexColorStr substringWithRange:range]] scanHexInt:&blue];
        if ([hexColorStr length] > 6) {
            range.location = 6;
            [[NSScanner scannerWithString:[hexColorStr substringWithRange:range]] scanHexInt:&alpha];
        }
    }
    @catch (NSException * e) {
        
    }
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green/255.0f) blue:(float)(blue/255.0f) alpha:(float)(1.0f)];
}

#pragma mark - 颜色转字符串
/**
 颜色转字符串
 
 @param hexColor 颜色
 @return rgb16进制字符串
 */
+ (NSString *)hexColorStr:(UIColor *)hexColor {
    CGColorRef color = hexColor.CGColor;
    size_t count = CGColorGetNumberOfComponents(color);
    const CGFloat *components = CGColorGetComponents(color);
    static NSString *stringFormat = @"#%02x%02x%02x";
    if (count == 2) {
        // Grayscale
        NSUInteger grey = (NSUInteger)(components[0] * (CGFloat)255);
        return [NSString stringWithFormat:stringFormat, grey, grey, grey];
    } else if (count == 4) {
        // RGB
        return [NSString stringWithFormat:stringFormat,
                (NSUInteger)(components[0] * (CGFloat)255),
                (NSUInteger)(components[1] * (CGFloat)255),
                (NSUInteger)(components[2] * (CGFloat)255)];
    }
    // Unsupported color space
    return nil;
}

#pragma mark - 校验邮箱格式是否正确
/**
 校验邮箱格式是否正确
 
 @param emailNum 邮箱号
 @return YES 通过 NO 不通过
 */
+ (BOOL)isAvailableEmailNumber:(NSString *)emailNum {
    emailNum = [emailNum stringByReplacingOccurrencesOfString:@" " withString:@""];

    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailNum];
}

#pragma mark - 校验身份证号码
/**
 校验身份证号码是否正确 返回BOOL值
 
 @param idCardNum 身份证号码
 @return YES 通过 NO 不通过
 */
+ (BOOL)isAvailableIDCardNumber:(NSString *)idCardNum {
    idCardNum = [idCardNum stringByReplacingOccurrencesOfString:@" " withString:@""];

    NSString *regex = @"^[1-9]\\d{5}(18|19|([23]\\d))\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{3}[0-9Xx]$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL isRe = [predicate evaluateWithObject:idCardNum];
    if (!isRe) {
        // 身份证号码格式不对
        return NO;
    }
    
    // 加权因子 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2
    NSArray *weightingArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    // 校验码 1, 0, 10, 9, 8, 7, 6, 5, 4, 3, 2
    NSArray *verificationArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    
    NSInteger sum = 0; // 保存前17位各自乖以加权因子后的总和
    for (int i = 0; i < weightingArray.count; i++) { // 将前17位数字和加权因子相乘的结果相加
        NSString *subStr = [idCardNum substringWithRange:NSMakeRange(i, 1)];
        sum += [subStr integerValue] * [weightingArray[i] integerValue];
    }
    
    NSInteger modNum = sum % 11; // 总和除以11取余
    NSString *idCardMod = verificationArray[modNum]; // 根据余数取出校验码
    NSString *idCardLast = [idCardNum.uppercaseString substringFromIndex:17]; // 获取身份证最后一位
    
    if (modNum == 2) { // 等于2时 idCardMod为10  身份证最后一位用X表示10
        idCardMod = @"X";
    }
    if ([idCardLast isEqualToString:idCardMod]) { // 身份证号码验证成功
        return YES;
    } else { // 身份证号码验证失败
        return NO;
    }
}

#pragma mark - 校验银行卡号是否正确
/**
 校验银行卡号是否正确
 
 @param cardNum 银行卡
 @return YES 通过 NO 不通过
 */
+ (BOOL)isAvailableBankCardNumber:(NSString *)cardNum {
    cardNum = [cardNum stringByReplacingOccurrencesOfString:@" " withString:@""];

    int oddSum = 0;     // 奇数和
    int evenSum = 0;    // 偶数和
    int allSum = 0;     // 总和
    // 循环加和
    for (NSInteger i = 1; i <= cardNum.length; i++) {
        NSString *theNumber = [cardNum substringWithRange:NSMakeRange(cardNum.length-i, 1)];
        int lastNumber = [theNumber intValue];
        if (i % 2 == 0) {
            // 偶数位
            lastNumber *= 2;
            if (lastNumber > 9) {
                lastNumber -= 9;
            }
            evenSum += lastNumber;
        } else {
            // 奇数位
            oddSum += lastNumber;
        }
    }
    allSum = oddSum + evenSum;
    // 是否合法
    if (allSum % 10 == 0) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - 校验手机号码是否正确，想要知道最新的手机号码号段，请百度搜‘手机号码’查看百度百科
/**
 校验手机号码是否正确
 FBI Warning：想要知道最新的手机号码号段，请百度搜‘手机号码’查看百度百科
 当前已适配最新号段，适配日期：2022/11/09
 
 1、中国电信号段
 133、149、153、173、177、180、181、189、190、191、193、199
 2、中国联通号段
 130、131、132、145、155、156、166、167、171、175、176、185、186、196
 3、中国移动号段
 134(0-8)、135、136、137、138、139、1440、147、148、150、151、152、157、158、159、172、178、182、183、184、187、188、195、197、198
 
 @param mobileNum 手机号
 @return YES 通过 NO 不通过
 */
+ (BOOL)isAvailableContactNumber:(NSString *)mobileNum {
    mobileNum = [mobileNum stringByReplacingOccurrencesOfString:@" " withString:@""];

    /// 所有手机号段，包括虚拟手机号：如170，190等，192为中国广电号段
    NSString *MOBILE = @"^1(3[0-9]|4[5-9]|5[0-35-9]|6[67]|7[0-35-78]|8[0-9]|9[0-35-9]|440)\\d{8}$";
    /// 中国移动号段
    NSString *CM = @"(^1(3[4-9]|4[78]|5[0-27-9]|7[28]|8[2-478]|9[578]|440)\\d{8}$)|(^1705\\d{7}$)";
    /// 中国联通号段
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|6[67]|7[156]|8[56]|9[6])\\d{8}$)|(^1709\\d{7}$)";
    /// 中国电信号段
    NSString *CT = @"(^1(33|49|53|7[37]|8[019]|9[0139])\\d{8}$)|(^1700\\d{7}$)";
    /**
     * 大陆地区固话及小灵通
     * 区号：010,020,021,022,023,024,025,027,028,029
     * 号码：七位或八位
     */
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES)) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - 获取磁盘总空间
// 磁盘总空间
+ (CGFloat)diskOfAllSizeMBytes {
    CGFloat size = 0.0;
    NSError *error;
    NSDictionary *dic = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) {
        kLog(@"error: %@", error.localizedDescription);
    } else {
        NSNumber *number = [dic objectForKey:NSFileSystemSize];
        size = [number floatValue]/1024/1024;
    }
    return size;
}

#pragma mark - 获取磁盘可用空间大小
// 磁盘可用空间
+ (CGFloat)diskOfFreeSizeMBytes {
    CGFloat size = 0.0;
    NSError *error;
    NSDictionary *dic = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) {
        kLog(@"error: %@", error.localizedDescription);
    } else {
        NSNumber *number = [dic objectForKey:NSFileSystemFreeSize];
        size = [number floatValue]/1024/1024;
    }
    return size;
}

#pragma mark - 获取指定路径下某个文件的大小
// 获取指定路径下某个文件的大小
+ (long long)fileSizeAtPath:(NSString *)filePath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:filePath]) return 0;
    return [[fileManager attributesOfItemAtPath:filePath error:nil] fileSize];
}

#pragma mark - 获取文件夹下所有文件的大小
// 获取文件夹下所有文件的大小
+ (long long)folderSizeAtPath:(NSString *)folderPath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *filesEnumerator = [[fileManager subpathsAtPath:folderPath] objectEnumerator];
    NSString *fileName;
    long long folerSize = 0;
    while ((fileName = [filesEnumerator nextObject]) != nil) {
        NSString *filePath = [folderPath stringByAppendingPathComponent:fileName];
        folerSize += [self fileSizeAtPath:filePath];
    }
    return folerSize;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

#pragma mark - 跳转appStore
+ (void)gotoAppStoreWithAppleId:(NSString *)appleId {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://itunes.apple.com/cn/app/id%@?mt=8", appleId]]];
}

#pragma mark - 跳转appStore评分
+ (void)gotoAppStoreGradeWithAppleId:(NSString *)appleId {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/us/app/itunes-u/id%@?action=write-review&mt=8", appleId]]];
}

#pragma clang diagnostic pop

#pragma mark - 判断string中是否含有中文字符
// 判断string中是否含有中文字符
+ (BOOL)haveChinese:(NSString *)string {
    for (int i = 0; i < [string length]; i++) {
        int a = [string characterAtIndex:i];
        if (a > 0x4e00 && a < 0x9fff) {
            return YES;
        }
    }
    return NO;
}

#pragma mark - 判断越狱机器,因为越狱的设备都会安装有cydia
// 判断越狱机器,因为越狱的设备都会安装有cydia
+ (BOOL)isJailBreak {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://"]]) {
        kLog(@"The device is jail broken!");
        return YES;
    } else {
        kLog(@"The device is NOT jail broken!");
        return NO;
    }
}

#pragma mark - 图片转字符串
// 图片转字符串
+ (NSString *)UIImageToBase64Str:(UIImage *)image {
    NSData *data = UIImageJPEGRepresentation(image, 1.0f);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return encodedImageStr;
}

#pragma mark - 字符串转图片
// 字符串转图片
+ (UIImage *)Base64StrToUIImage:(NSString *)encodedImageStr {
    NSData *decodedImageData = [[NSData alloc] initWithBase64EncodedString:encodedImageStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *decodedImage = [UIImage imageWithData:decodedImageData];
    return decodedImage;
}

#pragma mark - 获取当前时间戳
+ (NSNumber *)currentTimeInterval {
    // 获取当前时间0秒后的时间
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    // *1000 是精确到毫秒，不乘就是精确到秒
    NSTimeInterval time = [date timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    
    NSNumber *timeNumber = @([timeString longLongValue]);
    
    return timeNumber;
}

#pragma mark - 获取当前时间
/**
 获取当前时间
 
 @param dateFormat 如:@"yyyy-MM-dd HH:mm:ss"
 @return date
 */
+ (NSString *)currentTimes:(NSString *)dateFormat {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    [formatter setDateFormat:dateFormat];
    // 现在时间,你可以输出来看下是什么格式
    NSDate *datenow = [NSDate date];
    // ----------将nsdate按formatter格式转成nsstring
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    return currentTimeString;
}

#pragma mark - 获取当前网络时间
/// 获取网络时间
+ (NSString *)getCurrentNetworkTime:(NSString *)dateFormat {
    NSString *urlString = @"https://www.baidu.com";
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString: urlString]];
    [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    [request setTimeoutInterval: 2];
    [request setHTTPShouldHandleCookies:FALSE];
    [request setHTTPMethod:@"GET"];
    NSHTTPURLResponse *response;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    //NSLog(@">>>>> response :%@",response);
    NSString *date = [[response allHeaderFields] objectForKey:@"Date"];
    
    //NSLog(@">>>>> date :%@",date);
    date = [date substringFromIndex:5];
    date = [date substringToIndex:[date length]-4];
    //NSLog(@">>>>> date :%@",date);
    NSDateFormatter *dMatter = [[NSDateFormatter alloc] init];
    dMatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    //    dMatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh-CHS"];
    [dMatter setDateFormat:@"dd MMM yyyy HH:mm:ss"];
    NSDate *netDate = [[dMatter dateFromString:date] dateByAddingTimeInterval:60*60*8];
    NSString *timeStr = [XYHelperUtils dateConversionTimeStamp:netDate];
    return [XYHelperUtils timeToStrFrom:timeStr dateformat:dateFormat];
}

#pragma mark - 时间转换成时间戳
/**
 时间转换成时间戳
 
 @param timeString 时间
 @return 时间戳
 */
+ (NSTimeInterval)strToTimeIntervalFrom:(NSString *)timeString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // 设置时区
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate* date = [formatter dateFromString:timeString];
    return [date timeIntervalSince1970];
}

#pragma mark - 时间戳转换成时间
/**
 时间戳转换成时间
 
 @param timeStamp 时间戳
 @return 时间
 */
+ (NSString *)timeToStrFrom:(NSString *)timeStamp {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeStamp longLongValue]/1000];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}

+ (NSString *)timeToStrFrom:(NSString *)timeStamp
                 dateformat:(NSString *)dateformat {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeStamp longLongValue]/1000];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyy-MM-dd"];
    [formatter setDateFormat:dateformat];
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}

// NSDate转时间戳
+ (NSString *)dateConversionTimeStamp:(NSDate *)date {
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]*1000];
    return timeSp;
}

// 2019-12-31 23:59:59 转 NSDate
+ (NSDate *)nsstringConversionNSDate:(NSString *)dateStr {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *datestr = [dateFormatter dateFromString:dateStr];
    return datestr;
}

#pragma mark - 顺时针视图旋转N度
/**
 视图旋转N度
 
 @param targetView 视图
 @param rotationAngle 顺时针旋转角度
 */
+ (void)rotationTransformWithView:(__kindof UIView *)targetView
                    rotationAngle:(CGFloat)rotationAngle {
    CGAffineTransform dubTransform = CGAffineTransformMakeRotation(rotationAngle * M_PI/180.0f);
    [targetView setTransform:dubTransform];
}

#pragma mark - 定时器
/**
 定时器
 执行次数（time）* 时间间隔（interval） = 总耗时长
 @param time 执行次数
 @param interval 时间间隔
 @param countingHandle 每次执行完毕的回调
 @param finishHandle 结束时候的回调
 */
+ (void)createTimerWithTimeout:(NSInteger)time
                      interval:(CGFloat)interval
                countingHandle:(void(^)(NSInteger count))countingHandle
                  finishHandle:(void(^)())finishHandle {
    
    __block NSInteger timeout = time;
    // 获取全局队列
    dispatch_queue_t global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    // 创建一个定时器，并将定时器的任务交给全局队列执行(并行，不会造成主线程阻塞)
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, global);
    // 设置触发的间隔时间
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, interval * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    // 设置定时器的触发事件
    dispatch_source_set_event_handler(timer, ^{
        timeout--;
        if (timeout <= 0) {
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                finishHandle();
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                countingHandle(timeout);
            });
        }
    });
    // 取消定时循环计时器；使得句柄被调用，即事件被执行
    dispatch_resume(timer);
}

#pragma mark - 给视图添加抖动动画
/**
 抖动动画
 
 @param targetView view
 */
+ (void)loadShakeAnimationForView:(__kindof UIView *)targetView {
    
#define ANGLE_TO_RADIAN(angle) ((angle)/180.0 * M_PI)
    
    // 实例化
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    // 拿到动画 key
    anim.keyPath = @"transform.rotation";
    // 动画时间
    anim.duration = .25;
    // 重复的次数
    anim.repeatCount = MAXFLOAT;
    // 设置抖动数值
    anim.values = @[@(ANGLE_TO_RADIAN(-5)),@(ANGLE_TO_RADIAN(5)),@(ANGLE_TO_RADIAN(-5))];
    // 保持最后的状态
    anim.removedOnCompletion =NO;
    // 动画的填充模式
    anim.fillMode = kCAFillModeForwards;
    // layer层实现动画
    [targetView.layer addAnimation:anim forKey:@"shake"];
}

#pragma mark - 根据宽度求高度
//根据宽度求高度  content 计算的内容  width 计算的宽度 font字体大小
+ (CGFloat)getLabelHeightWithText:(NSString *)text
                            width:(CGFloat)width
                         fontSize:(CGFloat)fontSize {
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kFontWithSize(fontSize)} context:nil];
    
    return rect.size.height;
}

#pragma mark - 根据高度求宽度
//根据高度求宽度  text 计算的内容  Height 计算的高度 font字体大小
+ (CGFloat)getWidthWithText:(NSString *)text
                     height:(CGFloat)height
                   fontSize:(CGFloat)fontSize {
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:kFontWithSize(fontSize)}
                                     context:nil];
    return rect.size.width;
}

/**
 阿拉伯数字转大写中文
 
 @param num 如：100.11
 @return 壹佰元壹角壹分
 */
+ (NSString *)fetchAmountChineseStrWithNumber:(CGFloat)num {
    // 使用NSNumber的numberWithString进行精确转换
    NSNumber *numB = [NSNumber numberWithString:[NSString stringWithFormat:@"%.2f", num]];
    // 设置数据格式
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    // NSLocale的意义是将货币信息、标点符号、书写顺序等进行包装，如果app仅用于中国区应用，为了保证当用户修改语言环境时app显示语言一致，则需要设置NSLocal（不常用）
    numberFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    // 全拼格式
    [numberFormatter setNumberStyle:NSNumberFormatterSpellOutStyle];
    // 小数点后最少位数
    [numberFormatter setMinimumFractionDigits:2];
    // 小数点后最多位数
    [numberFormatter setMaximumFractionDigits:2];
    [numberFormatter setFormatterBehavior:NSNumberFormatterBehaviorDefault];
    //
    NSString *formattedNumberString = [numberFormatter stringFromNumber:numB];
    // 通过NSNumberFormatter转换为大写的数字格式 eg:一千二百三十四
    // 替换大写数字转为金额
    formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"一" withString:@"壹"];
    formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"二" withString:@"贰"];
    formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"三" withString:@"叁"];
    formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"四" withString:@"肆"];
    formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"五" withString:@"伍"];
    formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"六" withString:@"陆"];
    formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"七" withString:@"柒"];
    formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"八" withString:@"捌"];
    formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"九" withString:@"玖"];
    formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"〇" withString:@"零"];
    formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"千" withString:@"仟"];
    formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"百" withString:@"佰"];
    formattedNumberString = [formattedNumberString stringByReplacingOccurrencesOfString:@"十" withString:@"拾"];
    // 对小数点后部分单独处理
    // rangeOfString 前面的参数是要被搜索的字符串，后面的是要搜索的字符
    if ([formattedNumberString rangeOfString:@"点"].length > 0){
        // 将“点”分割的字符串转换成数组，这个数组有两个元素，分别是小数点前和小数点后
        NSArray* arr = [formattedNumberString componentsSeparatedByString:@"点"];
        // 如果对一不可变对象复制，copy是指针复制（浅拷贝）和mutableCopy就是对象复制（深拷贝）。如果是对可变对象复制，都是深拷贝，但是copy返回的对象是不可变的。
        // 这里指的是深拷贝
        NSMutableString* lastStr = [[arr lastObject] mutableCopy];
        kLog(@"---%@---长度%ld", lastStr, lastStr.length);
        if (lastStr.length >= 2) {
            // 在最后加上“分”
            [lastStr insertString:@"分" atIndex:lastStr.length];
            
        }
        if (![[lastStr substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"零"]) {
            
            // 在小数点后第一位后边加上“角”
            [lastStr insertString:@"角" atIndex:1];
            
        }
        // 在小数点左边加上“元”
        formattedNumberString = [[arr firstObject] stringByAppendingFormat:@"圆%@",lastStr];
        
    } else { // 如果没有小数点
        formattedNumberString = [formattedNumberString stringByAppendingString:@"圆整"];
        
    }
    return formattedNumberString;
}

#pragma mark - model转Json字符串，如果后台需要

// ---- start ----
/**
 model转json字符串
 需要导入YYCategories
 
 @param model model
 @return json字符串
 */
+ (NSString *)modelConvertToJson:(id)model {
    return [[self dicFromObject:model] jsonStringEncoded];
}

/**
 model数组转json字符串
 需要导入YYCategories
 
 @param modelArray model数组
 @return json字符串
 */
+ (NSString *)modelArrayConvertToJson:(NSArray *)modelArray {
    NSMutableArray *jsonArr = [[NSMutableArray alloc] init];
    [modelArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [jsonArr addObject:[[self dicFromObject:obj] jsonStringEncoded]];
    }];
    return [self objArrayToJSON:jsonArr];
}

// 把多个json字符串转为一个json字符串
+ (NSString *)objArrayToJSON:(NSArray *)array {
    NSString *jsonStr = @"[";
    for (NSInteger i = 0; i < array.count; ++i) {
        if (i != 0) {
            jsonStr = [jsonStr stringByAppendingString:@","];
        }
        jsonStr = [jsonStr stringByAppendingString:array[i]];
    }
    jsonStr = [jsonStr stringByAppendingString:@"]"];
    return jsonStr;
    
}

// model转化为字典
+ (NSDictionary *)dicFromObject:(NSObject *)object {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int count;
    objc_property_t *propertyList = class_copyPropertyList([object class], &count);
    
    for (int i = 0; i < count; i++) {
        objc_property_t property = propertyList[i];
        const char *cName = property_getName(property);
        NSString *name = [NSString stringWithUTF8String:cName];
        NSObject *value = [object valueForKey:name];//valueForKey返回的数字和字符串都是对象
        
        if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
            //string , bool, int ,NSinteger
            [dic setObject:value forKey:name];
            
        } else if ([value isKindOfClass:[NSArray class]] || [value isKindOfClass:[NSDictionary class]]) {
            //字典或字典
            [dic setObject:[self arrayOrDicWithObject:(NSArray*)value] forKey:name];
            
        } else if (value == nil) {
            //null
            //[dic setObject:[NSNull null] forKey:name];//这行可以注释掉?????
            
        } else {
            //model
            [dic setObject:[self dicFromObject:value] forKey:name];
        }
    }
    
    return [dic copy];
}

// 将可能存在model数组转化为普通数组
+ (id)arrayOrDicWithObject:(id)origin {
    if ([origin isKindOfClass:[NSArray class]]) {
        //数组
        NSMutableArray *array = [NSMutableArray array];
        for (NSObject *object in origin) {
            if ([object isKindOfClass:[NSString class]] || [object isKindOfClass:[NSNumber class]]) {
                //string , bool, int ,NSinteger
                [array addObject:object];
                
            } else if ([object isKindOfClass:[NSArray class]] || [object isKindOfClass:[NSDictionary class]]) {
                //数组或字典
                [array addObject:[self arrayOrDicWithObject:(NSArray *)object]];
                
            } else {
                //model
                [array addObject:[self dicFromObject:object]];
            }
        }
        
        return [array copy];
        
    } else if ([origin isKindOfClass:[NSDictionary class]]) {
        //字典
        NSDictionary *originDic = (NSDictionary *)origin;
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        for (NSString *key in originDic.allKeys) {
            id object = [originDic objectForKey:key];
            
            if ([object isKindOfClass:[NSString class]] || [object isKindOfClass:[NSNumber class]]) {
                //string , bool, int ,NSinteger
                [dic setObject:object forKey:key];
                
            } else if ([object isKindOfClass:[NSArray class]] || [object isKindOfClass:[NSDictionary class]]) {
                //数组或字典
                [dic setObject:[self arrayOrDicWithObject:object] forKey:key];
                
            } else {
                //model
                [dic setObject:[self dicFromObject:object] forKey:key];
            }
        }
        return [dic copy];
    }
    return [NSNull null];
}


#pragma mark - 计算视频大小和图片大小
/**
 计算图片的大小 单位：M
 图片是除以1000，视频时除以1024
 
 @param image 图片
 @return 大小
 */
+ (CGFloat)fetchImageSize:(UIImage *)image {
    NSData *imageData = UIImagePNGRepresentation(image);
//    CGFloat length = [imageData length]/1000/1000.0;
    CGFloat length = [imageData length]/1024/1024.0;
    return length;
}

/// 返回图片大小，如:1.3M
+ (NSString *)getStringBytesFromDataLength:(UIImage *)image {
    NSInteger dataLength = UIImagePNGRepresentation(image).length;
    NSString *bytes;
    if (dataLength >= 0.1 * (1024 * 1024)) {
        bytes = [NSString stringWithFormat:@"%0.1fM",dataLength/1024/1024.0];
    } else if (dataLength >= 1024) {
        bytes = [NSString stringWithFormat:@"%0.0fK",dataLength/1024.0];
    } else {
        bytes = [NSString stringWithFormat:@"%zdB",dataLength];
    }
    return bytes;
}

/**
 计算视频的大小 单位：M
 图片是除以1000，视频时除以1024
 
 @param videoPath 视频路径
 @return 大小
 */
+ (CGFloat)fetchVideoSize:(NSString *)videoPath {
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    float filesize = -1.0;
    if ([fileManager fileExistsAtPath:videoPath]) {
        NSDictionary *fileDic = [fileManager attributesOfItemAtPath:videoPath error:nil];//获取文件的属性
        unsigned long long size = [[fileDic objectForKey:NSFileSize] longLongValue];
        filesize = 1.0*size/1024/1024;
    }
    return filesize;
}

/**
 ios13获取textfield label的方法
 
 @param tf 目标textfield
 @return label
 */
+ (UILabel *)labelWithTextfield:(UITextField *)tf {
    Ivar ivar = class_getInstanceVariable([UITextField class], "_placeholderLabel");
    return object_getIvar(tf, ivar);
}

/// 获取现在时间，每个区块以字符串形式返回
+ (void)getPresentTime:(void(^)(NSString *year, NSString *month, NSString *day, NSString *hour, NSString *minute, NSString *second))completion {
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    //下面是单独获取每项的值
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear |NSCalendarUnitMonth |NSCalendarUnitDay |NSCalendarUnitWeekday |NSCalendarUnitHour |NSCalendarUnitMinute |NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:date];
    
    //星期 注意星期是从周日开始计算
    long week = [comps weekday];
    //年
    long year = [comps year];
    //月
    long month = [comps month];
    //日
    long day = [comps day];
    //时
    long hour = [comps hour];
    //分
    long minute = [comps minute];
    //秒
    long second = [comps second];
    
    completion([NSString stringWithFormat:@"%ld", year],[NSString stringWithFormat:@"%ld", month],[NSString stringWithFormat:@"%ld", day],[NSString stringWithFormat:@"%ld", hour],[NSString stringWithFormat:@"%ld", minute],[NSString stringWithFormat:@"%ld", second]);
    
}

/// 比较两个数组元素是否相等
/// @param arrayA 数组1
/// @param arrayB 数组2
+ (BOOL)compareArray:(NSArray *)arrayA
           isEqualTo:(NSArray *)arrayB {
    if (arrayA.count != arrayB.count) {
        return NO;
    }
    for (NSString *str in arrayA) {
        if (![arrayB containsObject:str]) {
            return NO;
        }
    }
    return YES;
}

/// iOS13 给textfield添加leftView，rightView
/// @param textfield textfield
/// @param viewSize viewSize
/// @param leftViewImageStr leftViewImageStr
/// @param rightViewImageStr rightViewImageStr
/// @param leftViewClick leftView点击回调
/// @param rightViewClick righView点击回调
+ (void)addViewWithTextfield:(__kindof UITextField *)textfield
                    viewSize:(CGSize)viewSize
            leftViewImageStr:(nullable NSString *)leftViewImageStr
           rightViewImageStr:(nullable NSString *)rightViewImageStr leftViewClick:(void(^)())leftViewClick
              rightViewClick:(void(^)())rightViewClick {
    
    /// masonry布局的对象，想要立即获得其布局的属性值，需要调用layoutIfNeeded方法
    [textfield layoutIfNeeded];
    
    if (leftViewImageStr.length > 0) {
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewSize.width, textfield.height)];
        UIImageView *leftImgV = [[UIImageView alloc] initWithImage:kImageWithName(leftViewImageStr)];
        leftImgV.contentMode = UIViewContentModeScaleAspectFit;
        leftImgV.frame = CGRectMake(0, 0, viewSize.width, viewSize.height);
        leftImgV.centerY = textfield.height/2;
        [leftView addSubview:leftImgV];
        
        UITapGestureRecognizer *leftTap = [[UITapGestureRecognizer alloc] init];
        [[leftTap rac_gestureSignal] subscribeNext:^(id x) {
            leftViewClick();
        }];
        [leftView addGestureRecognizer:leftTap];
        
        textfield.leftView = leftView;
        textfield.leftViewMode = UITextFieldViewModeAlways;
    }
    
    if (rightViewImageStr.length > 0) {
        UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewSize.width, textfield.height)];
        
        UIImageView *rightImgV = [[UIImageView alloc] initWithImage:kImageWithName(rightViewImageStr)];
        rightImgV.contentMode = UIViewContentModeScaleAspectFit;
        rightImgV.frame = CGRectMake(0, 0, viewSize.width, viewSize.height);
        rightImgV.centerY = textfield.height/2;
        [rightView addSubview:rightImgV];
        
        UITapGestureRecognizer *rightTap = [[UITapGestureRecognizer alloc] init];
        [[rightTap rac_gestureSignal] subscribeNext:^(id x) {
            rightViewClick();
        }];
        [rightView addGestureRecognizer:rightTap];
        
        textfield.rightView = rightView;
        textfield.rightViewMode = UITextFieldViewModeAlways;
    }
}

/// 添加和中文有间距的下划线
/// @param fatherLabel 父label
+ (void)addUnderLineWithLabel:(__kindof UILabel *)fatherLabel {
    /// 添加和中文有间距的下划线
    UILabel *underLabel = [[UILabel alloc] init];
    underLabel.userInteractionEnabled = false;
    underLabel.numberOfLines = fatherLabel.numberOfLines;
    underLabel.textAlignment = fatherLabel.textAlignment;
    underLabel.backgroundColor = kColorWithNull;
    underLabel.textColor = kColorWithNull;
    NSDictionary *underAttribtDic = @{NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle],NSFontAttributeName:fatherLabel.font};
    NSMutableAttributedString *underAttr = [[NSMutableAttributedString alloc] initWithString:fatherLabel.text attributes:underAttribtDic];
    
    [underAttr addAttribute:NSForegroundColorAttributeName value:kColorWithNull range:NSMakeRange(0, fatherLabel.text.length)];
    [underAttr addAttribute:NSUnderlineColorAttributeName value:fatherLabel.textColor range:NSMakeRange(0, fatherLabel.text.length)];
    underLabel.attributedText = underAttr;
    [fatherLabel addSubview:underLabel];
    
    /// 4为中文和下划线的间距
    [underLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(fatherLabel);
    }];
    [underLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(fatherLabel.mas_top).offset(kRl(4));
    }];
}

#pragma mark - 快速创建用户隐私协议按钮，可带勾选框☑️
/// 使用方法:UIButton *btn = [XYHelperUtil createUserProButtonWithFullstring:xx];
/// 快速创建用户隐私协议按钮，可带勾选框☑️
/// @param fullstring 完整字符串
/// @param normalSelectTitle 正常颜色的可点击文字，如：@"登录即代表同意"
/// @param highlightSelectTitleArr 高亮颜色的可点击文字数组,如：@[@"用户协议",@"、",@"隐私声明"]
/// @param normalColor 正常文字颜色
/// @param highlightColor 高亮文字颜色
/// @param normalFont 正常文字字体大小
/// @param highlightFont 高亮文字字体大小
/// @param isShowCheck 是否显示勾选框
/// @param checkNormalImage 勾选框未选中颜色
/// @param checkHighlightImage 勾选框选中颜色
/// @param isDefaultCheck 是否默认勾选
/// @param completion 回调点击下标
+ (UIButton *)createUserProButtonWithFullstring:(NSString *)fullstring
                              normalSelectTitle:(NSString *)normalSelectTitle
                        highlightSelectTitleArr:(NSArray *)highlightSelectTitleArr
                                    normalColor:(UIColor *)normalColor
                                 highlightColor:(UIColor *)highlightColor
                                     normalFont:(CGFloat)normalFont
                                  highlightFont:(CGFloat)highlightFont
                                    isShowCheck:(BOOL)isShowCheck
                               checkNormalImage:(nullable UIImage *)checkNormalImage
                            checkHighlightImage:(nullable UIImage *)checkHighlightImage
                                 isDefaultCheck:(BOOL)isDefaultCheck completion:(void(^)(NSInteger idx))completion {
    
    __block UIButton * button = [[UIButton alloc] init];
    [button setEnlargeEdge:kRl(20)];

    NSString * showText;
    
    if (isShowCheck) {
        [button setImage:checkNormalImage forState:UIControlStateNormal];
        if (kIsBangsScreen || [[XYHelperUtils getAppTermModel] containsString:@"SE"]) {
            [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        } else {
            [button setTitleEdgeInsets:UIEdgeInsetsMake(kRl(5), 0, 0, 0)];
        }
        showText = [NSString stringWithFormat:@"   %@",fullstring];
        normalSelectTitle = [NSString stringWithFormat:@"   %@", normalSelectTitle];
    } else {
        showText = fullstring;
    }
    
    NSAttributedString * showAttString = [self getAttributeWith:highlightSelectTitleArr string:showText orginFont:normalFont orginColor:normalColor attributeFont:highlightFont attributeColor:highlightColor];
    [button setAttributedTitle:showAttString forState:UIControlStateNormal];
    button.titleLabel.numberOfLines = 0;
    button.titleLabel.enabledTapEffect = false;
    button.adjustsImageWhenHighlighted = false;
    
    
    __block UIButton *checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    checkBtn.backgroundColor = UIColor.clearColor;
    
    if (isShowCheck == NO) {
        checkBtn.hidden = YES;
    }
    
    RAC(button, selected) = RACObserve(checkBtn, selected);
    
    if (isDefaultCheck) {
        button.selected = YES;
        checkBtn.selected = YES;
        [button setImage:checkHighlightImage forState:UIControlStateNormal];

    } else {
        button.selected = NO;
        checkBtn.selected = NO;
        [button setImage:checkNormalImage forState:UIControlStateNormal];

    }

    [button addSubview:checkBtn];
    
    [checkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(kRl(30));
        make.height.equalTo(button);
        make.centerY.equalTo(button);
        make.left.equalTo(button).offset(kRl(25));
    }];
    [checkBtn setEnlargeEdge:kRl(20)];
    
    [checkBtn addGestureForButton:^{
        
        checkBtn.selected = !checkBtn.selected;
                
        if (isShowCheck) {
            if (checkBtn.selected) {
                [button setImage:checkHighlightImage forState:UIControlStateNormal];
            } else {
                [button setImage:checkNormalImage forState:UIControlStateNormal];
            }
        }
        
    }];
    
    NSMutableArray *arrayMut = [NSMutableArray new];
    [arrayMut addObject:normalSelectTitle];
    [arrayMut addObjectsFromArray:highlightSelectTitleArr];
    [button.titleLabel yb_addAttributeTapActionWithStrings:arrayMut tapClicked:^(UILabel *label, NSString *string, NSRange range, NSInteger index) {
        if ([string isEqualToString:normalSelectTitle]) {
            button.selected = !button.selected;
            checkBtn.selected = button.selected;

            if (isShowCheck) {
                if (button.selected) {
                    [button setImage:checkHighlightImage forState:UIControlStateNormal];
                } else {
                    [button setImage:checkNormalImage forState:UIControlStateNormal];
                }
            }
            
        } else {
            completion(index);
        }
    }];
    
    return button;
}

/// 按钮图片文字居左样式，仿得物样式
+ (UIButton *)createLeftModelUserProButtonWithFullstring:(NSString *)fullstring
                              normalSelectTitle:(NSString *)normalSelectTitle
                        highlightSelectTitleArr:(NSArray *)highlightSelectTitleArr
                                    normalColor:(UIColor *)normalColor
                                 highlightColor:(UIColor *)highlightColor
                                     normalFont:(CGFloat)normalFont
                                  highlightFont:(CGFloat)highlightFont
                                    isShowCheck:(BOOL)isShowCheck
                               checkNormalImage:(nullable UIImage *)checkNormalImage
                            checkHighlightImage:(nullable UIImage *)checkHighlightImage
                                 isDefaultCheck:(BOOL)isDefaultCheck completion:(void(^)(NSInteger idx))completion {
    
    __block UIButton * button = [[UIButton alloc] init];
    [button setEnlargeEdge:kRl(20)];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    NSString * showText;
    
    if (isShowCheck) {
        [button setImage:checkNormalImage forState:UIControlStateNormal];
        if (kIsBangsScreen || [[XYHelperUtils getAppTermModel] containsString:@"SE"]) {
            [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        } else {
            [button setTitleEdgeInsets:UIEdgeInsetsMake(kRl(5), 0, 0, 0)];
        }
        showText = [NSString stringWithFormat:@"   %@",fullstring];
        normalSelectTitle = [NSString stringWithFormat:@"   %@", normalSelectTitle];
    } else {
        showText = fullstring;
    }
    
    NSAttributedString * showAttString = [self getAttributeWith:highlightSelectTitleArr string:showText orginFont:normalFont orginColor:normalColor attributeFont:highlightFont attributeColor:highlightColor];
    [button setAttributedTitle:showAttString forState:UIControlStateNormal];
    button.titleLabel.numberOfLines = 0;
    button.titleLabel.enabledTapEffect = false;
    button.adjustsImageWhenHighlighted = false;
    
    __block UIButton *checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    checkBtn.backgroundColor = UIColor.clearColor;
    
    RAC(button, selected) = RACObserve(checkBtn, selected);
    
    if (isShowCheck == NO) {
        checkBtn.hidden = YES;
    }
    
    if (isDefaultCheck) {
        button.selected = YES;
        checkBtn.selected = YES;
        [button setImage:checkHighlightImage forState:UIControlStateNormal];

    } else {
        button.selected = NO;
        checkBtn.selected = NO;
        [button setImage:checkNormalImage forState:UIControlStateNormal];

    }
    
    [button addSubview:checkBtn];
    
    [checkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(kRl(30));
        make.height.equalTo(button);
        make.centerY.equalTo(button);
        make.left.equalTo(button);
    }];
    
    [checkBtn setEnlargeEdge:kRl(20)];
    
    [checkBtn addGestureForButton:^{
        
        checkBtn.selected = !checkBtn.selected;
                
        if (isShowCheck) {
            if (checkBtn.selected) {
                [button setImage:checkHighlightImage forState:UIControlStateNormal];
            } else {
                [button setImage:checkNormalImage forState:UIControlStateNormal];
            }
        }
        
    }];
    
    NSMutableArray *arrayMut = [NSMutableArray new];
    [arrayMut addObject:normalSelectTitle];
    [arrayMut addObjectsFromArray:highlightSelectTitleArr];
    [button.titleLabel yb_addAttributeTapActionWithStrings:arrayMut tapClicked:^(UILabel *label, NSString *string, NSRange range, NSInteger index) {
        if ([string isEqualToString:normalSelectTitle]) {
            
            button.selected = !button.selected;
            checkBtn.selected = button.selected;
            
            if (isShowCheck) {
                if (button.selected) {
                    [button setImage:checkHighlightImage forState:UIControlStateNormal];
                } else {
                    [button setImage:checkNormalImage forState:UIControlStateNormal];
                }
            }
        } else {
            completion(index);
        }
    }];
    
    return button;
}

+ (NSAttributedString *)getAttributeWith:(id)sender
                                  string:(NSString *)string
                               orginFont:(CGFloat)orginFont
                              orginColor:(UIColor *)orginColor
                           attributeFont:(CGFloat)attributeFont
                          attributeColor:(UIColor *)attributeColor {
    __block  NSMutableAttributedString *totalStr = [[NSMutableAttributedString alloc] initWithString:string];
    [totalStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:orginFont] range:NSMakeRange(0, string.length)];
    [totalStr addAttribute:NSForegroundColorAttributeName value:orginColor range:NSMakeRange(0, string.length)];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5.0f]; //设置行间距
    [paragraphStyle setLineBreakMode:NSLineBreakByTruncatingTail];
    [paragraphStyle setAlignment:NSTextAlignmentLeft];
    [paragraphStyle setLineBreakMode:NSLineBreakByCharWrapping];
    [totalStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [totalStr length])];
    
    if ([sender isKindOfClass:[NSArray class]]) {
        
        __block NSString *oringinStr = string;
        __weak typeof(self) weakSelf = self;
        
        [sender enumerateObjectsUsingBlock:^(NSString *  _Nonnull str, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSRange range = [oringinStr rangeOfString:str];
            [totalStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:attributeFont] range:range];
            [totalStr addAttribute:NSForegroundColorAttributeName value:attributeColor range:range];
            oringinStr = [oringinStr stringByReplacingCharactersInRange:range withString:[weakSelf getStringWithRange:range]];
        }];
        
    }else if ([sender isKindOfClass:[NSString class]]) {
        
        NSRange range = [string rangeOfString:sender];
        
        [totalStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:attributeFont] range:range];
        [totalStr addAttribute:NSForegroundColorAttributeName value:attributeColor range:range];
    }
    return totalStr;
}

+ (NSString *)getStringWithRange:(NSRange)range {
    NSMutableString *string = [NSMutableString string];
    for (int i = 0; i < range.length ; i++) {
        [string appendString:@" "];
    }
    return string;
}

#pragma mark - 获取gif中的图片数组
/// 获取gif中的图片数组
/// @param resource gif
/// @param color 想要改成的颜色
+ (NSArray *)getImageFromGifResource:(NSString *)resource
                               color:(nullable UIColor *)color {
    NSMutableArray *imageArray = [NSMutableArray array];
    
    // 获取gif url
    NSURL *url = [[NSBundle mainBundle] URLForResource:resource withExtension:@"gif"];
    // 转换为图片源
    CGImageSourceRef gifImageSourceRef = CGImageSourceCreateWithURL((CFURLRef)url, nil);
    // 获取图片个数
    size_t framesCount = CGImageSourceGetCount(gifImageSourceRef);
    for (size_t i=0; i<framesCount; i++) {
        CGImageRef imageRef = CGImageSourceCreateImageAtIndex(gifImageSourceRef, i, nil);
        UIImage *image = [UIImage imageWithCGImage:imageRef];
        
        if (color != nil) {
            image = [image imageWithColor:color];
        }
        
        [imageArray addObject:image];
        
        CFRelease(imageRef);
    }
    return imageArray;
}

#pragma mark - 修改图片尺寸，防止图片因为自身尺寸过大在特殊场景无法按预期显示问题，如下滑刷新动态头部图片显示过大,一般为40x40
+ (UIImage *)scaleToSize:(UIImage *)image size:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, [[UIScreen mainScreen] scale]);
    // 绘制改变大小的图片
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage * scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

#pragma mark - 获取视频封面
/// @param videoURL 本地视频，网络视频都可以用
+ (UIImage *)thumbnailImageForVideo:(NSURL *)videoURL {
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(2.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *thumbImg = [[UIImage alloc] initWithCGImage:image];
    return thumbImg;
}


#pragma mark - 获取设备号
+ (NSString *)deviceID {
    NSString *device_id_key = @"device_id_key";
    NSString *keychain_service = kAppBundleId;
    // 从userDefaults取
    NSString *result = [[NSUserDefaults standardUserDefaults] objectForKey:device_id_key];
    if (!result) {
        // 从keychain取
        result = [SAMKeychain passwordForService:keychain_service account:device_id_key];
        if (result) {
            [[NSUserDefaults standardUserDefaults] setObject:result forKey:device_id_key];
            [[NSUserDefaults standardUserDefaults] synchronize];
        } else {
            // 从pasteboard取
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            id data = [pasteboard dataForPasteboardType:device_id_key];
            if (data) {
                result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            }
            if (result) {
                [[NSUserDefaults standardUserDefaults] setObject:result forKey:device_id_key];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [SAMKeychain setPassword:result forService:keychain_service account:device_id_key];
            } else {
                result = [[NSUUID UUID] UUIDString];
                [[NSUserDefaults standardUserDefaults] setObject:result forKey:device_id_key];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [SAMKeychain setPassword:result forService:keychain_service account:device_id_key];
                UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                NSData *data = [result dataUsingEncoding:NSUTF8StringEncoding];
                [pasteboard setData:data forPasteboardType:device_id_key];
            }
        }
    }
    return [NSString stringWithFormat:@"ios_%@", result.MD5];
}

#pragma mark - 获取 IDFA
+ (NSString *)IDFA {
    return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
}

#pragma mark - 播放提示音
/// @param sourcesPath 提示音路径
+ (void)playAlertSound:(NSString *)sourcesPath {
    if (sourcesPath) {
        SystemSoundID soundID;
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:sourcesPath], &soundID);
        // 播放提示音 带震动
        AudioServicesPlayAlertSound(soundID);
    } else {
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
    }
}

#pragma mark - 获取设备型号
+ (NSString *)getAppTermModel {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    // iPhone
    if ([deviceString isEqualToString:@"iPhone1,1"]) return @"iPhone2G";
    if ([deviceString isEqualToString:@"iPhone1,2"]) return @"iPhone3G";
    if ([deviceString isEqualToString:@"iPhone2,1"]) return @"iPhone3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"]) return @"iPhone4";
    if ([deviceString isEqualToString:@"iPhone3,2"]) return @"iPhone4";
    if ([deviceString isEqualToString:@"iPhone3,3"]) return @"iPhone4";
    if ([deviceString isEqualToString:@"iPhone4,1"]) return @"iPhone4S";
    if ([deviceString isEqualToString:@"iPhone5,1"]) return @"iPhone5";
    if ([deviceString isEqualToString:@"iPhone5,2"]) return @"iPhone5";
    if ([deviceString isEqualToString:@"iPhone5,3"]) return @"iPhone5c";
    if ([deviceString isEqualToString:@"iPhone5,4"]) return @"iPhone5c";
    if ([deviceString isEqualToString:@"iPhone6,1"]) return @"iPhone5s";
    if ([deviceString isEqualToString:@"iPhone6,2"]) return @"iPhone5s";
    if ([deviceString isEqualToString:@"iPhone7,2"]) return @"iPhone6";
    if ([deviceString isEqualToString:@"iPhone7,1"]) return @"iPhone6Plus";
    if ([deviceString isEqualToString:@"iPhone8,1"]) return @"iPhone6s";
    if ([deviceString isEqualToString:@"iPhone8,2"]) return @"iPhone6sPlus";
    if ([deviceString isEqualToString:@"iPhone8,3"]) return @"iPhoneSE";
    if ([deviceString isEqualToString:@"iPhone8,4"]) return @"iPhoneSE";
    if ([deviceString isEqualToString:@"iPhone9,1"]) return @"iPhone7";
    if ([deviceString isEqualToString:@"iPhone9,2"] ||
        [deviceString isEqualToString:@"iPhone9,4"]) return @"iPhone7Plus";
    if ([deviceString isEqualToString:@"iPhone10,1"] ||
        [deviceString isEqualToString:@"iPhone10,4"]) return @"iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10,2"] ||
        [deviceString isEqualToString:@"iPhone10,5"]) return @"iPhone 8 Plus";
    if ([deviceString isEqualToString:@"iPhone10,3"] ||
        [deviceString isEqualToString:@"iPhone10,6"]) return @"iPhone X";
    if ([deviceString isEqualToString:@"iPhone11,8"]) return @"iPhone XR";
    if ([deviceString isEqualToString:@"iPhone11,2"]) return @"iPhone XS";
    if ([deviceString isEqualToString:@"iPhone11,4"] ||
        [deviceString isEqualToString:@"iPhone11,6"]) return @"iPhone XS Max";
    if ([deviceString isEqualToString:@"iPhone12,1"]) return @"iPhone 11";
    if ([deviceString isEqualToString:@"iPhone12,3"]) return @"iPhone 11 Pro";
    if ([deviceString isEqualToString:@"iPhone12,5"]) return @"iPhone 11 Pro Max";
    if ([deviceString  isEqualToString:@"iPhone12,8"]) return @"iPhone SE 2nd";
    if ([deviceString  isEqualToString:@"iPhone13,1"]) return @"iPhone 12 mini";
    if ([deviceString  isEqualToString:@"iPhone13,2"]) return @"iPhone 12";
    if ([deviceString isEqualToString:@"iPhone13,3"]) return @"iPhone 12 Pro";
    if ([deviceString isEqualToString:@"iPhone13,4"]) return @"iPhone 12 Pro Max";
    if ([deviceString  isEqualToString:@"iPhone14,4"]) return @"iPhone 13 mini";
    if ([deviceString  isEqualToString:@"iPhone14,5"]) return @"iPhone 13";
    if ([deviceString isEqualToString:@"iPhone14,2"]) return @"iPhone 13 Pro";
    if ([deviceString isEqualToString:@"iPhone14,3"]) return @"iPhone 13 Pro Max";
    if ([deviceString isEqualToString:@"iPhone14,6"]) return @"iPhone SE 3nd";
    if ([deviceString isEqualToString:@"iPhone14,7"]) return @"iPhone 14";
    if ([deviceString isEqualToString:@"iPhone14,8"]) return @"iPhone 14 Plus";
    if ([deviceString isEqualToString:@"iPhone15,2"]) return @"iPhone 14 Pro";
    if ([deviceString isEqualToString:@"iPhone15,3"]) return @"iPhone 14 Pro Max";
    
    
    //iPod Touch
    if ([deviceString isEqualToString:@"iPod1,1"])   return @"iPodTouch";
    if ([deviceString isEqualToString:@"iPod2,1"])   return @"iPodTouch2";
    if ([deviceString isEqualToString:@"iPod3,1"])   return @"iPodTouch3";
    if ([deviceString isEqualToString:@"iPod4,1"])   return @"iPodTouch4";
    if ([deviceString isEqualToString:@"iPod5,1"])   return @"iPodTouch5";
    if ([deviceString isEqualToString:@"iPod7,1"])   return @"iPodTouch6";
    if ([deviceString isEqualToString:@"iPod9,1"])   return @"iPodTouch7";

    //iPad
    if ([deviceString isEqualToString:@"iPad1,1"])   return @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"])   return @"iPad2";
    if ([deviceString isEqualToString:@"iPad2,2"])   return @"iPad2";
    if ([deviceString isEqualToString:@"iPad2,3"])   return @"iPad2";
    if ([deviceString isEqualToString:@"iPad2,4"])   return @"iPad2";
    if ([deviceString isEqualToString:@"iPad3,1"])   return @"iPad3";
    if ([deviceString isEqualToString:@"iPad3,2"])   return @"iPad3";
    if ([deviceString isEqualToString:@"iPad3,3"])   return @"iPad3";
    if ([deviceString isEqualToString:@"iPad3,4"])   return @"iPad4";
    if ([deviceString isEqualToString:@"iPad3,5"])   return @"iPad4";
    if ([deviceString isEqualToString:@"iPad3,6"])   return @"iPad4";
    if ([deviceString isEqualToString:@"iPad6,11"])  return @"iPad5";
    if ([deviceString isEqualToString:@"iPad6,12"])  return @"iPad5";
    if ([deviceString isEqualToString:@"iPad7,5"])   return @"iPad6";
    if ([deviceString isEqualToString:@"iPad7,6"])   return @"iPad6";
    if ([deviceString isEqualToString:@"iPad7,11"])  return @"iPad7";
    if ([deviceString isEqualToString:@"iPad7,12"])  return @"iPad7";
    if ([deviceString isEqualToString:@"iPad11,6"])  return @"iPad8";
    if ([deviceString isEqualToString:@"iPad11,7"])  return @"iPad8";
    if ([deviceString isEqualToString:@"iPad12,1"])  return @"iPad9";
    if ([deviceString isEqualToString:@"iPad12,2"])  return @"iPad9";
    
    //iPad Air
    if ([deviceString isEqualToString:@"iPad4,1"])   return @"iPadAir";
    if ([deviceString isEqualToString:@"iPad4,2"])   return @"iPadAir";
    if ([deviceString isEqualToString:@"iPad4,3"])   return @"iPadAir";
    if ([deviceString isEqualToString:@"iPad5,3"])   return @"iPadAir2";
    if ([deviceString isEqualToString:@"iPad5,4"])   return @"iPadAir2";
    if ([deviceString isEqualToString:@"iPad11,3"])  return @"iPadAir3";
    if ([deviceString isEqualToString:@"iPad11,4"])  return @"iPadAir3";
    if ([deviceString isEqualToString:@"iPad13,1"])  return @"iPadAir4";
    if ([deviceString isEqualToString:@"iPad13,2"])  return @"iPadAir4";
    if ([deviceString isEqualToString:@"iPad13,16"]) return @"iPadAir5";
    if ([deviceString isEqualToString:@"iPad13,17"]) return @"iPadAir5";

    //iPad pro
    if ([deviceString isEqualToString:@"iPad6,3"])   return @"iPadPro";
    if ([deviceString isEqualToString:@"iPad6,4"])   return @"iPadPro";
    if ([deviceString isEqualToString:@"iPad6,7"])   return @"iPadPro";
    if ([deviceString isEqualToString:@"iPad6,8"])   return @"iPadPro";
    if ([deviceString isEqualToString:@"iPad6,11"] ||
        [deviceString isEqualToString:@"iPad6,12"]) return @"iPad 5";
    if ([deviceString isEqualToString:@"iPad7,1"] ||
        [deviceString isEqualToString:@"iPad7,2"]) return @"iPad Pro 12.9-inch 2";
    if ([deviceString isEqualToString:@"iPad7,3"] ||
        [deviceString isEqualToString:@"iPad7,4"]) return @"iPad Pro 10.5-inch";
    if ([deviceString isEqualToString:@"iPad8,1"] ||
        [deviceString isEqualToString:@"iPad8,2"] ||
        [deviceString isEqualToString:@"iPad8,3"] ||
        [deviceString isEqualToString:@"iPad8,4"]) return @"iPad Pro 11-inch";
    if ([deviceString isEqualToString:@"iPad8,5"] ||
        [deviceString isEqualToString:@"iPad8,6"] ||
        [deviceString isEqualToString:@"iPad8,7"] ||
        [deviceString isEqualToString:@"iPad8,8"]) return @"iPad Pro 12.9-inch 3";
    if ([deviceString isEqualToString:@"iPad8,9"] ||
        [deviceString isEqualToString:@"iPad8,10"]) return @"iPad Pro 11-inch 2";
    if ([deviceString isEqualToString:@"iPad8,11"] ||
        [deviceString isEqualToString:@"iPad8,12"]) return @"iPad Pro 12.9-inch 4";
    if ([deviceString isEqualToString:@"iPad13,4"] ||
        [deviceString isEqualToString:@"iPad13,5"] ||
        [deviceString isEqualToString:@"iPad13,6"] ||
        [deviceString isEqualToString:@"iPad13,7"]) return @"iPad Pro 11-inch 3";
    if ([deviceString isEqualToString:@"iPad13,8"] ||
        [deviceString isEqualToString:@"iPad13,9"] ||
        [deviceString isEqualToString:@"iPad13,10"] ||
        [deviceString isEqualToString:@"iPad13,11"]) return @"iPad Pro 12.9-inch 5";
    
    //iPad mini
    if ([deviceString isEqualToString:@"iPad2,5"])   return @"iPadmini1G";
    if ([deviceString isEqualToString:@"iPad2,6"])   return @"iPadmini1G";
    if ([deviceString isEqualToString:@"iPad2,7"])   return @"iPadmini1G";
    if ([deviceString isEqualToString:@"iPad4,4"])   return @"iPadmini2";
    if ([deviceString isEqualToString:@"iPad4,5"])   return @"iPadmini2";
    if ([deviceString isEqualToString:@"iPad4,6"])   return @"iPadmini2";
    if ([deviceString isEqualToString:@"iPad4,7"])   return @"iPadmini3";
    if ([deviceString isEqualToString:@"iPad4,8"])   return @"iPadmini3";
    if ([deviceString isEqualToString:@"iPad4,9"])   return @"iPadmini3";
    if ([deviceString isEqualToString:@"iPad5,1"])   return @"iPadmini4";
    if ([deviceString isEqualToString:@"iPad5,2"])   return @"iPadmini4";
    if ([deviceString isEqualToString:@"iPad11,1"])  return @"iPadmini5";
    if ([deviceString isEqualToString:@"iPad11,2"])  return @"iPadmini5";
    if ([deviceString isEqualToString:@"iPad14,1"])  return @"iPadmini6";
    if ([deviceString isEqualToString:@"iPad14,2"])  return @"iPadmini6";

    if ([deviceString isEqualToString:@"i386"])      return @"iPhoneSimulator";
    if ([deviceString isEqualToString:@"x86_64"])    return @"iPhoneSimulator";
    return @"Unknown";
}


#pragma mark - 获取设备uuid
+ (NSString *)getAppTermId {
    return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
}

#pragma mark - 表情符号 编码解码
+ (NSString *)expressionURLEncode:(NSString *)string; {
    return [string URLEncode];
}

+ (NSString *)expressionURLDecode:(NSString *)string; {
    if (YES) {
        return string;
    }
    return [string URLDecode];
}

#pragma mark - 压缩图片
+ (UIImage *)compressionImage:(UIImage *)aImage toByte:(NSUInteger)length {
    if (![aImage isKindOfClass:[UIImage class]]) {
        return nil;
    }
    CGSize size = aImage.size;
    CGFloat quality = .8;
    CGFloat scale = aImage.scale;
    NSData *fileData = UIImageJPEGRepresentation(aImage, 1.f);
    while (fileData.length >= length) {
        size.width = size.width * quality;
        size.height = size.height * quality;
        @autoreleasepool {
            UIGraphicsBeginImageContextWithOptions(size, NO, scale);
            [aImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
            UIImage *drawImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            aImage = drawImage;
            drawImage = nil;
        }
        fileData = UIImageJPEGRepresentation(aImage, 1.f);
    }
    return aImage;
}

+ (void)compressionImage:(UIImage *)aImage toByte:(NSUInteger)length asynResultBlock:(void (^)(UIImage * _Nullable))asynResultBlock {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImage *resultImage = [XYHelperUtils compressionImage:aImage toByte:length];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (asynResultBlock) {
                asynResultBlock(resultImage);
            }
        });
    });
}

#pragma mark - 为iPhone添加震动效果
+ (void)addFeedbackGenerator {
    if (@available(iOS 13.0, *)) {
        UIImpactFeedbackGenerator *impactLight = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleSoft];
        [impactLight impactOccurred];
    } else {
        // Fallback on earlier versions
        UIImpactFeedbackGenerator *impactLight = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight];
        [impactLight impactOccurred];
    }
}

#pragma mark - 跳转设置开启权限
+ (void)gotoSystemSetting {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
}

#pragma mark - 获取视频第一帧
+ (UIImage*)requestVideoPreViewImage:(NSURL *)path {
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:path options:nil];
    AVAssetImageGenerator *assetGen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    assetGen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [assetGen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *videoImage = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return videoImage;
}

#pragma mark - 设置tabbar，适配ios15，兼容ios13以前
+ (void)setTabbarWithTitleColor:(UIColor *)titleColor
                    selectColor:(UIColor *)selectColor
                           font:(UIFont *)font
                     selectFont:(UIFont *)selectFont
                         target:(__kindof UITabBarController *)target {
    /// 设置tabBarItem字体颜色
    NSMutableDictionary<NSAttributedStringKey, id> *normalAttributes = [NSMutableDictionary dictionary];
    [normalAttributes setValue:titleColor forKey:NSForegroundColorAttributeName];
    [normalAttributes setValue:font forKey:NSFontAttributeName];

    NSMutableDictionary<NSAttributedStringKey, id> *selectAttributes = [NSMutableDictionary dictionary];
    [selectAttributes setValue:selectColor forKey:NSForegroundColorAttributeName];
    [selectAttributes setValue:selectFont forKey:NSFontAttributeName];

    if (@available(iOS 13.4, *)) {
        UITabBarItemAppearance *itemAppearance = [[UITabBarItemAppearance alloc] init];
        itemAppearance.normal.titleTextAttributes = normalAttributes.copy;
        itemAppearance.selected.titleTextAttributes = selectAttributes.copy;
        UITabBarAppearance *appearance = [[UITabBarAppearance alloc] init];
        appearance.stackedLayoutAppearance = itemAppearance;
        /// tabBar背景颜色
        appearance.backgroundColor = [UIColor whiteColor];
        target.tabBar.standardAppearance = appearance;
        if (@available(iOS 15.0, *)) {
            target.tabBar.scrollEdgeAppearance = appearance;
        } else {
            // Fallback on earlier versions
        }
    } else {
        /// tabBar背景颜色
        target.tabBarController.tabBar.backgroundColor = [UIColor whiteColor];
        
        [target.tabBarItem setTitleTextAttributes:normalAttributes.copy forState:UIControlStateNormal];
        [target.tabBarItem setTitleTextAttributes:selectAttributes.copy forState:UIControlStateSelected];
        target.tabBar.tintColor = selectColor;
        target.tabBar.unselectedItemTintColor = titleColor;
    }
    
    /// 移除tabbar上的黑线
    if (@available(iOS 13, *)) {
        UIColor *color = [UIColor whiteColor];
        UITabBarAppearance *appearance = [target.tabBar.standardAppearance copy];
        appearance.backgroundImage = [UIImage imageWithColor:color];
        appearance.shadowImage = [UIImage imageWithColor:color];
        /// 重置背景和阴影为透明  如果设置了阴影效果则此代码需要去掉
//        [appearance configureWithTransparentBackground];
        target.tabBar.standardAppearance = appearance;
        if (@available(iOS 15.0, *)) {
            target.tabBar.scrollEdgeAppearance = appearance;
        }
    } else {
        target.tabBar.backgroundImage = [UIImage new];
        target.tabBar.shadowImage = [UIImage new];
    }
    
    // Masonry布局的控件，红点默认会显示在左边，在设置红点之前调用该方法，可使红点居右
    [target.tabBar layoutIfNeeded];
    
}

#pragma mark - 判断是否为模拟器
+ (BOOL)isSimuLator {
    if (TARGET_IPHONE_SIMULATOR == 1 && TARGET_OS_IPHONE == 1) {
        ///模拟器
        return YES;
    } else {
        ///真机
        return NO;
    }
}

#pragma mark - 压缩图片
/*
 根据图片大小，获取图片压缩因子
 */
+ (CGFloat)getCompressRateByImageSize:(CGFloat)imageSize targetSize:(CGFloat)targetSize {
    NSUInteger rate = (NSUInteger)(imageSize / targetSize);
    rate = (rate == 0) ? 1 : rate;

    // 默认0.8压缩因子
    CGFloat maxCompressRate = 0.8;
    CGFloat minCompressRate = 0.2;

    // 反比例压缩函数
    CGFloat compressRate = 0.8 / rate;

    compressRate = MIN(MAX(compressRate, minCompressRate), maxCompressRate);
    return compressRate;
}

/*!
 *  @brief 使图片压缩后刚好小于指定大小
 *
 *  @param image 当前要压缩的图 maxLength 压缩后的大小
 *
 *  @return 图片对象
 */
+ (NSData *)compressImageSize:(UIImage *)image toByte:(NSUInteger)maxLength {
    // 压
    NSData *data = UIImageJPEGRepresentation(image, 1);
    if (data.length < maxLength) {
        return data;
    }

    CGFloat compressRate = [self.class getCompressRateByImageSize:data.length targetSize:maxLength];
    data = UIImageJPEGRepresentation(image, compressRate);
    if (data.length < maxLength) {
        return data;
    }

    // 缩
    UIImage *resultImage = [UIImage imageWithData:data];
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)), (NSUInteger)(resultImage.size.height * sqrtf(ratio)));
        if (CGSizeEqualToSize(size, CGSizeZero) || size.width < 10 || size.height < 10) {
            break;
        }
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compressRate);
    }

    return data;
}

#pragma mark - UIView动效
/// CGAffineTransform toTrans = CGAffineTransformMakeTranslation(0, kScreenHeight-kRl(194));
+ (void)showInAnimationWithTarget:(__kindof UIView *)target
                          toTrans:(CGAffineTransform)toTrans {
    [target layoutIfNeeded];
    
    CGFloat damping = 0.7;
    if (target.size.height > kScreenHeight/2.0f) {
        damping = 5;
    } else {
        damping = 0.7;
    }
    [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:damping initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        target.transform = toTrans;

    } completion:^(BOOL finished) {
        
    }];
}

/// CGAffineTransform toTrans = CGAffineTransformMakeTranslation(0, kScreenHeight+kRl(194));
+ (void)showOutAnimationWithTarget:(__kindof UIView *)target
                          toTrans:(CGAffineTransform)toTrans {
    
    [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        target.transform = toTrans;

    } completion:^(BOOL finished) {
        
    }];
}

@end

