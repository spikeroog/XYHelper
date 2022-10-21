//
//  UIImageView+Extension.h
//  BiBiClick
//
//  Created by spikeroog on 2017/8/2.
//  Copyright © 2017年 spikeroog. All rights reserved.
//

#import "UIImageView+Extension.h"

@implementation UIImageView (Extension)

+ (instancetype)ui_imageViewWithImageName:(NSString *)imageName
                             cornerRadius:(NSInteger)cornerRadius contentMode:(UIViewContentMode)contentMode {
    
    UIImage *image;
    if (imageName == nil || imageName.length == 0) {
        image = nil;
    } else {
        image = [UIImage imageNamed:imageName];
    }
    
    UIImageView * imagev = [[self alloc] initWithImage:image];
    imagev.layer.cornerRadius = cornerRadius;
    if (cornerRadius > 0) {
        imagev.layer.masksToBounds = true;
    }
    imagev.contentMode = contentMode;
    if (contentMode == UIViewContentModeScaleAspectFill) {
        imagev.clipsToBounds = YES;
    }
    
    return imagev;
}

- (UIImage *)ui_imageClipImage:(UIImage *)image size:(CGSize)size{
    
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    
    return result;
}

@end
