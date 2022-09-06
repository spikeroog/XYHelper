//
//  UIImageView+Extension.h
//  BiBiClick
//
//  Created by spikeroog on 2017/8/2.
//  Copyright © 2017年 spikeroog. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Extension)

/// 使用图像名创建图像视图
///
/// @param imageName 图像名称
///
/// @return UIImageView
+ (instancetype)ui_imageViewWithImageName:(NSString *)imageName
                             cornerRadius:(NSInteger)cornerRadius contentMode:(UIViewContentMode)contentMode;

///  根据imageView大小裁切图片
- (UIImage *)ui_imageClipImage:(UIImage *)image size:(CGSize)size;

@end
