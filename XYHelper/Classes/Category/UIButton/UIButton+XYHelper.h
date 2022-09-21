//
//  UIButton+XYHelper.h
//  XYHelper
//
//  Created by spikeroog on 2022/9/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (XYHelper)

- (void)addGestureForButton:(void(^)(void))callBack;

@end

NS_ASSUME_NONNULL_END
