//
//  XYBarItemCustomView.h
//  XYHelper
//
//  Created by spikeroog on 2019/11/6.
//  Copyright © 2020 spikeroog. All rights reserved.
//  设置自定义barItemView的间距，ios11及以上，ios10及以下两种情况的适配

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYBarItemCustomView : UIButton

/// 该barItemView是左边的，还是右边的
@property (nonatomic, assign) BOOL isRight;

/// 一般设置为8即可
@property (nonatomic, assign) NSInteger offset;

@end

NS_ASSUME_NONNULL_END
