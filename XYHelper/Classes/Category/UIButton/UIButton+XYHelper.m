//
//  UIButton+XYHelper.m
//  XYHelper
//
//  Created by spikeroog on 2022/9/6.
//

#import "UIButton+XYHelper.h"
#import <ReactiveObjC/ReactiveObjC.h>

@implementation UIButton (XYHelper)

- (void)addGestureForButton:(void(^)(void))callBack {
    self.userInteractionEnabled = true;
    [[self rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        callBack();
    }];
}

@end
