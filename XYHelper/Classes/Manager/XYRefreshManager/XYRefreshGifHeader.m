//
//  XYRefreshGifHeader.m
//  XYHelper
//
//  Created by spikeroog on 2019/9/19.
//  Copyright © 2019年 spikeroog. All rights reserved.
//

#import "XYRefreshGifHeader.h"
#import "XYHelperMarco.h"

@implementation XYRefreshGifHeader

#pragma mark - 重写方法

- (void)placeSubviews{
    [super placeSubviews];
    // 隐藏时间label
    self.lastUpdatedTimeLabel.hidden = YES;
    // 隐藏状态label
    self.stateLabel.hidden = YES;
}

#pragma mark 基本设置
- (void)prepare {
    [super prepare];
    
    // 设置普通状态的动画图片
    [self setImages:@[kImageWithName(@"img_mj_stateIdle")] forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [self setImages:@[kImageWithName(@"img_mj_statePulling")] forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSInteger i = 0; i < 20; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"img_mj_stateRefreshing_%ld", (long)i]];
        [refreshingImages addObject:image];
    }
    
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
}

// 修改header动画速度，默认0.1，改为0.05则速度提升一倍
- (void)setImages:(NSArray *)images forState:(MJRefreshState)state {
    [super setImages:images forState:state];
    
    [self setImages:images duration:images.count * 0.05 forState:state];
}

@end
