//
//  MJRefreshManager.m
//  XYHelper
//
//  Created by spikeroog on 2018/11/28.
//  Copyright © 2018 spikeroog. All rights reserved.
//

#import "MJRefreshManager.h"
#import <MJRefresh/MJRefresh.h>

@interface MJRefreshManager ()
@property (nonatomic, copy) MJPullUpRefresh pullUpRefresh;
@property (nonatomic, copy) MJPullDownRefresh pullDownRefresh;

@end

@implementation MJRefreshManager

- (void)dealloc {
    
}

/**
 为tableView或者collectionView添加下拉刷新
 参数传nil就是默认
 
 @param targetView 传入的tableView或者collectionView
 
 @param pullDownCallBack 下拉刷新回调
 */
- (void)initialMJHeaderWithTargetView:(__kindof UIScrollView *)targetView
                     pullDownCallBack:(MJPullDownRefresh)pullDownCallBack {
    
    if (!targetView) return ;
    
    self.pullDownRefresh = pullDownCallBack;
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullDownMethod)];
    
    // 设置初始时、下拉时、刷新时标题
    [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"松开立即刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"正在进行刷新" forState:MJRefreshStateRefreshing];
    header.lastUpdatedTimeLabel.hidden = YES; // 隐藏时间label
    
    header.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    targetView.mj_header = header;
}

/**
 为tableView或者collectionView添加上拉加载
 参数传nil就是默认
 
 @param targetView 传入的tableView或者collectionView
 @param pullUpCallBack 上拉加载回调
 */
- (void)initialMJFooterWithTargetView:(__kindof UIScrollView *)targetView
                       pullUpCallBack:(MJPullUpRefresh)pullUpCallBack {

    
    if (!targetView) return ;
    
    self.pullUpRefresh = pullUpCallBack;
    
    // 如果没传图片，默认是原始footer
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(pullUpMethod)];
    // 设置初始时、下拉时、刷新时标题
    [footer setTitle:@"上拉可以加载更多" forState:MJRefreshStateIdle];
    [footer setTitle:@"松开立即加载更多" forState:MJRefreshStatePulling];
    [footer setTitle:@"正在加载更多数据" forState:MJRefreshStateRefreshing];
    
    footer.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    targetView.mj_footer = footer;
}

#pragma mark - Method
- (void)pullDownMethod {
    if (self.pullDownRefresh) {
        self.pullDownRefresh();
    }
}

- (void)pullUpMethod {
    if (self.pullUpRefresh) {
        self.pullUpRefresh();
    }
}

@end
