//
//  UIImageView+XYHelper.m
//  XYHelper
//
//  Created by spikeroog on 2022/9/6.
//

#import "UIImageView+XYHelper.h"
#import <ReactiveObjC/ReactiveObjC.h>

@implementation UIImageView (XYHelper)

+ (void)addGestureForImageView:(UIImageView *)target
                      callBack:(void(^)(void))callBack {
    target.userInteractionEnabled = true;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [[tap rac_gestureSignal] subscribeNext:^(id x) {
        callBack();
    }];
    [target addGestureRecognizer:tap];
}

@end
