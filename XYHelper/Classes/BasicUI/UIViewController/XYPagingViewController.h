//
//  XYPagingViewController.h
//  XYHelper
//
//  Created by spikeroog on 2019/9/24.
//  Copyright © 2019 spikeroog. All rights reserved.
//

#import "XYBasicViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface XYPagingViewController : XYBasicViewController

/// 设置Paging视图控制器，默认样式，从左到右的标签栏样式
/// @param dataVCs 子控制器
/// @param titles 子控制器名称
/// @param titleFontSize 默认字体大小
/// @param titleSelectedFontSize 选中字体大小
/// @param titleColor 默认字体颜色
/// @param titleSelectedColor 选择字体颜色
/// @param indicatorColor 下划条颜色
/// @param hasDynamic 下滑条样式
/// @param pagingHeight Paging视图高度，默认44
/// @param pagingCornerRadius Paging视图圆角，默认0
/// @param pagingBackgroundColor Paging视图背景颜色
- (void)setUtilPagingWithVCs:(NSArray<__kindof UIViewController *>*)dataVCs
                      titles:(NSArray<NSString *>*)titles
               titleFontSize:(CGFloat)titleFontSize
       titleSelectedFontSize:(CGFloat)titleSelectedFontSize
                  titleColor:(UIColor *)titleColor
          titleSelectedColor:(UIColor *)titleSelectedColor
              indicatorColor:(UIColor *)indicatorColor
                  hasDynamic:(BOOL)hasDynamic
                pagingHeight:(CGFloat)pagingHeight
          pagingCornerRadius:(CGFloat)pagingCornerRadius
       pagingBackgroundColor:(UIColor *)pagingBackgroundColor;


/// 设置Paging视图控制器，居中样式，标签居中
/// @param dataVCs 子控制器
/// @param titles 子控制器名称
/// @param titleFontSize 默认字体大小
/// @param titleSelectedFontSize 选中字体大小
/// @param titleColor 默认字体颜色
/// @param titleSelectedColor 选择字体颜色
/// @param indicatorColor 下划条颜色
/// @param hasDynamic 下滑条样式
/// @param pagingHeight Paging视图高度，默认44
/// @param pagingCornerRadius Paging视图圆角，默认0
/// @param pagingBackgroundColor Paging视图背景颜色
- (void)setCenterPagingWithVCs:(NSArray<__kindof UIViewController *>*)dataVCs
                        titles:(NSArray<NSString *>*)titles
                 titleFontSize:(CGFloat)titleFontSize
         titleSelectedFontSize:(CGFloat)titleSelectedFontSize
                    titleColor:(UIColor *)titleColor
            titleSelectedColor:(UIColor *)titleSelectedColor
                indicatorColor:(UIColor *)indicatorColor
                    hasDynamic:(BOOL)hasDynamic
                  pagingHeight:(CGFloat)pagingHeight
            pagingCornerRadius:(CGFloat)pagingCornerRadius
         pagingBackgroundColor:(UIColor *)pagingBackgroundColor;


/// 设置Paging视图控制器，大标题样式，title为超大标题
/// @param dataVCs 子控制器
/// @param titles 子控制器名称
/// @param titleFontSize 默认字体大小
/// @param titleSelectedFontSize 选中字体大小
/// @param titleColor 默认字体颜色
/// @param titleSelectedColor 选择字体颜色
/// @param indicatorColor 下划条颜色
/// @param hasDynamic 下滑条样式
/// @param pagingHeight Paging视图高度，默认44
/// @param pagingCornerRadius Paging视图圆角，默认0
/// @param pagingBackgroundColor Paging视图背景颜色
- (void)setBigTitlePagingWithVCs:(NSArray<__kindof UIViewController *>*)dataVCs
                          titles:(NSArray<NSString *>*)titles
                   titleFontSize:(CGFloat)titleFontSize
           titleSelectedFontSize:(CGFloat)titleSelectedFontSize
                      titleColor:(UIColor *)titleColor
              titleSelectedColor:(UIColor *)titleSelectedColor
                  indicatorColor:(UIColor *)indicatorColor
                      hasDynamic:(BOOL)hasDynamic
                    pagingHeight:(CGFloat)pagingHeight
              pagingCornerRadius:(CGFloat)pagingCornerRadius
           pagingBackgroundColor:(UIColor *)pagingBackgroundColor;


@end

NS_ASSUME_NONNULL_END
