//
//  XYPagingViewController.m
//  XYHelper
//
//  Created by spikeroog on 2019/9/24.
//  Copyright © 2019 spikeroog. All rights reserved.
//

#import "XYPagingViewController.h"
#import <SGPagingView/SGPagingView.h>
#import "XYHelperMarco.h"
#import "XYScreenAdapter.h"

@interface XYPagingViewController ()
<SGPageTitleViewDelegate, SGPageContentCollectionViewDelegate>

@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentCollectionView *pageContentCollectionView;

@property (nonatomic, strong) NSArray<__kindof UIViewController *> *datas;
@property (nonatomic, strong) NSArray<NSString *> *titles;

@end

@implementation XYPagingViewController


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
       pagingBackgroundColor:(UIColor *)pagingBackgroundColor {
        
    _datas = dataVCs;
    _titles = titles;
    
    pagingHeight <= 0 ? (pagingHeight = 44) : (pagingHeight = pagingHeight);
    
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    // 如果需要未选中为细字体，选中为粗字体，直接设置两种字体一种为粗，一种为细即可
    configure.titleFont = kFontWithAutoSize(titleFontSize);
    configure.titleSelectedFont = kBoldFontWithAutoSize(titleSelectedFontSize);
    configure.titleColor = titleColor;
    configure.titleSelectedColor = titleSelectedColor;
    
    configure.equivalence = YES;
    
    configure.indicatorColor = indicatorColor;
    if (hasDynamic) {
        configure.indicatorStyle = SGIndicatorStyleDynamic;
    } else {
        configure.indicatorStyle = SGIndicatorStyleDefault;
    }
    // 如果是固定样式，就不用设置
    configure.titleAdditionalWidth = kAutoCs(30);
    // 不显示分割线
    configure.showBottomSeparator = NO;
    
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, pagingHeight) delegate:self titleNames:_titles configure:configure];
    self.pageTitleView.backgroundColor = pagingBackgroundColor;

    self.pageTitleView.layer.cornerRadius = pagingCornerRadius;
    self.pageTitleView.layer.masksToBounds = YES;
    
    [self.view addSubview:_pageTitleView];
    
    CGFloat collectionViewHeight = self.view.frame.size.height - CGRectGetMaxY(_pageTitleView.frame);
    self.pageContentCollectionView = [[SGPageContentCollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_pageTitleView.frame), self.view.frame.size.width, collectionViewHeight) parentVC:self childVCs:_datas];
    _pageContentCollectionView.delegatePageContentCollectionView = self;
    [self.view addSubview:_pageContentCollectionView];
}

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
       pagingBackgroundColor:(UIColor *)pagingBackgroundColor {
    
    _datas = dataVCs;
    _titles = titles;
    
    pagingHeight <= 0 ? (pagingHeight = 44) : (pagingHeight = pagingHeight);
    
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    // 如果需要未选中为细字体，选中为粗字体，直接设置两种字体一种为粗，一种为细即可
    configure.titleFont = kFontWithAutoSize(titleFontSize);
    configure.titleColor = titleColor;
    configure.titleSelectedColor = titleSelectedColor;
    
    if (titleSelectedFontSize > titleFontSize) {
        // 设置缩放效果，titleTextZoomRatio为0.9，则选中字体是未选中的1.9倍
        // 这里我们只要设置未选中的大小就好了，不能设置选中字体
        configure.titleTextZoom = YES;
        configure.titleTextZoomRatio = 0.2;
        configure.titleGradientEffect = YES;
    } else {
        configure.titleSelectedFont = kBoldFontWithAutoSize(titleSelectedFontSize);
    }
    
    configure.equivalence = YES;
    
    configure.indicatorColor = indicatorColor;
    if (hasDynamic) {
        configure.indicatorStyle = SGIndicatorStyleDynamic;
    } else {
        configure.indicatorStyle = SGIndicatorStyleDefault;
    }
    // 不显示分割线
    configure.showBottomSeparator = NO;
    
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(kAutoCs(125), 0, self.view.frame.size.width-kAutoCs(125*2), pagingHeight) delegate:self titleNames:_titles configure:configure];
    self.pageTitleView.backgroundColor = pagingBackgroundColor;

    self.pageTitleView.layer.cornerRadius = pagingCornerRadius;
    self.pageTitleView.layer.masksToBounds = YES;
    
    [self.view addSubview:_pageTitleView];
    
    CGFloat collectionViewHeight = self.view.frame.size.height - CGRectGetMaxY(_pageTitleView.frame);
    self.pageContentCollectionView = [[SGPageContentCollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_pageTitleView.frame), self.view.frame.size.width, collectionViewHeight) parentVC:self childVCs:_datas];
    _pageContentCollectionView.delegatePageContentCollectionView = self;
    [self.view addSubview:_pageContentCollectionView];
}


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
       pagingBackgroundColor:(UIColor *)pagingBackgroundColor {
    
    _datas = dataVCs;
    _titles = titles;
    
    pagingHeight <= 0 ? (pagingHeight = 44) : (pagingHeight = pagingHeight);
    
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    // 如果需要未选中为细字体，选中为粗字体，直接设置两种字体一种为粗，一种为细即可
    configure.titleFont = kBoldFontWithAutoSize(titleFontSize);
    configure.titleSelectedFont = kBoldFontWithAutoSize(titleSelectedFontSize);
    configure.titleColor = titleColor;
    configure.titleSelectedColor = titleSelectedColor;
    
    configure.equivalence = YES;
    
    configure.indicatorColor = indicatorColor;
    if (hasDynamic) {
        configure.indicatorStyle = SGIndicatorStyleDynamic;
    } else {
        configure.indicatorStyle = SGIndicatorStyleDefault;
    }
    // 不显示分割线
    configure.showBottomSeparator = NO;
    // 是否渐变
    configure.titleGradientEffect = YES;
    
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, pagingHeight) delegate:self titleNames:_titles configure:configure];
    self.pageTitleView.backgroundColor = pagingBackgroundColor;
    
    self.pageTitleView.layer.cornerRadius = pagingCornerRadius;
    self.pageTitleView.layer.masksToBounds = YES;
    
    [self.view addSubview:_pageTitleView];
    
    CGFloat collectionViewHeight = self.view.frame.size.height - CGRectGetMaxY(_pageTitleView.frame);
    self.pageContentCollectionView = [[SGPageContentCollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_pageTitleView.frame), self.view.frame.size.width, collectionViewHeight) parentVC:self childVCs:_datas];
    _pageContentCollectionView.delegatePageContentCollectionView = self;
    [self.view addSubview:_pageContentCollectionView];
}

#pragma mark - delegate

- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentCollectionView setPageContentCollectionViewCurrentIndex:selectedIndex];
}

- (void)pageContentCollectionView:(SGPageContentCollectionView *)pageContentCollectionView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}

@end
