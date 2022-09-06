//
//  MJRefreshManager.h
//  XYHelper
//
//  Created by spikeroog on 2018/11/28.
//  Copyright © 2018 spikeroog. All rights reserved.
//
//当我们想要实现各个界面互不影响，由于单例只会初始化一次会有多个界面互相影响的问题，不能使用单例，只能将工具类声明成类的属性，再单独调用，如:@property (nonatomic, strong) MJRefreshManager *mjRefreshManager;

#import <Foundation/Foundation.h>
#import "MJRefreshManager.h"

typedef void(^MJPullUpRefresh)(void); // 上拉
typedef void(^MJPullDownRefresh)(void); // 下拉

NS_ASSUME_NONNULL_BEGIN

@interface MJRefreshManager : NSObject

@property (nonatomic, assign) NSInteger pageNumber;

/**
 为tableView或者collectionView添加下拉刷新
 参数传nil就是默认
 
 @param targetView 传入的tableView或者collectionView
 
 @param pullDownCallBack 下拉刷新回调
 */
- (void)initialMJHeaderWithTargetView:(__kindof UIScrollView *)targetView
                     pullDownCallBack:(MJPullDownRefresh)pullDownCallBack;

/**
 为tableView或者collectionView添加上拉加载
 参数传nil就是默认
 
 @param targetView 传入的tableView或者collectionView
 
 @param pullUpCallBack 上拉加载回调
 */
- (void)initialMJFooterWithTargetView:(__kindof UIScrollView *)targetView
                       pullUpCallBack:(MJPullUpRefresh)pullUpCallBack;

@end

NS_ASSUME_NONNULL_END
