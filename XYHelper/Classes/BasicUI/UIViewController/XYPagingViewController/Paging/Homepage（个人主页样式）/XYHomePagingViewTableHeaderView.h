//
//  XYHomePagingViewTableHeaderView.h
//  XYHelper
//
//  Created by spikeroog on 2022/11/23.
//  Copyright © 2022 spikeroog. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYHomePagingViewTableHeaderView : UIView
@property (nonatomic, strong) UIImageView *imageView;
- (void)scrollViewDidScroll:(CGFloat)contentOffsetY;

@end

NS_ASSUME_NONNULL_END
