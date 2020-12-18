//
//  XYNestSubViewController.m
//  XYHelper
//
//  Created by spikeroog on 2020/12/17.
//  Copyright © 2020 spikeroog. All rights reserved.
//

#import "XYNestSubViewController.h"

@interface XYNestSubViewController ()

@end

@implementation XYNestSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    //作为嵌套的子容器，不需要处理侧滑手势处理。示例demo因为是继承，所以直接覆盖掉该代理方法，达到父类不调用下面一行处理侧滑手势的代码。
    //    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
}

#pragma mark - JXCategoryListContentViewDelegate

- (UIView *)listView {
    return self.view;
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
