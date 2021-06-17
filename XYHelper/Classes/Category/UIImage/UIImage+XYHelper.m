//
//  UIImage+XYHelper.m
//  XYHelper
//
//  Created by spikeroog on 2018/12/18.
//  Copyright © 2018 spikeroog. All rights reserved.
//

#import "UIImage+XYHelper.h"
#import "UIImage+GIF.h"

@implementation UIImage (XYHelper)

#pragma mark - 圆角
/**
 通过CPU重新绘制一份带圆角的视图来实现圆角效果，会大大增加CPU的负担，而且相当于多了一份视图拷贝会增加内存开销。但是就显示性能而言，由于没有触发离屏渲染，所以能保持较高帧率。下例是绘制一个圆形图片，绘制其它UIView并无本质区别。重新绘制的过程可以交由后台线程来处理。
 在需要圆角时调用如下
 dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
 UIImage *img = [[UIImage imageNamed:@"image.png"] drawCircleImage];
 dispatch_async(dispatch_get_main_queue(), ^{
 view.image = img;
 });
 });
 
 @return 圆角图片
 */
- (UIImage *)drawCircleImage {
    CGFloat side = MIN(self.size.width, self.size.height);
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(side, side), false, [UIScreen mainScreen].scale);
    CGContextAddPath(UIGraphicsGetCurrentContext(),
                     [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, side, side)].CGPath);
    CGContextClip(UIGraphicsGetCurrentContext());
    CGFloat marginX = -(self.size.width - side) / 2.f;
    CGFloat marginY = -(self.size.height - side) / 2.f;
    [self drawInRect:CGRectMake(marginX, marginY, self.size.width, self.size.height)];
    CGContextDrawPath(UIGraphicsGetCurrentContext(), kCGPathFillStroke);
    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return output;
}

#pragma mark - 全屏截图
// 全屏截图
+ (UIImage *)xy_shotScreen {
    UIWindow *window = kKeyWindow;
    UIGraphicsBeginImageContext(window.bounds.size);
    [window.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - 截取view生成一张图片
// 截取view生成一张图片
+ (UIImage *)xy_shotWithView:(UIView *)view {
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - 截取view中某个区域生成一张图片
// 截取view中某个区域生成一张图片
+ (UIImage *)xy_shotWithView:(UIView *)view scope:(CGRect)scope {
    CGImageRef imageRef = CGImageCreateWithImageInRect([self xy_shotWithView:view].CGImage, scope);
    UIGraphicsBeginImageContext(scope.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, scope.size.width, scope.size.height);
    CGContextTranslateCTM(context, 0, rect.size.height); // 下移
    CGContextScaleCTM(context, 1.0f, -1.0f); // 上翻
    CGContextDrawImage(context, rect, imageRef);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRelease(imageRef);
    CGContextRelease(context);
    return image;
}

#pragma mark - 高效的，图片进行高斯模糊
/**
 高效的图片进行高斯模糊
 @param image 传入的图片
 @return 模糊的图片
 */
+ (UIImage *)xy_applyGaussianBlur:(UIImage *)image {
    CIImage *inputImage = [CIImage imageWithCGImage:image.CGImage];
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"
                                  keysAndValues:kCIInputImageKey, inputImage,
                        @"inputRadius", @(25.0f), nil];
    CIImage *outputImage = filter.outputImage;
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef outImage = [context createCGImage:outputImage fromRect:[inputImage extent]];
    UIImage * resultImage = [UIImage imageWithCGImage:outImage];
    CGImageRelease(outImage);
    return resultImage;
}

#pragma mark - 图片根据某个值压缩，如: 1024 ~> 1M
/**
 图片根据某个值压缩，如: 传1024 ~> 1M
 
 @param source_image 图片
 @param maxSize 最大的值，1MB传1024*1
 @return 压缩后的图片
 */
+ (NSData *)xy_resetSizeOfImageData:(UIImage *)source_image
                         maxSize:(NSInteger)maxSize {
    // 先判断当前质量是否满足要求，不满足再进行压缩
    __block NSData *finallImageData = UIImageJPEGRepresentation(source_image,1.0);
    NSUInteger sizeOrigin   = finallImageData.length;
    NSUInteger sizeOriginKB = sizeOrigin / 1024;
    
    if (sizeOriginKB <= maxSize) {
        return finallImageData;
    }
    
    // 先调整分辨率
    CGSize defaultSize = CGSizeMake(1024, 1024);
    UIImage *newImage = [self xy_newSizeImage:defaultSize image:source_image];
    
    finallImageData = UIImageJPEGRepresentation(newImage, 1.0);
    
    // 保存压缩系数
    NSMutableArray *compressionQualityArr = [NSMutableArray array];
    CGFloat avg   = 1.0/250;
    CGFloat value = avg;
    for (int i = 250; i >= 1; i--) {
        value = i * avg;
        [compressionQualityArr addObject:@(value)];
    }
    
    /*
     调整大小
     说明：压缩系数数组compressionQualityArr是从大到小存储。
     */
    // 思路：使用二分法搜索
    finallImageData = [self xy_halfFuntion:compressionQualityArr image:newImage sourceData:finallImageData maxSize:maxSize];
    // 如果还是未能压缩到指定大小，则进行降分辨率
    while (finallImageData.length == 0) {
        // 每次降100分辨率
        if (defaultSize.width-100 <= 0 || defaultSize.height-100 <= 0) {
            break;
        }
        defaultSize = CGSizeMake(defaultSize.width-100, defaultSize.height-100);
        UIImage *image = [self xy_newSizeImage:defaultSize
                                      image:[UIImage imageWithData:UIImageJPEGRepresentation(newImage,[[compressionQualityArr lastObject] floatValue])]];
        finallImageData = [self xy_halfFuntion:compressionQualityArr image:image sourceData:UIImageJPEGRepresentation(image,1.0) maxSize:maxSize];
    }
    return finallImageData;
}

// 调整图片分辨率/尺寸（等比例缩放）
+ (UIImage *)xy_newSizeImage:(CGSize)size
                    image:(UIImage *)source_image {
    CGSize newSize = CGSizeMake(source_image.size.width, source_image.size.height);
    
    CGFloat tempHeight = newSize.height / size.height;
    CGFloat tempWidth = newSize.width / size.width;
    
    if (tempWidth > 1.0 && tempWidth > tempHeight) {
        newSize = CGSizeMake(source_image.size.width / tempWidth, source_image.size.height / tempWidth);
    } else if (tempHeight > 1.0 && tempWidth < tempHeight) {
        newSize = CGSizeMake(source_image.size.width / tempHeight, source_image.size.height / tempHeight);
    }
    
    UIGraphicsBeginImageContext(newSize);
    [source_image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

// 二分法
+ (NSData *)xy_halfFuntion:(NSArray *)arr
                  image:(UIImage *)image
             sourceData:(NSData *)finallImageData
                maxSize:(NSInteger)maxSize {
    
    NSData *tempData = [NSData data];
    NSUInteger start = 0;
    NSUInteger end = arr.count - 1;
    NSUInteger index = 0;
    
    NSUInteger difference = NSIntegerMax;
    while(start <= end) {
        index = start + (end - start)/2;
        
        finallImageData = UIImageJPEGRepresentation(image,[arr[index] floatValue]);
        
        NSUInteger sizeOrigin = finallImageData.length;
        NSUInteger sizeOriginKB = sizeOrigin / 1024;
        kLog(@"当前降到的质量：%ld", (unsigned long)sizeOriginKB);
        kLog(@"\nstart：%zd\nend：%zd\nindex：%zd\n压缩系数：%lf", start, end, (unsigned long)index, [arr[index] floatValue]);
        
        if (sizeOriginKB > maxSize) {
            start = index + 1;
        } else if (sizeOriginKB < maxSize) {
            if (maxSize-sizeOriginKB < difference) {
                difference = maxSize-sizeOriginKB;
                tempData = finallImageData;
            }
            if (index <= 0) {
                break;
            }
            end = index - 1;
        } else {
            break;
        }
    }
    return tempData;
}

#pragma mark - 按尺寸裁剪图片
/**
 按尺寸裁剪图片
 
 @param sourceImage 需要操作的图片
 @param size 需要裁剪的尺寸
 @return 操作完成的图片
 */
+ (UIImage *)xy_imageCompressForSize:(UIImage *)sourceImage
                       targetSize:(CGSize)size {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if (CGSizeEqualToSize(imageSize, size) == NO) {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if (widthFactor > heightFactor) {
            scaleFactor = widthFactor;
        } else {
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor) {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        } else if (widthFactor < heightFactor) {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(size);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if (newImage == nil) {
        kLog(@"scale image fail");
    }
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark - 对图片进行滤镜处理
// 怀旧 --> CIPhotoEffectInstant                         单色 --> CIPhotoEffectMono
// 黑白 --> CIPhotoEffectNoir                            褪色 --> CIPhotoEffectFade
// 色调 --> CIPhotoEffectTonal                           冲印 --> CIPhotoEffectProcess
// 岁月 --> CIPhotoEffectTransfer                        铬黄 --> CIPhotoEffectChrome
// CILinearToSRGBToneCurve, CISRGBToneCurveToLinear, CIGaussianBlur, CIBoxBlur, CIDiscBlur, CISepiaTone, CIDepthOfField
+ (UIImage *)xy_filterWithOriginalImage:(UIImage *)image filterName:(NSString *)name {
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [[CIImage alloc] initWithImage:image];
    CIFilter *filter = [CIFilter filterWithName:name];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
    UIImage *resultImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return resultImage;
}

#pragma mark - 调整图片饱和度, 亮度, 对比度
/**
 调整图片饱和度, 亮度, 对比度
 
 @param image 目标图片
 @param saturation 饱和度
 @param brightness 亮度: -1.0 ~ 1.0
 @param contrast 对比度
 @return 处理后的图片
 */
+ (UIImage *)xy_colorControlsWithOriginalImage:(UIImage *)image
                                 saturation:(CGFloat)saturation
                                 brightness:(CGFloat)brightness
                                   contrast:(CGFloat)contrast {
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [[CIImage alloc] initWithImage:image];
    CIFilter *filter = [CIFilter filterWithName:@"CIColorControls"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    
    [filter setValue:@(saturation) forKey:@"inputSaturation"];
    [filter setValue:@(brightness) forKey:@"inputBrightness"]; // 0.0 ~ 1.0
    [filter setValue:@(contrast) forKey:@"inputContrast"];
    
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
    UIImage *resultImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return resultImage;
}

#pragma mark - 异步获取本地动态图片
/**
 异步获取本地动态图片
 
 @param gifName 动图名称
 @return 动态图片
 */
+ (UIImage *)xy_localGifWithName:(NSString *)gifName {
    NSData *data = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:gifName ofType:@"gif"]]];
    return [UIImage sd_imageWithGIFData:data];
}

#pragma mark - 图片还原默认角度
/**
 90度角度图片还原默认角度
 
 @param aImage 图片
 @return 图片
 */
+ (UIImage *)xy_fixOrientation:(UIImage *)aImage {
    // No-op if the orientation is already correct
    if (aImage.imageOrientation ==UIImageOrientationUp)
        return aImage;
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform =CGAffineTransformIdentity;
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width,0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width,0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height,0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx =CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                            CGImageGetBitsPerComponent(aImage.CGImage),0,
                                            CGImageGetColorSpace(aImage.CGImage),
                                            CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx,CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
        default:
            CGContextDrawImage(ctx,CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg =CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

#pragma mark - 颜色转图片
/**
 颜色转图片

 @param color 颜色
 @return 图片
 */
+ (UIImage *)xy_createImageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

#pragma mark - UIView，UIImageView转换成图片
+ (UIImage *)xy_convertViewToImage:(__kindof UIView *)view {
    CGSize size = view.bounds.size;
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需 要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(size, YES, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - 获取渐变颜色的图片

/**
 获取渐变颜色的图片
 传入两个颜色
 
 @param beginColor 开始颜色
 @param endColor 终止颜色
 @param bounds 显示的坐标大小 防止变形
 @return 渐变颜色的图片
 */
+ (UIImage *)transitionImageWithColor:(UIColor *)beginColor
                          andEndColor:(UIColor *)endColor
                               bounds:(CGRect)bounds {
    UIView *view = [[UIView alloc] initWithFrame:bounds];
    //横向渐变的路径
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)beginColor.CGColor, (__bridge id)endColor.CGColor];//这里颜色渐变
    gradientLayer.locations = @[@0.0, @1.0];//颜色位置
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = view.bounds;
    [view.layer addSublayer:gradientLayer];
    [view.layer insertSublayer:gradientLayer atIndex:0];
    
    UIImage *img = [UIImage xy_convertViewToImage:view];
    return img;
}

/// 改变图片颜色,使用方法：[kImageWithName(@"xx") imageWithColor:UIColor.blackColor];
- (UIImage *)imageWithColor:(UIColor *)color {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextClipToMask(context, rect, self.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

// 根据 aSize 返回一个新的image
- (UIImage *)drawImageBySize:(CGSize)aSize {
    
    UIGraphicsBeginImageContextWithOptions(aSize, NO, [UIScreen mainScreen].scale); // 解决缩小图片后反而模糊的问题
    [self drawInRect:CGRectMake(0, 0, aSize.width, aSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
