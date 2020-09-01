//
//  XYMediaPreviewManager.h
//  XYHelper
//
//  Created by spikeroog on 2020/9/1.
//  Copyright © 2020 spikeroog. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYMediaPreviewManager : NSObject


/// 预览图片
/// @param urls 图片url数组
/// @param projectiveViews 图片view视图数组，如：cell.imageView
/// @param idx 图片下标
- (void)previewImageWithUrl:(NSArray<NSString *> *)urls
             projectiveView:(NSArray<__kindof UIView *> *)projectiveViews
                        idx:(NSInteger)idx;


/// 预览视频
/// @param urls 视频url数组
/// @param projectiveViews 视频view视图数组，如：cell.imageView
/// @param idx 视频下标
- (void)previewVideoWithUrl:(NSArray<NSString *> *)urls
             projectiveView:(NSArray<__kindof UIView *> *)projectiveViews
                        idx:(NSInteger)idx;

@end

NS_ASSUME_NONNULL_END
