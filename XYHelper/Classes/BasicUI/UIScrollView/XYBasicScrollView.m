//
//  XYBasicScrollView.m
//  XYHelper
//
//  Created by spikeroog on 2022/8/29.
//  Copyright © 2022 spikeroog. All rights reserved.
//

#import "XYBasicScrollView.h"
#import "XYHelperMarco.h"

@implementation XYBasicScrollView

- (instancetype)init {
    if (self = [super init]) {
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        self.alwaysBounceVertical = true;
        self.pagingEnabled = false;
        self.bounces = true;
        self.showsHorizontalScrollIndicator = false;
        self.showsVerticalScrollIndicator = false;
        self.clipsToBounds = true;
        self.layer.masksToBounds = true;
        self.contentSize = CGSizeMake(kScreenWidth , kScreenHeight-kNavBarHeight);
        /// 显示中间的图片
        self.contentOffset = CGPointMake(0, kScreenHeight-kNavBarHeight);
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        self.alwaysBounceVertical = true;
        self.pagingEnabled = false;
        self.bounces = true;
        self.showsHorizontalScrollIndicator = false;
        self.showsVerticalScrollIndicator = false;
        self.clipsToBounds = true;
        self.layer.masksToBounds = true;
        self.contentSize = CGSizeMake(kScreenWidth , kScreenHeight-kNavBarHeight);
        /// 显示中间的图片
        self.contentOffset = CGPointMake(0, kScreenHeight-kNavBarHeight);
    }
    return self;
}

- (void)dealloc {
    self.delegate = nil;
}

@end
