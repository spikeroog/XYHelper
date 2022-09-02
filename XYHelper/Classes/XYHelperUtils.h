//
//  XYHelperUtils.h
//  XYHelper
//
//  Created by spikeroog on 2018/11/20.
//  Copyright © 2018 spikeroog. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XYHelperMarco.h"
#import "XYScreenAdapter.h"

NS_ASSUME_NONNULL_BEGIN

@interface XYHelperUtils : NSObject

#pragma mark - 判断字符串是否为空
+ (BOOL)isNull:(NSString *)string;

#pragma mark - 判断是否是刘海屏手机
+ (BOOL)iPhoneNotchScreen;

#pragma mark - 判断app是否第一次启动或者更新后第一次启动
+ (BOOL)isApplicationFirstLoad;

#pragma mark - 判断app是否第一次安装时启动
+ (BOOL)isApplicationFirstInstallLoad;

#pragma mark - 系统alert或sheet
+ (void)showAlertWithTitle:(nullable NSString *)title
                   message:(nullable NSString *)message
               sureMessage:(nullable NSString *)sureMessage
             cancelMessage:(nullable NSString *)cancelMessage
              thirdMessage:(nullable NSString *)thirdMessage
                     style:(UIAlertControllerStyle)style
               sureHandler:(void (^)())sureHandler
             cancelHandler:(void (^)())cancelHandler
              thirdHandler:(void(^)())thirdHandler;

#pragma mark - 自定义alert或sheet
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
                         cancelColor:(nullable UIColor *)cancelColor;

#pragma mark - 显示单行单按钮alert
+ (void)showAlertWithTitle:(NSString *)title;

#pragma mark - 是否插入了耳机
+ (BOOL)isHeadsetPluggedIn;

#pragma mark - 取得目录下所有文件
+ (NSArray *)allFilesAtPath:(NSString *)dirString;

#pragma mark - 注册字体
+ (void)registerFont:(NSString *)fontPath;

#pragma mark - 判断string中是否含有中文字符
+ (BOOL)haveChinese:(NSString *)string;

#pragma mark - 银行键盘，键盘输入限制小数后两位
+ (BOOL)judgeTextMoneyTypeWithTextField:(UITextField *)textField
          shouldChangeCharactersInRange:(NSRange)range
                      replacementString:(NSString *)string
                                isFirst:(BOOL)dot
                               complete:(void (^)(BOOL isFirstChar))complete;

#pragma mark - 绘制部分圆角
+ (void)advancedEfficientDrawBead:(__kindof UIView *)targetView
                      drawTopLeft:(BOOL)drawTopLeft
                     drawTopRight:(BOOL)drawTopRight
                   drawBottomLeft:(BOOL)drawBottomLeft
                  drawBottomRight:(BOOL)drawBottomRight
                     cornerRadius:(CGFloat)cornerRadius;

#pragma mark - 字符串转颜色
+ (UIColor *)hexColor:(NSString *)hexColorStr;
#pragma mark - 颜色转字符串
+ (NSString *)hexColorStr:(UIColor *)hexColor;

#pragma mark - 校验邮箱格式是否正确
+ (BOOL)isAvailableEmailNumber:(NSString *)emailNum;
#pragma mark - 校验身份证号码是否正确
+ (BOOL)isAvailableIDCardNumber:(NSString *)idCardNum;
#pragma mark - 校验手机号码是否正确，想要知道最新的手机号码号段，请百度搜‘手机号码’查看百度百科
+ (BOOL)isAvailableContactNumber:(NSString *)mobileNum;
#pragma mark - 校验银行卡号是否正确
+ (BOOL)isAvailableBankCardNumber:(NSString *)cardNum;

#pragma mark - 获取磁盘总空间
+ (CGFloat)diskOfAllSizeMBytes;

#pragma mark - 获取磁盘可用空间大小
+ (CGFloat)diskOfFreeSizeMBytes;

#pragma mark - 获取指定路径下某个文件的大小
+ (long long)fileSizeAtPath:(NSString *)filePath;

#pragma mark - 获取文件夹下所有文件的大小
+ (long long)folderSizeAtPath:(NSString *)folderPath;

#pragma mark - 跳转appStore
+ (void)gotoAppStoreWithAppleId:(NSString *)appleId;
#pragma mark - 跳转appStore评分
+ (void)gotoAppStoreGradeWithAppleId:(NSString *)appleId;

#pragma mark - 判断越狱机器,因为越狱的设备都会安装有cydia
+ (BOOL)isJailBreak;

#pragma mark - 图片转字符串
+ (NSString *)UIImageToBase64Str:(UIImage *)image;
#pragma mark - 字符串转图片
+ (UIImage *)Base64StrToUIImage:(NSString *)encodedImageStr;

#pragma mark - 获取当前时间戳
+ (NSNumber *)currentTimeInterval;

#pragma mark - 获取当前时间
/// dateFormat 如:@"yyyy-MM-dd HH:mm:ss"
+ (NSString *)currentTimes:(NSString *)dateFormat;
#pragma mark - 获取当前网络时间
/// 获取网络时间
+ (NSString *)getCurrentNetworkTime:(NSString *)dateFormat;

#pragma mark - 时间转换成时间戳
+ (NSTimeInterval)strToTimeIntervalFrom:(NSString *)timeString;
#pragma mark - 时间戳转换成时间
+ (NSString *)timeToStrFrom:(NSString *)timeStamp;
+ (NSString *)timeToStrFrom:(NSString *)timeStamp
                 dateformat:(NSString *)dateformat;
/// NSDate转时间戳
+ (NSString *)dateConversionTimeStamp:(NSDate *)date;
/// 2019-12-31 23:59:59 转 NSDate
+ (NSDate *)nsstringConversionNSDate:(NSString *)dateStr;

#pragma mark - 顺时针视图旋转N度
+ (void)rotationTransformWithView:(__kindof UIView *)targetView
                    rotationAngle:(CGFloat)rotationAngle;

#pragma mark - 定时器
+ (void)createTimerWithTimeout:(NSInteger)time
                      interval:(CGFloat)interval
                countingHandle:(void(^)(NSInteger count))countingHandle
                  finishHandle:(void(^)())finishHandle;

#pragma mark - 给视图添加抖动动画
+ (void)loadShakeAnimationForView:(__kindof UIView *)targetView;

#pragma mark - 根据宽度求高度
//根据宽度求高度  content 计算的内容  width 计算的宽度 font字体大小
+ (CGFloat)getLabelHeightWithText:(NSString *)text
                            width:(CGFloat)width
                         fontSize:(CGFloat)fontSize;

#pragma mark - 根据高度求宽度
//根据高度求宽度  text 计算的内容  Height 计算的高度 font字体大小
+ (CGFloat)getWidthWithText:(NSString *)text
                     height:(CGFloat)height
                   fontSize:(CGFloat)fontSize;

/**
 阿拉伯数字转大写中文
 
 @param num 如：100.11
 @return 壹佰元壹角壹分
 */
+ (NSString *)fetchAmountChineseStrWithNumber:(CGFloat)num;

#pragma mark - model转Json字符串，如果后台需要
/**
 model转json字符串
 需要导入YYCategories
 
 @param model model
 @return json字符串
 */
+ (NSString *)modelConvertToJson:(id)model;

/**
 model数组转json字符串
 需要导入YYCategories
 
 @param modelArray model数组
 @return json字符串
 */
+ (NSString *)modelArrayConvertToJson:(NSArray *)modelArray;


#pragma mark - 计算视频大小和图片大小
/**
 计算图片的大小 单位：M
 图片是除以1000，视频时除以1024
 
 @param image 图片
 @return 大小
 */
+ (CGFloat)fetchImageSize:(UIImage *)image;

/**
 计算视频的大小 单位：M
 图片是除以1000，视频时除以1024
 
 @param videoPath 视频路径
 @return 大小
 */
+ (CGFloat)fetchVideoSize:(NSString *)videoPath;

/// 获取现在时间，每个区块以字符串形式返回
+ (void)getPresentTime:(void(^)(NSString *year, NSString *month, NSString *day, NSString *hour, NSString *minute, NSString *second))completion;

/// 比较两个数组元素是否相等
/// @param arrayA 数组1
/// @param arrayB 数组2
+ (BOOL)compareArray:(NSArray *)arrayA
           isEqualTo:(NSArray *)arrayB;

/// iOS13 给textfield添加leftView，rightView
+ (void)addViewWithTextfield:(__kindof UITextField *)textfield
                    viewSize:(CGSize)viewSize
            leftViewImageStr:(nullable NSString *)leftViewImageStr
           rightViewImageStr:(nullable NSString *)rightViewImageStr leftViewClick:(void(^)())leftViewClick
              rightViewClick:(void(^)())rightViewClick;

/// 添加和中文有间距的下划线
/// @param fatherLabel 父label
+ (void)addUnderLineWithLabel:(__kindof UILabel *)fatherLabel;

#pragma mark - 快速创建用户隐私协议按钮，可带勾选框☑️
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
                                 isDefaultCheck:(BOOL)isDefaultCheck
                                     completion:(void(^)(NSInteger idx))completion;

#pragma mark - 获取gif中的图片数组
/// 获取gif中的图片数组
/// @param resource gif
/// @param color 想要改成的颜色
+ (NSArray *)getImageFromGifResource:(NSString *)resource
                               color:(nullable UIColor *)color;
#pragma mark - 修改图片尺寸
+ (UIImage *)scaleToSize:(UIImage *)image size:(CGSize)size;

#pragma mark - 获取视频封面
+ (UIImage *)thumbnailImageForVideo:(NSURL *)videoURL;

#pragma mark - 获取设备号
+ (NSString *)deviceID;

#pragma mark - 获取 IDFA
+ (NSString *)IDFA;

#pragma mark - 播放提示音
+ (void)playAlertSound:(NSString *)sourcesPath;

#pragma mark - 获取设备型号
+ (NSString *)getAppTermModel;

#pragma mark - 获取设备uuid
+ (NSString *)getAppTermId;

#pragma mark - 表情符号 编码解码
+ (NSString *)expressionURLEncode:(NSString *)string;
+ (NSString *)expressionURLDecode:(NSString *)string;

#pragma mark - 压缩图片
+ (UIImage *)compressionImage:(UIImage *)aImage toByte:(NSUInteger)length;
+ (void)compressionImage:(UIImage *)aImage toByte:(NSUInteger)length asynResultBlock:(void (^)(UIImage * _Nullable))asynResultBlock;

#pragma mark - 为iPhone添加震动效果
+ (void)addFeedbackGenerator;

#pragma mark - 跳转设置开启权限
+ (void)gotoSystemSetting;



@end

NS_ASSUME_NONNULL_END
