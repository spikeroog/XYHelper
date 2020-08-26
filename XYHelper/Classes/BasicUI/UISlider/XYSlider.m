//
//  XYSlider.m
//  XYHelper
//
//  Created by spikeroog on 2018/12/26.
//  Copyright © 2018 spikeroog. All rights reserved.
//

#import "XYSlider.h"

@implementation XYSlider

//!< 重写 此方法 是为了 避免因添加图片  滑块在左边或者右边 时候漏出一点控件  滑块儿不靠边
- (CGRect)thumbRectForBounds:(CGRect)bounds
                   trackRect:(CGRect)rect
                       value:(float)value {

    // x 和 width 是滑块可触摸范围的大小，跟通过图片改变的滑块大小应当一致。
    rect.origin.x = rect.origin.x - 5 ;
    rect.size.width = rect.size.width + 10;
    return CGRectInset ([super thumbRectForBounds:bounds trackRect:rect value:value], 5 , 5);
}

//!< 可以改变高度
- (CGRect)trackRectForBounds:(CGRect)bounds {
    bounds.size.height = 15;
    self.layer.cornerRadius = 2.5;
    return bounds;
}

//!< 设置进度条两端图片的最大尺寸，图片是通过minimumValueImage和maximumValueImage这两个属性设置的
- (CGRect)maximumValueImageRectForBounds:(CGRect)bounds {
    return bounds;
}

//!<  设置进度条两端图片的最小尺寸，图片是通过minimumValueImage和maximumValueImage这两个属性设置的
- (CGRect)minimumValueImageRectForBounds:(CGRect)bounds {
    return bounds;
}

@end
