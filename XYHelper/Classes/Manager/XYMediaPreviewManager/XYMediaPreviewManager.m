//
//  XYMediaPreviewManager.m
//  XYHelper
//
//  Created by spikeroog on 2020/9/1.
//  Copyright © 2020 spikeroog. All rights reserved.
//

#import "XYMediaPreviewManager.h"
#import <YBImageBrowser/YBImageBrowser.h> // 浏览图片
#import <YBImageBrowser/YBIBVideoData.h> // 浏览视频
#import <YYCategories/YYCategories.h>


@implementation XYMediaPreviewManager

/// 预览图片
/// @param urls 图片url数组
/// @param projectiveViews 图片view视图数组，如：cell.imageView
/// @param idx 图片下标
+ (void)previewImageWithUrl:(NSArray<NSString *> *)urls
             projectiveView:(NSArray<__kindof UIView *> *)projectiveViews
                        idx:(NSInteger)idx {
    
    NSMutableArray *imageArrayMut = [NSMutableArray new];
    [urls enumerateObjectsUsingBlock:^(id  _Nonnull singleObj, NSUInteger singleIdx, BOOL * _Nonnull singleStop) {
        id view = [projectiveViews objectOrNilAtIndex:singleIdx];
        YBIBImageData *data = [YBIBImageData new];
        data.imageURL = singleObj;
        data.projectiveView = view;
        [imageArrayMut addObject:data];
    }];
    
    YBImageBrowser *browser = [YBImageBrowser new];
    browser.dataSourceArray = imageArrayMut;
    browser.currentPage = idx;
    [browser show];
}


/// 预览视频
/// @param urls 视频url数组
/// @param projectiveViews 视频view视图数组，如：cell.imageView
/// @param idx 视频下标
+ (void)previewVideoWithUrl:(NSArray<NSString *> *)urls
             projectiveView:(NSArray<__kindof UIView *> *)projectiveViews
                        idx:(NSInteger)idx {
    NSMutableArray *videoArrayMut = [NSMutableArray new];
    [urls enumerateObjectsUsingBlock:^(id  _Nonnull singleObj, NSUInteger singleIdx, BOOL * _Nonnull singleStop) {
        id view = [projectiveViews objectOrNilAtIndex:singleIdx];
        YBIBVideoData *data = [YBIBVideoData new];
        data.videoURL = singleObj;
        data.projectiveView = view;
        [videoArrayMut addObject:data];
    }];
    
    YBImageBrowser *browser = [YBImageBrowser new];
    browser.dataSourceArray = videoArrayMut;
    browser.currentPage = idx;
    [browser show];
}

@end
