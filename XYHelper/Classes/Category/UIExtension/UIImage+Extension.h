//
//  UIImage+Extension.h
//  BiBiClick
//
//  Created by spikeroog on 2017/10/25.
//  Copyright © 2017年 spikeroog. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/// 根据当前图像，和指定的尺寸，生成圆角图像并且返回
- (void)ui_cornerImageWithSize:(CGSize)size fillColor:(UIColor *)fillColor completion:(void (^)(UIImage *))completion;

@end
