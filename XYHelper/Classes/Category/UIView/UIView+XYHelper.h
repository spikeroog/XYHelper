//  UIView+XYHelper.h
//  XYHelper
//
//  Created by spikeroog on 14-5-28.
//  Copyright (c) 2018年 spikeroog. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XYHelper)
@property (assign, nonatomic) CGFloat xy_x;
@property (assign, nonatomic) CGFloat xy_y;
@property (assign, nonatomic) CGFloat xy_w;
@property (assign, nonatomic) CGFloat xy_h;

@property (assign, nonatomic) CGFloat xy_centerX;
@property (assign, nonatomic) CGFloat xy_centerY;

@property (assign, nonatomic) CGSize xy_size;
@property (assign, nonatomic) CGPoint xy_origin;
@end

