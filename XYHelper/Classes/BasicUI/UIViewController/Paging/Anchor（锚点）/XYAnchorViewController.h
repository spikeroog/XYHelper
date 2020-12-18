//
//  XYAnchorViewController.h
//  XYHelper
//
//  Created by spikeroog on 2020/12/16.
//  Copyright © 2020 spikeroog. All rights reserved.
//

#import "XYBasicPagingViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface XYAnchorViewController : XYBasicPagingViewController
@property (nonatomic, strong) JXCategoryTitleView *myCategoryView;
@property (nonatomic, strong) JXCategoryIndicatorLineView *lineView;

@end

NS_ASSUME_NONNULL_END
