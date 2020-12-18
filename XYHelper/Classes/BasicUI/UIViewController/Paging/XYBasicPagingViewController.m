//
//  XYBasicPagingViewController.m
//  XYHelper
//
//  Created by spikeroog on 2020/12/15.
//  Copyright © 2020 spikeroog. All rights reserved.
//

#import "XYBasicPagingViewController.h"

@interface XYBasicPagingViewController ()

@end

@implementation XYBasicPagingViewController

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    if (self.barHidden) {
        self.categoryView.frame = CGRectMake(0, kStatusBarHeight+self.categoryViewYOffset, self.view.bounds.size.width, [self preferredCategoryViewHeight]);
        self.listContainerView.frame = CGRectMake(0, kStatusBarHeight+(self.categoryViewHeight > 0 ? self.categoryViewHeight : 44)+self.categoryViewYOffset, self.view.bounds.size.width, self.view.bounds.size.height);
    } else {
        self.categoryView.frame = CGRectMake(0, self.categoryViewYOffset, self.view.bounds.size.width, [self preferredCategoryViewHeight]);
        self.listContainerView.frame = CGRectMake(0, [self preferredCategoryViewHeight]+self.categoryViewYOffset, self.view.bounds.size.width, self.view.bounds.size.height);
    }
    
    
    [self.view addSubview:self.categoryView];
    [self.view addSubview:self.listContainerView];
    
  
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    // 处于第一个item的时候，才允许屏幕边缘手势返回
    self.navigationController.interactivePopGestureRecognizer.enabled = (self.categoryView.selectedIndex == 0);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    // 离开页面的时候，需要恢复屏幕边缘手势，不能影响其他页面
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

#pragma mark - Custom Accessors

// 分页菜单视图
- (JXCategoryBaseView *)categoryView {
    if (!_categoryView) {
        _categoryView = [self preferredCategoryView];
        _categoryView.delegate = self;
        
        // !!!: 将列表容器视图关联到 categoryView
        _categoryView.listContainer = self.listContainerView;
    }
    return _categoryView;
}

// 列表容器视图
- (JXCategoryListContainerView *)listContainerView {
    if (!_listContainerView) {
        _listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
    }
    return _listContainerView;
}

#pragma mark - Public

- (JXCategoryBaseView *)preferredCategoryView {
    return [[JXCategoryBaseView alloc] init];
}

- (CGFloat)preferredCategoryViewHeight {
    return self.categoryViewHeight > 0 ? self.categoryViewHeight : 44;
}

#pragma mark - JXCategoryViewDelegate

// 点击选中或者滚动选中都会调用该方法。适用于只关心选中事件，不关心具体是点击还是滚动选中的。
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    kLog(@"%@", NSStringFromSelector(_cmd));
    
    // 侧滑手势处理
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
}

// 滚动选中的情况才会调用该方法
- (void)categoryView:(JXCategoryBaseView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index {
    kLog(@"%@", NSStringFromSelector(_cmd));
}

#pragma mark - JXCategoryListContainerViewDelegate

// 返回列表的数量
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titles.count;
}

// 返回各个列表菜单下的实例，该实例需要遵守并实现 <JXCategoryListContentViewDelegate> 协议
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    return self.controllers[index];
}

@end
