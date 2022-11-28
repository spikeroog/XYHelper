//
//  XYHomePagingViewController.m
//  XYHelper
//
//  Created by spikeroog on 2022/11/23.
//  Copyright © 2022 spikeroog. All rights reserved.
//

#import "XYHomePagingViewController.h"
#import <JXCategoryView/JXCategoryView.h>

@interface XYHomePagingViewController ()<JXCategoryViewDelegate>

@end

@implementation XYHomePagingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUi];
}

- (void)setUpUi {
    
    if (self.JXTableHeaderViewHeight == 0) {
        self.JXTableHeaderViewHeight = 200;
    }
    
    if (self.categoryViewHeight == 0) {
        self.categoryViewHeight = 44;
    }
    
    self.myCategoryView.bounds = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, _categoryViewHeight);

    self.myCategoryView.titles = self.titles;
    self.myCategoryView.delegate = self;

    self.myCategoryView.indicators = @[self.lineView];
    
    _pagerView = [self preferredPagingView];
    self.pagerView.mainTableView.gestureDelegate = self;
    [self.view addSubview:self.pagerView];

    self.myCategoryView.listContainer = (id<JXCategoryViewListContainer>)self.pagerView.listContainerView;
    
    /// 导航栏隐藏的情况，处理扣边返回，下面的代码要加上
    if (self.xy_NavHiddenForReal) {
        [self.pagerView.listContainerView.scrollView.panGestureRecognizer requireGestureRecognizerToFail:self.navigationController.interactivePopGestureRecognizer];
        [self.pagerView.mainTableView.panGestureRecognizer requireGestureRecognizerToFail:self.navigationController.interactivePopGestureRecognizer];
    }
}

- (XYHomePagingViewTableHeaderView *)headerView {
    if (_headerView == nil) {
        _headerView = [[XYHomePagingViewTableHeaderView alloc] init];
    }
    return _headerView;
}

/// 头部图片缩放
- (void)pagerView:(JXPagerView *)pagerView mainTableViewDidScroll:(UIScrollView *)scrollView {
    kLog(@"%lf", scrollView.contentOffset.y);
    [self.headerView scrollViewDidScroll:scrollView.contentOffset.y];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    self.navigationController.interactivePopGestureRecognizer.enabled = (self.myCategoryView.selectedIndex == 0);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (JXPagerView *)preferredPagingView {
    return [[JXPagerView alloc] initWithDelegate:self];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.pagerView.frame = self.view.bounds;
}

#pragma mark - JXPagerViewDelegate

- (UIView *)tableHeaderViewInPagerView:(JXPagerView *)pagerView {
    return self.headerView;
}

- (NSUInteger)tableHeaderViewHeightInPagerView:(JXPagerView *)pagerView {
    return _JXTableHeaderViewHeight;
}

- (NSUInteger)heightForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return _categoryViewHeight;
}

- (UIView *)viewForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return self.myCategoryView;
}

- (NSInteger)numberOfListsInPagerView:(JXPagerView *)pagerView {
    /// 和categoryView的item数量一致
    return self.titles.count;
}

- (id<JXPagerViewListViewDelegate>)pagerView:(JXPagerView *)pagerView initListAtIndex:(NSInteger)index {
    
    if (self.homepageControllers.count >= index) {
        return self.homepageControllers[index];
    } else {
        return [[XYHomePagingSubViewController alloc] init];
    }
    
}

#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
}

#pragma mark - JXPagerMainTableViewGestureDelegate

- (BOOL)mainTableViewGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    /// 禁止categoryView左右滑动的时候，上下和左右都可以滚动
    if (otherGestureRecognizer == self.myCategoryView.collectionView.panGestureRecognizer) {
        return NO;
    }
    return [gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]];
}

- (JXCategoryIndicatorLineView *)lineView {
    if (!_lineView) {
        _lineView = [[JXCategoryIndicatorLineView alloc] init];
    }
    return _lineView;
}

- (JXCategoryTitleView *)myCategoryView {
    if (!_myCategoryView) {
        _myCategoryView = [[JXCategoryTitleView alloc] init];
    }
    return _myCategoryView;
}


@end
