//
//  UIView+XYPop.h
//  XYHelper
//
//  Created by spikeroog on 2019/8/29.
//  Copyright © 2019年 spikeroog. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, XYViewPopStyle) {
    XYViewPopStyleBottom = 0, // 视图从底部弹出
    XYViewPopStyleCenter // 视图从中间弹出
};

@interface UIView (XYPop)
@property (nonatomic, assign) XYViewPopStyle xy_popStyle;

@end

NS_ASSUME_NONNULL_END
