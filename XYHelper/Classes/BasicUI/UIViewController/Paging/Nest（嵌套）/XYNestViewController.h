//
//  XYNestViewController.h
//  XYHelper
//
//  Created by spikeroog on 2020/12/16.
//  Copyright © 2020 spikeroog. All rights reserved.
//

#import "XYBasicPagingViewController.h"
#import "XYNestSubViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface XYNestViewController : XYBasicPagingViewController
@property (nonatomic, strong) NSArray <__kindof XYNestSubViewController *>*sublist;
@property (nonatomic, assign) CGRect categoryViewFrame;
/// 是否显示在titleView上
@property (nonatomic, assign) BOOL useTitleView;

@end

NS_ASSUME_NONNULL_END
