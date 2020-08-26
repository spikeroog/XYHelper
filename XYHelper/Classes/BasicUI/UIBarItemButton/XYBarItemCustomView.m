//
//  XYBarItemCustomView.m
//  XYHelper
//
//  Created by spikeroog on 2019/11/6.
//  Copyright © 2020 spikeroog. All rights reserved.
//

#import "XYBarItemCustomView.h"

@implementation XYBarItemCustomView

/// iOS11及以上，设置这个方法能只能保证 item 距离屏幕的边缘为 8 - 12 pt，如果你想让 item 与屏幕的距离更近一些的话，就可能会出现其他的问题
- (UIEdgeInsets)alignmentRectInsets {
    return _isRight ? UIEdgeInsetsMake(0, -_offset, 0, _offset) : UIEdgeInsetsMake(0, _offset, 0, -_offset);
}



@end
