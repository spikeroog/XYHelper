//
//  XYBasicCollectionView.m
//  XYHelper
//
//  Created by spikeroog on 2022/11/23.
//  Copyright © 2022 spikeroog. All rights reserved.
//

#import "XYBasicCollectionView.h"

@interface XYBasicCollectionView ()
<DZNEmptyDataSetSource,
DZNEmptyDataSetDelegate>

@end

@implementation XYBasicCollectionView

- (instancetype)init {
    if (self = [super init]) {
        self.emptyDataSetSource = self;
        self.emptyDataSetDelegate = self;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.emptyDataSetSource = self;
        self.emptyDataSetDelegate = self;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
         collectionViewLayout:(UICollectionViewLayout *)layout {
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.emptyDataSetSource = self;
        self.emptyDataSetDelegate = self;

    }
    return self;
}

#pragma mark - DZNEmptyDataSetSource DZNEmptyDataSetDelegate

- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    return [[UIImage alloc] init];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:17],
                                 NSForegroundColorAttributeName:UIColor.blackColor
                                 };
    return [[NSAttributedString alloc] initWithString:@"" attributes:attributes];
}

// Y轴于屏幕中心的值，加上这个值self.emetyDataVerticalOffset后为最终的显示效果
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return 0;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    // click empty view
    !self.collectionViewEmptyViewClickBlock ? : self.collectionViewEmptyViewClickBlock();
}

// 如果不实现此方法的话,无数据时下拉刷新不可用
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}

// 点击无数据视图的时候 开始刷新数据
//- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {
//    [scrollView.mj_header beginRefreshing];
//}

@end
