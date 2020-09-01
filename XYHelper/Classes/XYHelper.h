//
//  XYHelper.h
//  XYHelper
//
//  Created by spikeroog on 2020/8/13.
//  Copyright © 2020 spikeroog. All rights reserved.
//

#ifndef XYHelper_h
#define XYHelper_h

#pragma mark ---- Pods引用的三方库

#import <HBDNavigationBar/HBDNavigationBar.h>
#import <HBDNavigationBar/HBDNavigationController.h>
#import <HBDNavigationBar/UIViewController+HBD.h>
#import <AFNetworking/AFNetworking.h>
#import <YYCache/YYCache.h>
#import <YYCategories/YYCategories.h>
#import <SDWebImage/SDWebImage.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIImage+GIF.h>
#import <Masonry/Masonry.h> // 视图约束配置
#define MAS_SHORTHAND // equalTo不需要使用"mas_"前缀
#define MAS_SHORTHAND_GLOBALS // @1直接写1即可 自动将数据类型转为NSNumber类型
#import <ReactiveObjC/ReactiveObjC.h> // rac

#pragma mark ---- 非Pods引用三方库

#import "PPNetworkHelper.h"
#import "ZXPUnicode.h"


#pragma mark ---- 自定义路由

#import "XYHelperRouter.h"
#import "XYHelperMarco.h"
#import "XYUserBasicModel.h"
#import "XYHelperUtils.h"
#import "XYNetworkUtils.h"

#pragma mark ---- 自定义管理类

#import "XYAppleLoginManager.h"
#import "XYNetworkStatusManager.h"
#import "XYImagePickerManager.h"
#import "XYAdapterManager.h"
#import "XYAppDelegateManager.h"
#import "XYUserInfoManager.h"
#import "XYMediaPreviewManager.h"

#pragma mark ---- 自定义基类

#import "XYBasicViewController.h"
#import "XYNavigationController.h"
#import "XYBasicWebViewController.h"
#import "XYObserverView.h"
#import "XYPopupView.h"
#import "XYCommentView.h"
#import "XYTextfield.h"
#import "XYSlider.h"


#pragma mark ---- 分类

#import "UIImage+ImageEffects.h"
#import "UIControl+FixMultiClick.h"
#import "NSObject+ModelToDict.h"
#import "UIButton+EnlargeEdge.h"
#import "NSObject+Extension.h"
#import "NSObject+KVO.h"
#import "NSObject+Runtime.h"


#import "UIView+XYHelper.h"
#import "CALayer+XYHelper.h"
#import "UIImage+XYHelper.h"
#import "UIColor+XYHelper.h"
#import "UILabel+XYHelper.h"
#import "NSString+XYHelper.h"
#import "UITextView+XYHelper.h"
#import "CAAnimation+XYHelper.h"
#import "MBProgressHUD+XYHelper.h"
#import "NSLayoutConstraint+XYHelper.h"
#import "NSMutableAttributedString+XYHelper.h"


#endif /* XYHelper_h */
