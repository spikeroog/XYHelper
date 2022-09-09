//
//  XYBasicViewController.m
//  XYHelper
//
//  Created by spikeroog on 2019/12/11.
//  Copyright © 2020 spikeroog. All rights reserved.
//

#import "XYBasicViewController.h"
#import "XYBarItemCustomView.h"
#import "XYHelperRouter.h"
#import "XYHelperMarco.h"
#import "XYScreenAdapter.h"

#import "UIImage+XYHelper.h"
#import "UIColor+XYHelper.h"

#import <HBDNavigationBar/HBDNavigationBar.h>
#import <HBDNavigationBar/HBDNavigationController.h>
#import <HBDNavigationBar/UIViewController+HBD.h>
#import <SDWebImage/SDWebImage.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIImage+GIF.h>

#define RotundityWH 35 /// 导航栏左侧右侧，圆形或正方形显示barItem的默认宽高

@interface XYBasicViewController ()
/**左侧按钮Item*/
@property (nonatomic, strong) UIBarButtonItem *leftBarItem;
/**右侧按钮Item*/
@property (nonatomic, strong) UIBarButtonItem *rightBarItem;

@end

@implementation XYBasicViewController

@synthesize
navBgColor = _navBgColor,
navTitleColor = _navTitleColor,
navTitle = _navTitle,
navBgImageStr = _navBgImageStr;

#pragma mark - Controller lifecycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    /// 刷新状态栏
    [self setNeedsStatusBarAppearanceUpdate];
    if (self.xy_NavHiddenForReal) {
        [self.navigationController setNavigationBarHidden:YES animated:animated];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (self.xy_NavHiddenForReal) {
        if ([self xy_pushOrPopIsHidden] == NO) {
            [self.navigationController setNavigationBarHidden:NO animated:animated];
        }
    }
}

/// 监听push下一个或 pop 上一个，是否隐藏导航栏
- (BOOL)xy_pushOrPopIsHidden {
    NSArray * viewcontrollers = self.navigationController.viewControllers;
    if (viewcontrollers.count > 0) {
        XYBasicViewController * vc = viewcontrollers[viewcontrollers.count - 1];
        return vc.xy_NavHiddenForReal;
    }
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /// 防止视图下移
    if (@available(iOS 11.0, *)) {
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    } else {
        self.automaticallyAdjustsScrollViewInsets = false;
    }
    
    [self hiddenNavigationBar:self.navBarHidden];
    
    /// 左侧默认显示图片
    NSInteger count = [XYHelperRouter currentNavC].childViewControllers.count;
    if (count > 1) {
        /// 设置默认左侧按钮图片
///        self.leftBarItemImage = kImageWithName(@"");
        self.leftBarItemTitle = @"返回";
        self.hbd_swipeBackEnabled = true;
    } else {
        self.hbd_swipeBackEnabled = false;
    }
    
    self.navBgColor = UIColor.whiteColor;
    self.navTitleColor = UIColor.blackColor;
    
    /// 设置VC的默认背景色
    self.view.backgroundColor = kWhiteStyleViewControllerBgColor;
    /// 隐藏导航栏下的黑线
    self.hbd_barShadowHidden = true;
    /// 取消导航栏半透明
    self.navigationController.navigationBar.translucent = false;
    /// 修改导航栏背景颜色
    self.hbd_barTintColor = self.navBgColor;
    /// 修改导航栏标题样式
    self.hbd_barStyle = UIBarStyleDefault;
    /// 修改导航栏按钮颜色
    self.hbd_tintColor = UIColor.blackColor;
    /// 设置导航栏字体颜色
    self.hbd_titleTextAttributes = @{NSForegroundColorAttributeName: [self.navTitleColor colorWithAlphaComponent:1],NSFontAttributeName:kFontWithAutoSize(17)};
}

- (void)setNavBarHidden:(BOOL)navBarHidden {
    _navBarHidden = navBarHidden;
    [self hiddenNavigationBar:navBarHidden];
}

#pragma mark - 状态栏相关

/// 状态栏的样式
- (UIStatusBarStyle)preferredStatusBarStyle {
     return self.barStyle;
}

/// 状态栏隐藏
- (BOOL)prefersStatusBarHidden {
     return self.statusBarHiden;
 }

#pragma mark - 导航栏左右侧按钮点击事件，子类重写的话就不会再调用了
/**
 左侧按钮点击事件
 */
- (void)leftActionInController {
    [XYHelperRouter popController];
}

/**
 右侧按钮点击事件
 */
- (void)rightActionInController {
    
}

#pragma mark - 导航栏颜色
/**修改导航栏背景颜色  如果是标签栏界面，想要改变导航栏颜色，需要设置每一个子控制器的导航栏颜色*/
- (void)setNavBgColor:(UIColor *)navBgColor {
    UIColor *col = !navBgColor ? UIColor.whiteColor:navBgColor;
    _navBgColor = col;
    self.hbd_barTintColor = navBgColor;
}

- (UIColor *)navBgColor {
    UIColor *col = !_navBgColor ? UIColor.whiteColor:_navBgColor;
    return col;
}

/**设置导航栏背景图片*/
- (void)setNavBgImageStr:(NSString *)navBgImageStr {
    /// 设置导航栏背景图片，不需要考虑图片尺寸
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kNavBarHeight)];
    imageV.contentMode = UIViewContentModeScaleAspectFill;
    imageV.image = kImageWithName(navBgImageStr);
    UIImage *img = [UIImage xy_convertViewToImage:imageV];
    self.navBgColor = kColorWithImage(img);
}

- (NSString *)navBgImageStr {
    return _navBgImageStr;
}

/**修改导航栏标题颜色*/
- (void)setNavTitleColor:(UIColor *)navTitleColor {
    UIColor *col = !navTitleColor ? UIColor.whiteColor:navTitleColor;
    _navTitleColor = col;
    self.hbd_titleTextAttributes = @{NSForegroundColorAttributeName: [_navTitleColor colorWithAlphaComponent:1],NSFontAttributeName:kFontWithAutoSize(17)};;
}

- (UIColor *)navTitleColor {
    UIColor *col = !_navTitleColor ? UIColor.whiteColor:_navTitleColor;
    return col;
}

#pragma mark - 导航栏标题
/**
 设置标题
 
 @param title 文字
 */
- (void)setTitle:(NSString *)title {
    _navTitle = title;
    self.navigationItem.title = _navTitle;
}

- (void)setNavTitle:(NSString *)navTitle {
    _navTitle = navTitle;
    self.navigationItem.title = _navTitle;
}

- (NSString *)navTitle {
    return _navTitle;
}

#pragma mark - 导航栏标题处图片
/**
 设置标题处图片
 
 @param titleViewImage 图片名
 */
- (void)setTitleViewImage:(UIImage *)titleViewImage {
    UIImageView *imgV = [[UIImageView alloc] initWithImage:titleViewImage];
    imgV.contentMode = UIViewContentModeScaleAspectFit;
    self.navigationItem.titleView = imgV;
}

#pragma mark - 导航栏左侧按钮
/**
 导航栏左侧按钮
 
 @return 导航栏左侧按钮
 */
- (UIBarButtonItem *)leftBarItem {
    if (!_leftBarItem) {
        _leftBarItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:self action:@selector(leftActionInController)];
        [_leftBarItem setTintColor:self.hbd_tintColor];
        [_leftBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kFontWithAutoSize(14),NSFontAttributeName,nil] forState:UIControlStateNormal];
        [_leftBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kFontWithAutoSize(14),NSFontAttributeName,nil] forState:UIControlStateHighlighted];
        self.navigationItem.leftBarButtonItem = _leftBarItem;
    }
    return _leftBarItem;
}

/**
 左侧按钮设置文字
 
 @param leftBarItemTitle 文字
 */
- (void)setLeftBarItemTitle:(NSString *)leftBarItemTitle {
    if (self.navBarHidden) {
        return ;
    }
    
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithTitle:leftBarItemTitle style:UIBarButtonItemStyleDone target:self action:@selector(leftActionInController)];
    [leftBarItem setTintColor:self.hbd_tintColor];
    [leftBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kFontWithAutoSize(14),NSFontAttributeName,nil] forState:UIControlStateNormal];
    [leftBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kFontWithAutoSize(14),NSFontAttributeName,nil] forState:UIControlStateHighlighted];
    self.navigationItem.leftBarButtonItem = leftBarItem;
}

/**
 左侧按钮设置自定义大小的图片
 
 @param leftBarItemDistanceImage 图片
 */
- (void)setLeftBarItemDistanceImage:(UIImage *)leftBarItemDistanceImage {
    if (self.navBarHidden) {
        return ;
    }
    
    /** 如果导航栏左侧按钮不需要设置圆角，也可使用以下方法实现左侧按钮右侧多出8的间距**/
    
    ///    XYBarItemCustomView *leftBtn = [XYBarItemCustomView buttonWithType:UIButtonTypeCustom];
    ///    leftBtn.frame = CGRectMake(0, 0, RotundityWH, RotundityWH);
    ///
    ///    [leftBtn addTarget:self action:@selector(leftActionInController) forControlEvents:UIControlEventTouchUpInside];
    ///    [leftBtn setBackgroundImage:leftBarItemDistanceImage forState:UIControlStateNormal];
    ///
    ///    CGRect frame = leftBtn.frame;
    ///    frame.size.width += kAutoCs(10);
    ///
    ///    UIView *leftCV = [[UIView alloc] initWithFrame:frame];
    ///    [leftCV addSubview:leftBtn];
    ///
    ///    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftCV];
    ///    leftItem.tintColor = self.hbd_tintColor;
    ///    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    NSMutableArray <UIBarButtonItem *>*arrayMut = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 2; i++) {
        /// 左侧设置或返回
        XYBarItemCustomView *leftBtn = [XYBarItemCustomView buttonWithType:UIButtonTypeCustom];
        
        if (i == 0) {
            leftBtn.frame = CGRectMake(0, 0, RotundityWH, RotundityWH);
            [leftBtn addTarget:self action:@selector(leftActionInController) forControlEvents:UIControlEventTouchUpInside];
            
            [leftBtn setBackgroundImage:leftBarItemDistanceImage forState:UIControlStateNormal];
        }
        
        UIView *leftCV = [[UIView alloc] initWithFrame:leftBtn.frame];
        [leftCV addSubview:leftBtn];
        
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftCV];
        leftItem.tintColor = self.hbd_tintColor;
        [arrayMut addObject:leftItem];
        
    }
    
    self.navigationItem.leftBarButtonItems = arrayMut;
}

/**
 左侧按钮设置自适应大小图片
 
 @param leftBarItemImage 图片
 */
- (void)setLeftBarItemImage:(UIImage *)leftBarItemImage {
    if (self.navBarHidden) {
        return ;
    }
    
    UIImage *leftBarButtonImage = [leftBarItemImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithImage:leftBarButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(leftActionInController)];
    barItem.tintColor = self.hbd_tintColor;
    self.navigationItem.leftBarButtonItem = barItem;
}

#pragma mark - 导航栏右侧按钮
/**
 导航栏右侧按钮
 
 @return 导航栏右侧按钮
 */
- (UIBarButtonItem *)rightBarItem {
    if (!_rightBarItem) {
        _rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:self action:@selector(rightActionInController)];
        [_rightBarItem setTintColor:self.hbd_tintColor];
        [_rightBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kFontWithAutoSize(14),NSFontAttributeName,self.hbd_tintColor,NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
        [_rightBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kFontWithAutoSize(14),NSFontAttributeName,self.hbd_tintColor,NSForegroundColorAttributeName,nil] forState:UIControlStateHighlighted];
        self.navigationItem.rightBarButtonItem = _rightBarItem;
    }
    return _rightBarItem;
}

/**
 右侧按钮设置文字
 
 @param rightBarItemTitle 文字
 */
- (void)setRightBarItemTitle:(NSString *)rightBarItemTitle {
    if (self.navBarHidden) {
        return ;
    }
    
    UIBarButtonItem *rightBarBtnItem = [[UIBarButtonItem alloc] initWithTitle:rightBarItemTitle style:UIBarButtonItemStyleDone target:self action:@selector(rightActionInController)];
    [rightBarBtnItem setTintColor:self.hbd_tintColor];
    [rightBarBtnItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kFontWithAutoSize(14),NSFontAttributeName,self.hbd_tintColor,NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    [rightBarBtnItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kFontWithAutoSize(14),NSFontAttributeName,self.hbd_tintColor,NSForegroundColorAttributeName,nil] forState:UIControlStateHighlighted];
    self.navigationItem.rightBarButtonItem = rightBarBtnItem;
}

/**
 右侧按钮设置图片
 
 @param rightBarItemImage 图片url
 */
- (void)setRightBarItemImage:(UIImage *)rightBarItemImage {
    if (self.navBarHidden) {
        return ;
    }
    
    UIImage *rightBarButtonImage = [rightBarItemImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithImage:rightBarButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(rightActionInController)];
    barItem.tintColor = self.hbd_tintColor;
    self.navigationItem.rightBarButtonItem = barItem;
}

/**
 创建多个导航栏右侧按钮
 titleArr传nil就是图片样式
 imageArr传nil就是文字样式
 titleArr，imageArr都穿就是customView样式，如果不传文字可以传@[@"",@"]，图片传@[@"xx"m@"xx"]
 如果需要动态改变数组里面某个按钮的标题或者背景图片，重写一行rigBarItemsWithTitleArr代码即可，回调会走最新的那行代码下
 
 @param titleArr 标题
 @param imageArr 图片
 */
- (void)rigBarItemsWithTitleArr:(nullable NSArray *)titleArr
                       imageArr:(nullable NSArray *)imageArr {
    
    if (self.navBarHidden) {
        return ;
    }
    
    NSInteger count;
    titleArr.count >= imageArr.count ? (count = titleArr.count) : (count = imageArr.count);
    
    NSMutableArray<UIBarButtonItem *> *muarr = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++) {
        
        UIBarButtonItem *rigItem = [[UIBarButtonItem alloc] init];
        rigItem.tintColor = self.hbd_tintColor;
        
        if ([titleArr objectAtIndex:i] != nil && [imageArr objectAtIndex:i] != nil) { /// 有文字和图片，使用自定义样式
            
            XYBarItemCustomView *rigBtn = [XYBarItemCustomView buttonWithType:UIButtonTypeCustom];
            [rigBtn addTarget:self action:@selector(rigBtnsAct:) forControlEvents:UIControlEventTouchUpInside];
            
            if (@available(iOS 11.0, *)) { /// 适配ios11及以上
                rigBtn.isRight = YES;
                rigBtn.offset = kAutoCs(8);
                rigBtn.translatesAutoresizingMaskIntoConstraints = NO;
                
                UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
                spacer.width = rigBtn.offset;
                [muarr addObject:spacer];
                
            } else { /// 适配ios10及以下
                UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
                spacer.width = -kAutoCs(8);
                [muarr addObject:spacer];
            }
            
            if ([imageArr objectAtIndex:i] != nil) {
                if ([titleArr objectAtIndex:i] != nil) {
                    [rigBtn setTitle:[NSString stringWithFormat:@" %@",titleArr[i]] forState:UIControlStateNormal];
                }
            } else {
                if ([titleArr objectAtIndex:i] != nil) {
                    [rigBtn setTitle:[NSString stringWithFormat:@"%@",titleArr[i]] forState:UIControlStateNormal];
                }
            }
            
            if ([imageArr objectAtIndex:i] != nil) {
                UIImage *rightBarButtonImage = [[UIImage imageNamed:imageArr[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                [rigBtn setImage:rightBarButtonImage forState:UIControlStateNormal];
            }
            
            rigBtn.tag = i+100;
            [rigBtn sizeToFit];
            
            rigItem = [[UIBarButtonItem alloc] initWithCustomView:rigBtn];
            
        } else if ([titleArr objectAtIndex:i] != nil && [imageArr objectAtIndex:i] == nil) { /// 只有文字，使用系统title样式
            
            rigItem = [[UIBarButtonItem alloc] initWithTitle:titleArr[i] style:UIBarButtonItemStyleDone target:self action:@selector(rigBtnsAct:)];
            [rigItem setTintColor:self.hbd_tintColor];
            [rigItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kFontWithAutoSize(14),NSFontAttributeName,nil] forState:UIControlStateNormal];
            [rigItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kFontWithAutoSize(14),NSFontAttributeName,nil] forState:UIControlStateHighlighted];
            rigItem.tag = i+100;
            
        } else if ([imageArr objectAtIndex:i] != nil && [titleArr objectAtIndex:i] == nil) { /// 只有图片，使用系统image样式
            
            UIImage *rightBarButtonImage = [kImageWithName(imageArr[i]) imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            rigItem = [[UIBarButtonItem alloc] initWithImage:rightBarButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(rigBtnsAct:)];
            rigItem.tag = i+100;
        }
        [muarr addObject:rigItem];
    }
    self.navigationItem.rightBarButtonItems = muarr;
}

/**
 点击右侧按钮数组回调
 
 @param complete 回调
 */
- (void)clickRigBarItemsHandle:(void(^)(NSInteger))complete {
    self.rightItemsHandle = complete;
}

- (void)rigBtnsAct:(UIButton *)sender {
    NSInteger idx = sender.tag - 100;
    !self.rightItemsHandle ? : self.rightItemsHandle(idx);
}

- (void)leftBarItemShow {
    ///    self.navigationItem.leftBarButtonItem.enabled = YES;
    ///    self.navigationItem.leftBarButtonItem.customView.hidden = NO;
}

- (void)leftBarItemHidden {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];
    self.navigationItem.leftBarButtonItem.enabled = NO;
    self.navigationItem.leftBarButtonItem.customView.hidden = YES;
}

- (void)rightBarItemShow {
    ///    self.navigationItem.rightBarButtonItem.enabled = YES;
    ///    self.navigationItem.rightBarButtonItem.customView.hidden = NO;
}

- (void)rightBarItemHidden {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    self.navigationItem.rightBarButtonItem.customView.hidden = YES;
}

/// [self rightBarItemsShowWithArray:@[@1,@2]];
- (void)rightBarItemsShowWithArray:(NSArray<NSNumber *> *)itemsArray {
    [itemsArray enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger index = [obj integerValue];
        self.navigationItem.rightBarButtonItems[index].enabled = YES;
        self.navigationItem.rightBarButtonItems[index].customView.hidden = NO;
    }];
}

/// [self rightBarItemHiddenWithArray:@[@1,@2]];
- (void)rightBarItemHiddenWithArray:(NSArray<NSNumber *> *)itemsArray {
    [itemsArray enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger index = [obj integerValue];
        ///        self.navigationItem.rightBarButtonItems[index] = nil;
        self.navigationItem.rightBarButtonItems[index].enabled = NO;
        self.navigationItem.rightBarButtonItems[index].customView.hidden = YES;
        
    }];
}

#pragma mark - 隐藏/显示导航栏
/// 隐藏导航栏
/// @param hidden 是否隐藏
- (void)hiddenNavigationBar:(BOOL)hidden {
    /// 是否隐藏导航栏
    self.hbd_barHidden = hidden;
    if (self.navBarHidden) {
        [self leftBarItemHidden];
        [self rightBarItemHidden];
    } else {
        [self leftBarItemShow];
        [self rightBarItemShow];
    }
    /// 防止视图上移
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.hbd_extendedLayoutDidSet = !hidden;
}


#pragma mark - MemoryWarning

- (void)didReceiveMemoryWarning {
    /// 关闭所有服务
    [[SDWebImageManager sharedManager] cancelAll];
    /// 清除内存缓存
    [[[SDWebImageManager sharedManager] imageCache] clearWithCacheType:SDImageCacheTypeMemory completion:^{
        
    }];
}

#pragma mark - 设置BarItem圆角

- (void)setCornersLeftBarItem {
    self.navigationItem.leftBarButtonItem.customView.layer.cornerRadius = RotundityWH/2;
    self.navigationItem.leftBarButtonItem.customView.layer.masksToBounds = YES;
    ///    self.navigationItem.leftBarButtonItem.customView.layer.borderWidth = 1;
    ///    self.navigationItem.leftBarButtonItem.customView.layer.borderColor = kMainColor.CGColor;
}

- (void)setCornersRightBarItem {
    self.navigationItem.rightBarButtonItem.customView.layer.cornerRadius = RotundityWH/2;
    self.navigationItem.rightBarButtonItem.customView.layer.masksToBounds = YES;
    ///    self.navigationItem.leftBarButtonItem.customView.layer.borderWidth = 1;
    ///    self.navigationItem.leftBarButtonItem.customView.layer.borderColor = kMainColor.CGColor;
}

#pragma mark - 单个界面设置是否禁用右滑手势
- (void)interactivePopDisabled:(BOOL)disabled {
    self.hbd_swipeBackEnabled = !disabled; /// 普通右滑
}

@end
