//
//  XYNestSubPagingViewController.h
//  XYHelper
//
//  Created by spikeroog on 2020/12/17.
//  Copyright © 2020 spikeroog. All rights reserved.
//

#import "XYBasicPagingViewController.h"
#import <JXCategoryView/JXCategoryView.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYNestSubPagingViewController : XYBasicPagingViewController
<JXCategoryListContentViewDelegate>
@property (nonatomic, strong) JXCategoryIndicatorLineView *lineView;
@property (nonatomic, strong) JXCategoryTitleView *myCategoryView;

@end

NS_ASSUME_NONNULL_END
