//
//  XYBasicPagingViewController.h
//  XYHelper
//
//  Created by spikeroog on 2020/12/15.
//  Copyright © 2020 spikeroog. All rights reserved.
//

#import "XYBasicViewController.h"
#import <JXCategoryView/JXCategoryView.h>
#import "XYHelperMarco.h"

NS_ASSUME_NONNULL_BEGIN

@interface XYBasicPagingViewController : XYBasicViewController
<JXCategoryListContainerViewDelegate,JXCategoryViewDelegate>

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, strong) NSArray <__kindof XYBasicViewController *> *controllers;
@property (nonatomic, strong) JXCategoryBaseView *categoryView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;
@property (nonatomic, assign) BOOL isNeedIndicatorPositionChangeItem;
///categoryView的高度，默认44
@property (nonatomic, assign) CGFloat categoryViewHeight;
//// Y轴偏移量，默认为0，使用嵌套样式可用到
@property (nonatomic, assign) CGFloat categoryViewYOffset;

- (JXCategoryBaseView *)preferredCategoryView;
- (CGFloat)preferredCategoryViewHeight;

@end

NS_ASSUME_NONNULL_END
