//
//  XYBasicTableViewController.h
//  XYHelper
//
//  Created by spikeroog on 2022/8/29.
//  Copyright © 2022 spikeroog. All rights reserved.
//  自适应cell高度的tableViewController基类，包含数据为空的默认缺省图和上拉加载下拉刷新
//  子类如若需要调整tableView的位置，可使用remakeConstraint

#import "XYHelper.h"
#import "XYPlaceholderTableView.h"
#import "MJRefreshManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface XYBasicTableViewController : XYBasicViewController

@property (nonatomic, strong) XYPlaceholderTableView *basicTableView;

/// 配置
/// @param need 头部尾部视图高度是否自适应
- (void)estimatedSectionFooterHeight:(BOOL)need;

/// 注册cell
/// @param className cell的类名
- (void)registerClassWithName:(NSString *)className;

/// 注册头部尾部
/// @param headerfooterName 头部尾部的类名
- (void)registerHeaderFooterWithName:(NSString *)headerfooterName;

/// 刷新单元格
/// @param index section
- (void)reloadSection:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
