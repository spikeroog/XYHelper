//
//  UIImage+Extension.m
//  BiBiClick
//
//  Created by spikeroog on 2017/10/25.
//  Copyright © 2017年 spikeroog. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

- (void)ui_cornerImageWithSize:(CGSize)size fillColor:(UIColor *)fillColor completion:(void (^)(UIImage *))completion {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        UIGraphicsBeginImageContextWithOptions(size, YES, 0);
        
        CGRect rect = CGRectMake(0, 0, size.width, size.height);

        [fillColor setFill];
        
        UIRectFill(rect);

        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
        
        [path addClip];
        
        [self drawInRect:rect];
        
        UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion != nil) {
                completion(result);
            }
        });
    });
}

@end
