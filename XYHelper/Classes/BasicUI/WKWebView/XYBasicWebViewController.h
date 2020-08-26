//
//  XYBasicWebViewController.h
//  XYHelper
//
//  Created by spikeroog on 2020/8/26.
//

#import "XYBasicViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface XYBasicWebViewController : XYBasicViewController

/**
 加载js网页
 
 @param urlString @""
 */
- (void)localHtmlWithUrl:(NSString *)urlString;

/**
 加载本地js文件
 
 @param localFile @"JStoOC.html"
 */
- (void)localHtmlWithLocalFile:(NSString *)localFile;

@end

NS_ASSUME_NONNULL_END
