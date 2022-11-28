//
//  XYMJRefreshManager.h
//  XYHelper
//
//  Created by spikeroog on 2022/11/23.
//  Copyright © 2022 spikeroog. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJRefresh/MJRefresh.h>

typedef void(^XYMJPullUpRefresh)(void); // 上拉
typedef void(^XYMJPullDownRefresh)(void); // 下拉

NS_ASSUME_NONNULL_BEGIN

@interface XYMJRefreshManager : NSObject
@property (nonatomic, assign) NSInteger pageNumber;

/**
 为tableView或者collectionView添加下拉刷新
 参数传nil就是默认
 
 @param targetView 传入的tableView或者collectionView
 
 @param pullDownCallBack 下拉刷新回调
 */
- (void)initialMJHeaderWithTargetView:(__kindof UIScrollView *)targetView
                     pullDownCallBack:(XYMJPullDownRefresh)pullDownCallBack;

/**
 为tableView或者collectionView添加上拉加载
 参数传nil就是默认
 
 @param targetView 传入的tableView或者collectionView
 
 @param pullUpCallBack 上拉加载回调
 */
- (void)initialMJFooterWithTargetView:(__kindof UIScrollView *)targetView
                       pullUpCallBack:(XYMJPullUpRefresh)pullUpCallBack;

@end

NS_ASSUME_NONNULL_END
