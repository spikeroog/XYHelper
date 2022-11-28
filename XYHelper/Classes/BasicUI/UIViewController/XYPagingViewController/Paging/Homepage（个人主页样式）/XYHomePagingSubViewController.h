//
//  XYHomePagingSubViewController.h
//  XYHelper
//
//  Created by spikeroog on 2022/11/23.
//  Copyright © 2022 spikeroog. All rights reserved.
//

#import "XYBasicTableViewController.h"
#import <JXPagingView/JXPagerView.h>
#import <Masonry/Masonry.h>
#import "XYHelperMarco.h"

NS_ASSUME_NONNULL_BEGIN

@interface XYHomePagingSubViewController : XYBasicTableViewController
<JXPagerViewListViewDelegate>
/// 是否个人主页样式，个人主页样式为顶部有可伸缩下拉的头部图片
@property (nonatomic, assign) BOOL isHomepageStyle;
/// 标签栏高度
@property (nonatomic, assign) NSInteger categoryViewHeight;
/// Y轴偏移量，默认为0，使用嵌套样式可用到
@property (nonatomic, assign) CGFloat categoryViewYOffset;

@end

NS_ASSUME_NONNULL_END
