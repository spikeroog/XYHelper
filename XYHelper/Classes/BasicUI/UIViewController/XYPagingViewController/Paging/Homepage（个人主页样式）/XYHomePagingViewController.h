//
//  XYHomePagingViewController.h
//  XYHelper
//
//  Created by spikeroog on 2022/11/23.
//  Copyright © 2022 spikeroog. All rights reserved.
//

#import "XYBasicViewController.h"
#import <JXPagingView/JXPagerView.h>
#import <JXCategoryView/JXCategoryView.h>
#import "XYHomePagingViewTableHeaderView.h"
#import "XYHomePagingSubViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface XYHomePagingViewController : XYBasicViewController
<JXPagerViewDelegate, JXPagerMainTableViewGestureDelegate>
//JXCategoryListContentViewDelegate

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, strong) JXPagerView *pagerView;
@property (nonatomic, strong) XYHomePagingViewTableHeaderView *headerView;

@property (nonatomic, strong) JXCategoryTitleView *myCategoryView;
@property (nonatomic, strong) JXCategoryIndicatorLineView *lineView;

/// 图片高度
@property (nonatomic, assign) NSInteger JXTableHeaderViewHeight;
/// 标签栏高度
@property (nonatomic, assign) NSInteger categoryViewHeight;

@property (nonatomic, strong) NSArray <__kindof XYHomePagingSubViewController *> *homepageControllers;

- (JXPagerView *)preferredPagingView;

@end

NS_ASSUME_NONNULL_END
