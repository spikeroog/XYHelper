//
//  UIImageView+XYHelper.h
//  XYHelper
//
//  Created by spikeroog on 2022/9/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (XYHelper)
+ (void)addGestureForImageView:(UIImageView *)target callBack:(void(^)(void))callBack;

@end

NS_ASSUME_NONNULL_END
