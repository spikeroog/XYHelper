//
//  XYViewController.m
//  XYHelper
//
//  Created by spikeroog on 2020/12/15.
//  Copyright © 2020 spikeroog. All rights reserved.
// 

#import "XYViewController.h"

@interface XYViewController ()

@end

@implementation XYViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"首页";
    
    /// 导航栏背景颜色
    self.navBgImageStr = @"launcher_image_2020_0709";
    /// 导航栏标题颜色
    self.navTitleColor = UIColor.redColor;
    /// 导航栏按钮字体颜色
    self.hbd_tintColor = UIColor.redColor;
    self.hbd_barStyle = UIBarStyleBlack;
    
    self.leftBarItemTitle = @"嵌套使用";
    self.rightBarItemTitle = @"底部锚点";
   
    self.view.backgroundColor = UIColor.redColor;
    
    self.isWhiteStatusBar = true;
}

- (void)leftActionInController {
    XYNestViewController *vc = [[XYNestViewController alloc] init];
    vc.isWhiteStatusBar = false;
    vc.title = @"嵌套使用";
    vc.titles = @[@"主题一", @"主题二"];
    
    CGFloat yOffset = 0;
    vc.categoryViewYOffset = yOffset;
    /// 可自定义categoryView的frame
//    vc.categoryViewFrame = CGRectMake((kScreenWidth-180)/2, yOffset, 180, 30);
    vc.categoryViewFrame = CGRectMake(0, yOffset, 180, 30);

    /// 是否显示在titleView上
    vc.useTitleView = true;
    
//    vc.barHidden = true;
    
    JXCategoryTitleView *titleCategoryView = (JXCategoryTitleView *)vc.categoryView;
    titleCategoryView.layer.cornerRadius = 15;
    titleCategoryView.layer.masksToBounds = YES;
    titleCategoryView.layer.borderColor = [UIColor blackColor].CGColor;
    titleCategoryView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    titleCategoryView.cellSpacing = 0;
    titleCategoryView.titleColor = [UIColor blackColor];
    titleCategoryView.titleSelectedColor = [UIColor cyanColor];
    titleCategoryView.titleLabelMaskEnabled = YES;
    
    JXCategoryIndicatorLineView *backgroundView = [[JXCategoryIndicatorLineView alloc] init];
    backgroundView.lineStyle = JXCategoryIndicatorLineStyle_Lengthen;
    backgroundView.indicatorHeight = 30;
    backgroundView.indicatorWidthIncrement = 60;
    backgroundView.indicatorColor = kColorWithOpacity(UIColor.redColor, 0.3);
    titleCategoryView.indicators = @[backgroundView];
    
//    vc.barHidden = random()%2 > 0 ? true : false;

    XYNestSubViewController *listVC_1 = [XYNestSubViewController new];
    XYNestSubViewController *listVC_2 = [XYNestSubViewController new];
    
    listVC_1.lineView.indicatorColor = UIColor.blackColor;
    listVC_1.myCategoryView.titleColor = kColor666666;
    listVC_1.myCategoryView.titleSelectedColor = UIColor.blackColor;
    listVC_1.myCategoryView.titleColorGradientEnabled = YES;
    listVC_1.myCategoryView.titleLabelZoomEnabled = YES;
    listVC_1.myCategoryView.titleLabelZoomScale = 1.3;
    listVC_1.myCategoryView.titleLabelStrokeWidthEnabled = YES;
    listVC_1.myCategoryView.selectedAnimationEnabled = YES;
    listVC_1.myCategoryView.cellWidthZoomEnabled = YES;
    listVC_1.myCategoryView.cellWidthZoomScale = 1.3;
    
    
    listVC_2.lineView.indicatorColor = UIColor.redColor;
    listVC_2.myCategoryView.titleColor = kColor333333;
    listVC_2.myCategoryView.titleSelectedColor = UIColor.redColor;
    listVC_2.myCategoryView.titleFont = kBoldFontWithSize(14);
    listVC_2.myCategoryView.titleColorGradientEnabled = YES;
    listVC_2.myCategoryView.titleLabelZoomEnabled = YES;
    listVC_2.myCategoryView.titleLabelZoomScale = 1.5;
    listVC_2.myCategoryView.cellWidthZoomEnabled = YES;
    listVC_2.myCategoryView.cellWidthZoomScale = 1.5;
    listVC_2.myCategoryView.titleLabelAnchorPointStyle = JXCategoryTitleLabelAnchorPointStyleBottom;
    listVC_2.myCategoryView.selectedAnimationEnabled = YES;
    listVC_2.myCategoryView.titleLabelZoomSelectedVerticalOffset = 3;


    listVC_1.titles = @[@"乐库", @"推荐", @"鱼", @"海星"];
    listVC_1.controllers = @[[self getVc],[self getVc],[self getVc],[self getVc]];
    listVC_2.titles = @[@"视频", @"看点",@"葡萄", @"美味西瓜", @"香蕉"];
    listVC_2.controllers = @[[self getVc],[self getVc],[self getVc],[self getVc],[self getVc]];

    vc.sublist = @[listVC_1,listVC_2];
    [XYHelperRouter pushViewController:vc completion:^{
        
    }];
}

- (void)rightActionInController {
    XYAnchorViewController *subViewC = [XYAnchorViewController new];
    subViewC.isWhiteStatusBar = false;
    subViewC.title = @"底部锚点";
    subViewC.categoryViewHeight = 44;
    subViewC.lineView.indicatorColor = kColorWithNull;
    
//    subViewC.categoryViewYOffset = 100;
//    subViewC.barHidden = random()%2 > 0 ? true : false;
    
    subViewC.titles = @[@"乐库", @"推荐", @"视频", @"看点"/*, @"葡萄", @"美味西瓜", @"香蕉", @"香甜菠萝", @"鸡肉", @"鱼", @"海星"*/];
    subViewC.controllers = @[[self getVc],[self getVc],[self getVc],[self getVc]];
    
    JXCategoryTitleView *titleCategoryView = (JXCategoryTitleView *)subViewC.categoryView;
    titleCategoryView.titleColorGradientEnabled = YES;
    titleCategoryView.titleLabelZoomEnabled = YES;
    titleCategoryView.titleLabelZoomScale = 1.85;
    titleCategoryView.cellWidthZoomEnabled = YES;
    titleCategoryView.cellWidthZoomScale = 1.85;
    titleCategoryView.titleLabelAnchorPointStyle = JXCategoryTitleLabelAnchorPointStyleBottom;
    titleCategoryView.selectedAnimationEnabled = YES;
    titleCategoryView.titleLabelZoomSelectedVerticalOffset = 3;
    titleCategoryView.titleColor = kColor333333;
    titleCategoryView.titleSelectedColor = UIColor.blackColor;
    titleCategoryView.titleFont = kBoldFontWithSize(18);
       
    [XYHelperRouter pushViewController:subViewC completion:^{
        
    }];
}

- (id)getVc {
    XYBasicViewController * vc = [XYBasicViewController new];
    vc.view.backgroundColor = kColorWithRandom;
    return vc;
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
