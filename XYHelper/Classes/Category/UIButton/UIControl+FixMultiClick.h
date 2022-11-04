//
//  UIControl+FixMultiClick.h
//  UIButtonSwizzling
//
//  Created by spikeroog on 2018/8/9.
//  Copyright © 2018年 spikeroog. All rights reserved.
//  防止多次点击，针对UIButton设置默认0.5s

#import <UIKit/UIKit.h>

@interface UIControl (FixMultiClick)
//点击间隔时间，防止多次点击
@property (nonatomic, assign) NSTimeInterval acceptEventInterval;
//记录每次的点击时间
@property (nonatomic, assign) NSTimeInterval acceptEventTime;

@end

