//
//  XYScrollViewController.m
//  XYHelper
//
//  Created by spikeroog on 2022/9/6.
//  Copyright © 2022 spikeroog. All rights reserved.
//

#import "XYBasicScrollViewController.h"
#import <Masonry/Masonry.h>

@interface XYBasicScrollViewController ()<UIScrollViewDelegate>

@end

@implementation XYBasicScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.basicScrollView = [[XYBasicScrollView alloc] init];
    self.basicScrollView.delegate = self;
    [self.view addSubview:self.basicScrollView];
    [self.basicScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

}

/// 用户将要拖拽时
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

}

/// 用户结束拖拽时
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {

}


@end
