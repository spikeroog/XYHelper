//
//  XYNestPagingViewController.m
//  XYHelper
//
//  Created by spikeroog on 2020/12/16.
//  Copyright © 2020 spikeroog. All rights reserved.
//

#import "XYNestPagingViewController.h"
#import "XYNestSubPagingViewController.h"

@interface XYNestPagingViewController ()
@property (nonatomic, strong) JXCategoryTitleView *myCategoryView;
@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation XYNestPagingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.myCategoryView.titles = self.titles;
    self.myCategoryView.frame = self.categoryViewFrame;
    
    if (self.useTitleView) {
        [self.myCategoryView removeFromSuperview];
        self.navigationItem.titleView = self.myCategoryView;
    } else {
        [self.view addSubview:self.myCategoryView];
    }
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.myCategoryView.frame = self.categoryViewFrame;
}

- (CGRect)categoryViewFrame {
    CGRect frame = _categoryViewFrame;
    frame.origin.y += self.navBarHidden ? kStatusBarHeight : 0;
    return frame;
}

- (JXCategoryTitleView *)myCategoryView {
    return (JXCategoryTitleView *)self.categoryView;
}

- (CGFloat)preferredCategoryViewHeight {
    return 0;
}

- (JXCategoryBaseView *)preferredCategoryView {
    return [[JXCategoryTitleView alloc] init];
}

#pragma mark - JXCategoryListContainerViewDelegate

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    return self.sublist[index];
}

#pragma mark - JXCategoryListContainerViewDelegate

- (void)listContainerViewDidScroll:(UIScrollView *)scrollView{
    if ([self isKindOfClass:[XYNestSubPagingViewController class]]) {
        CGFloat index = scrollView.contentOffset.x/scrollView.bounds.size.width;
        CGFloat absIndex = fabs(index - self.currentIndex);
        if (absIndex >= 1) {
            //”快速滑动的时候，只响应最外层VC持有的scrollView“，说实话，完全可以不用处理这种情况。如果你们的产品经理坚持认为这是个问题，就把这块代码加上吧。
            //嵌套使用的时候，最外层的VC持有的scrollView在翻页之后，就断掉一次手势。解决快速滑动的时候，只响应最外层VC持有的scrollView。子VC持有的scrollView却没有响应
            self.listContainerView.scrollView.panGestureRecognizer.enabled = NO;
            self.listContainerView.scrollView.panGestureRecognizer.enabled = YES;
            _currentIndex = floor(index);
        }
    }
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
