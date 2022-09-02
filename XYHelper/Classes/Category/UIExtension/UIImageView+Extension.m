//
//  UIImageView+Extension.h
//  BiBiClick
//
//  Created by spikeroog on 2017/8/2.
//  Copyright © 2017年 spikeroog. All rights reserved.
//

#import "UIImageView+Extension.h"

@implementation UIImageView (Extension)

+ (instancetype)ui_imageViewWithImageName:(NSString *)imageName {
    
    return [[self alloc] initWithImage:[UIImage imageNamed:imageName]];
}

- (UIImage *)ui_imageClipImage:(UIImage *)image size:(CGSize)size{
    
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    
    return result;
}

@end
