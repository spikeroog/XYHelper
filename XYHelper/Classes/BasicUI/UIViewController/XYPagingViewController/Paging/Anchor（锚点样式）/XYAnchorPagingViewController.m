//
//  XYAnchorPagingViewController.m
//  XYHelper
//
//  Created by spikeroog on 2020/12/16.
//  Copyright © 2020 spikeroog. All rights reserved.
//

#import "XYAnchorPagingViewController.h"

@interface XYAnchorPagingViewController ()

@end

@implementation XYAnchorPagingViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myCategoryView.titles = self.titles;
    self.myCategoryView.indicators = @[self.lineView];
}

- (JXCategoryIndicatorLineView *)lineView {
    if (!_lineView) {
        _lineView = [[JXCategoryIndicatorLineView alloc ]init];
    }
    return _lineView;
}

- (JXCategoryTitleView *)myCategoryView {
    return (JXCategoryTitleView *)self.categoryView;
}

- (JXCategoryBaseView *)preferredCategoryView {
    return [[JXCategoryTitleView alloc] init];
}

@end
