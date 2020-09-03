//
//  XYPopupView.m
//  XYHelper
//
//  Created by spikeroog on 2019/8/29.
//  Copyright © 2019年 spikeroog. All rights reserved.
//  eg：如果是变大变小的动画CGAffineTransformMakeScale要写在CGAffineTransformMakeTranslation的前面

#import "XYPopupView.h"
#import "XYHelperMarco.h"
#import "XYScreenAdapter.h"
#import "UIView+XYHelper.h"
#import "XYHelperRouter.h"
#import <UIKit/UIKit.h>

// 刘海屏底部栏的高度
#define XYPopupBottomHeight ([XYPopupView iPhoneNotchScreen]?34:0)

static const CGFloat kDefaultSpringDamping = 0.7f;
static const CGFloat kDefaultSpringVelocity = 0.8f;

static const CGFloat kDefaultAnimateDuration = 0.55f;
static const CGFloat kDefaultAnimateDismissDuration = 0.55f;

static const NSInteger kAnimationOptionCurve = (7 << 16);

#define ALPHA_NUM 0.35f

@interface XYPopupView ()

@property (nonatomic, strong) UIButton *bgBtn;
@property (nonatomic, strong) __kindof UIView *targetView;
@property (nonatomic, assign) CGAffineTransform fromTransform;
@property (nonatomic, assign) CGAffineTransform toTransfrom;
@property (nonatomic, assign) PopUpViewAnimationType popUpViewAnimationType;
@property (nonatomic, assign) BOOL clickDismiss;
@property (nonatomic, strong) UIView *bkVview;
@end

@implementation XYPopupView

- (void)dealloc {
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    }
    return self;
}

+ (instancetype)shareInstance {
    static XYPopupView *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

#pragma mark - 弹出弹窗

- (void)popupView:(__kindof UIView *)targetView
    animationType:(PopUpViewAnimationType)animationType
     clickDismiss:(BOOL)clickDismiss {
    
    self.targetView = targetView;
    self.popUpViewAnimationType = animationType;
    self.clickDismiss = clickDismiss;
    
    self.targetView.frame = CGRectMake(0, 0, targetView.xy_size.width, targetView.xy_size.height);
    self.targetView.xy_centerX = [XYHelperRouter fetchKeyWindow].xy_centerX;

    CGFloat centY = [XYHelperRouter fetchKeyWindow].xy_centerY-targetView.xy_size.height/2.0f;
    
    if (animationType == PopUpViewAnimationTypeCenter) {
        
        self.fromTransform = CGAffineTransformMakeTranslation(0, centY);
        self.toTransfrom = CGAffineTransformMakeTranslation(0, centY);

        self.targetView.transform = CGAffineTransformMakeTranslation(0, centY);

    } else if (animationType == PopUpViewAnimationTypeBottom) {
        
        self.fromTransform = CGAffineTransformMakeTranslation(0, kScreenHeight+self.targetView.xy_size.height);
        self.toTransfrom = CGAffineTransformMakeTranslation(0, kScreenHeight-self.targetView.xy_size.height-XYPopupBottomHeight); //XYPopupBottomHeight适配iphoneX

        self.targetView.transform = CGAffineTransformMakeTranslation(0, kScreenHeight+self.targetView.xy_size.height);
    }
    
    self.bgBtn.backgroundColor = kColorWithRGB16RadixA(0x000000, ALPHA_NUM);

    if (!self.superview) {
        NSEnumerator *reverseWindows = [[[UIApplication sharedApplication] windows] reverseObjectEnumerator];
        for (UIWindow *window in reverseWindows) {
            if (window.windowLevel == UIWindowLevelNormal) {
                [window addSubview:self];
                break;
            }
        }
    }

    [self addSubview:self.bgBtn];
    [self addSubview:self.targetView];
    if (self.popUpViewAnimationType == PopUpViewAnimationTypeCenter) {
        // 中间出现，从小变大，收起反之
        dispatch_async(dispatch_get_main_queue(), ^{

            self.targetView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);

            [UIView animateWithDuration:kDefaultAnimateDuration delay:0.0 usingSpringWithDamping:kDefaultSpringDamping initialSpringVelocity:kDefaultSpringVelocity options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.bgBtn.alpha = 1;
                // 在动画过程中禁止遮罩视图响应用户手势
                self.targetView.maskView.userInteractionEnabled = NO;
                // 如果是变大变小的动画CGAffineTransformMakeScale要写在CGAffineTransformMakeTranslation的前面
                self.targetView.transform = self.toTransfrom;

            } completion:^(BOOL finished) {
                // 在动画结束后允许遮罩视图响应用户手势
                self.targetView.maskView.userInteractionEnabled = YES;
            }];
        });
    } else if (self.popUpViewAnimationType == PopUpViewAnimationTypeBottom) {
        // 从底部出现，收起反之
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:kDefaultAnimateDuration delay:0.0f usingSpringWithDamping:kDefaultSpringDamping initialSpringVelocity:kDefaultSpringVelocity options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.bgBtn.alpha = 1;
                self.targetView.transform = self.toTransfrom;
                // 在动画过程中禁止遮罩视图响应用户手势
                self.targetView.maskView.userInteractionEnabled = NO;
            } completion:^(BOOL finished) {
                // 在动画结束后允许遮罩视图响应用户手势
                self.targetView.maskView.userInteractionEnabled = YES;
            }];
        });
    }
}

#pragma mark - 收起弹窗

- (void)disMissView {
    !self.popViewDismiss ? : self.popViewDismiss();
    [self packupView];
}


- (void)removeView {
    [self.targetView removeFromSuperview];
    self.targetView = nil;
    [self.bgBtn removeFromSuperview];
    self.bgBtn = nil;
    [self removeFromSuperview];
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *hitView = [super hitTest:point withEvent:event];
    return hitView;
}

- (void)packupView {
    if (self.popUpViewAnimationType == PopUpViewAnimationTypeCenter) {
        [UIView animateWithDuration:kDefaultAnimateDismissDuration delay:0.0 options:kAnimationOptionCurve animations:^{
            self.bgBtn.alpha = 0;
            self.targetView.alpha = 0;
            // 如果是变大变小的动画CGAffineTransformMakeScale要写在CGAffineTransformMakeTranslation的前面
            self.targetView.transform = CGAffineTransformMakeScale(0.8, 0.8);
            self.targetView.transform = self.fromTransform;
        } completion:^(BOOL finished) {
            [self removeView];
        }];
    } else if (self.popUpViewAnimationType == PopUpViewAnimationTypeBottom) {
        
        [UIView animateWithDuration:kDefaultAnimateDuration delay:0.0f usingSpringWithDamping:kDefaultSpringDamping initialSpringVelocity:kDefaultSpringVelocity options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.bgBtn.alpha = 0;
            self.targetView.transform = self.fromTransform;
        } completion:^(BOOL finished) {
            [self removeView];
        }];
        
    }
}

#pragma mark - NSObject
- (UIButton *)bgBtn {
    if (!_bgBtn) {
        _bgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _bgBtn.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        _bgBtn.showsTouchWhenHighlighted = NO;
        _bgBtn.adjustsImageWhenHighlighted = NO;
        // 使图片充满整个ImageView
        _bgBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
        // 保持原图长宽比
        _bgBtn.imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_bgBtn addTarget:self action:@selector(bgBtnAct) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bgBtn;
}

#pragma mark - UIButton Click Action

- (void)bgBtnAct {
    if (self.clickDismiss) {
        [self disMissView];
    }
}

- (__kindof UIView *)targetView {
    if (!_targetView) {
        _targetView = [[UIView alloc] init];
        _targetView.userInteractionEnabled = YES;
    }
    return _targetView;
}

#pragma mark - 判断是否是刘海屏
/**
 判断是否是刘海屏
 iOS 10 以下 的系统肯定不是刘海屏
 @return 是否
 */
+ (BOOL)iPhoneNotchScreen {
    
    if (kSystemVersion < 11.0f)  return false;
    
    CGFloat iPhoneNotchDirectionSafeAreaInsets = 0;
    
    if (@available(iOS 11.0, *)) {
        UIEdgeInsets safeAreaInsets = [UIApplication sharedApplication].windows[0].safeAreaInsets;
        
        switch ([UIApplication sharedApplication].statusBarOrientation) {
            case UIInterfaceOrientationPortrait:{
                iPhoneNotchDirectionSafeAreaInsets = safeAreaInsets.top;
            }
                break;
            case UIInterfaceOrientationLandscapeLeft:{
                iPhoneNotchDirectionSafeAreaInsets = safeAreaInsets.left;
            }
                break;
            case UIInterfaceOrientationLandscapeRight:{
                iPhoneNotchDirectionSafeAreaInsets = safeAreaInsets.right;
            }
                break;
            case UIInterfaceOrientationPortraitUpsideDown:{
                iPhoneNotchDirectionSafeAreaInsets = safeAreaInsets.bottom;
            }
                break;
            default:
                iPhoneNotchDirectionSafeAreaInsets = safeAreaInsets.top;
                break;
        }
    } else {
        // Fallback on earlier versions
    }
    return iPhoneNotchDirectionSafeAreaInsets > 20;
}

@end
