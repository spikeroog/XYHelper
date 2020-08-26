//  UIView+XYHelper.h
//  MJRefreshExample
//
//  Created by MJ Lee on 14-5-28.
//  Copyright (c) 2014年 小码哥. All rights reserved.
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

