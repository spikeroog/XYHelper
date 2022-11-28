//
//  XYBasicTableViewController.h
//  XYHelper
//
//  Created by spikeroog on 2022/11/23.
//  Copyright © 2022 spikeroog. All rights reserved.
//

#import "XYBasicViewController.h"
#import "XYBasicTableView.h"

typedef void(^XYMJRefreshHeaderHandler) ();
typedef void(^XYMJRefreshFooterHandler) ();

NS_ASSUME_NONNULL_BEGIN

@interface XYBasicTableViewController : XYBasicViewController
@property (nonatomic, strong) XYBasicTableView *basicTableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) BOOL isNeedRefresh;
@property (nonatomic, assign) BOOL isNeedFooter;
@property (nonatomic, assign) BOOL isNeedHeader;

@property (nonatomic, copy) XYMJRefreshHeaderHandler headerHandler;
@property (nonatomic, copy) XYMJRefreshFooterHandler footerHandler;


/// 配置
/// @param need 头部尾部视图高度是否自适应
- (void)estimatedSectionHeaderFooterHeight:(BOOL)need;

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
