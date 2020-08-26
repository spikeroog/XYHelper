//
//  XYPopupView.h
//  XYHelper
//
//  Created by spikeroog on 2019/8/29.
//  Copyright © 2019年 spikeroog. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PopUpStyleType) {
    PopUpStyleTypeShadow = 0, // 背景是阴影
    PopUpStyleTypeBlur // 背景是高斯模糊图片
};

typedef NS_ENUM(NSInteger, PopUpViewAnimationType) {
    PopUpViewAnimationTypeCenter = 0, // 中间出现
    PopUpViewAnimationTypeBottom // 底部出现
};

typedef void(^PopViewDismiss) (void);

NS_ASSUME_NONNULL_BEGIN

@interface XYPopupView : UIView

@property (nonatomic, assign) PopUpStyleType styleType;

/** 点击半透明背景的回调*/
@property (nonatomic, copy) PopViewDismiss popViewDismiss;


+ (instancetype)shareInstance;

- (void)popupView:(__kindof UIView *)targetView
    animationType:(PopUpViewAnimationType)animationType
     clickDismiss:(BOOL)clickDismiss;

- (void)disMissView;


+ (BOOL)iPhoneNotchScreen;

@end

NS_ASSUME_NONNULL_END
