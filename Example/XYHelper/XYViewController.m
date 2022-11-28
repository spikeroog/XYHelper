//
//  XYViewController.m
//  XYHelper
//
//  Created by spikeroog on 2020/12/15.
//  Copyright © 2020 spikeroog. All rights reserved.
// 

#import "XYViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "FYFImagePickerController.h"

#import "XYHomePagingViewController.h"
#import "XYAnchorPagingViewController.h"
#import "XYNestSubPagingViewController.h"
#import "XYNestPagingViewController.h"
#import "XYBasicPagingViewController.h"

#import "KCExploreInformationViewController.h"
#import "XYTestViewController.h"

@interface XYViewController ()
@property (nonatomic, strong) FYFImagePickerController *imagePicker;

@end

@implementation XYViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.navTitle = @"首页";

    self.barStyle = 1;
    
    /// 导航栏背景颜色
    self.navBgImageStr = @"launcher_image_2020_0709";
//    self.navBgColor = UIColor.systemYellowColor;
    /// 导航栏标题颜色
//    self.navTitleColor = UIColor.redColor;
    
    self.leftBarItemTitle = @"嵌套使用";
    self.rightBarItemTitle = @"底部锚点";
    self.barItemTextFont = kFontWithRealsize(20);
    self.navItemTitleFont = kFontWithRealsize(20);

//    self.view.backgroundColor = kColorWithRandom;

}

- (void)gotoImagePickVc {
    
    [[XYImagePickerManager shareInstance] imagePickerallowPickingMuitlple:true allowTakePhoto:true allowTakeVideo:true sortAscending:true allowPickingPhoto:true allowPickingVideo:true allowPickingOriginalPhoto:true showSheet:true showCornermark:true allowCrop:true needCircleCrop:true maxCount:10 maxImageSize:10 maxVideoSize:20 pictureCallBack:^(NSArray<UIImage *> * _Nonnull backupsImgArray, NSArray<PHAsset *> * _Nonnull assetArray) {
        
    } videoCallBack:^(NSString * _Nonnull outputPath, UIImage * _Nonnull coverImage) {
        
    } targetVC:self];
}


- (void)leftActionInController {
    
    [self showPagingVIewModel_2];
    
//    XYTestViewController *testVc = [[XYTestViewController alloc] init];
//    testVc.isNeedsClear = true;
//
//    [XYHelperRouter pushViewController:testVc];
    
    
    return;
    
    __weak typeof(self) weakSelf = self;
    NSArray *otherButtonTitles  = @[@"录像",@"拍照",@"从相册中选择图片",@"从相册中选择视频"];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){ }];
    [alertController addAction:cancelAction];

    for (NSUInteger i = 0; i < otherButtonTitles.count; i++) {
        NSString *otherButtonTitle = otherButtonTitles[i];
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            if (i == 0) {
                [weakSelf.imagePicker cameraVedioPicker];
            } else if (i == 1) {
                [weakSelf.imagePicker cameraPhotoPicker];
            } else if (i == 2) {
                [weakSelf.imagePicker imagePicker];
            } else if (i == 3) {
                [weakSelf.imagePicker videoPicker];
            }
        }];
        [alertController addAction:otherAction];
    }
    [self presentViewController:alertController animated:YES completion:^{
        
    }];
}

- (void)rightActionInController {
    
    [self showPagingVIewModel_4];
    return;
    
//    [self gotoImagePickVc];

}


#pragma mark - 标签栏样式

- (void)showPagingVIewModel_1 {
    XYNestPagingViewController *vc = [[XYNestPagingViewController alloc] init];
    
    vc.barStyle = 0;
    vc.title = @"嵌套使用";
    vc.titles = @[@"主题一", @"主题二"];
    
    CGFloat yOffset = 0;
    vc.categoryViewYOffset = yOffset;
    /// 可自定义categoryView的frame
//    vc.categoryViewFrame = CGRectMake((kScreenWidth-180)/2, yOffset, 180, 30);
    vc.categoryViewFrame = CGRectMake(0, yOffset, 180, 30);

    /// 是否显示在titleView上
    vc.useTitleView = true;
    
//    vc.navBarHidden = true;
    
    JXCategoryTitleView *titleCategoryView = (JXCategoryTitleView *)vc.categoryView;
    titleCategoryView.layer.cornerRadius = 15;
    titleCategoryView.layer.masksToBounds = YES;
    titleCategoryView.layer.borderColor = [UIColor blackColor].CGColor;
    titleCategoryView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    titleCategoryView.cellSpacing = 0;
    titleCategoryView.titleColor = [UIColor blackColor];
    titleCategoryView.titleSelectedColor = [UIColor cyanColor];
    titleCategoryView.titleLabelMaskEnabled = YES;
    
    JXCategoryIndicatorLineView *backgroundView = [[JXCategoryIndicatorLineView alloc] init];
    backgroundView.lineStyle = JXCategoryIndicatorLineStyle_LengthenOffset;
    backgroundView.indicatorHeight = 30;
    backgroundView.indicatorWidthIncrement = 60;
    backgroundView.indicatorColor = kColorWithOpacity(UIColor.redColor, 0.3);
    titleCategoryView.indicators = @[backgroundView];
    
//    vc.navBarHidden = random()%2 > 0 ? true : false;

    XYNestSubPagingViewController *listVC_1 = [XYNestSubPagingViewController new];
    XYNestSubPagingViewController *listVC_2 = [XYNestSubPagingViewController new];
    
    listVC_1.lineView.indicatorColor = UIColor.blackColor;
    listVC_1.myCategoryView.titleColor = kColor666666;
    listVC_1.myCategoryView.titleSelectedColor = UIColor.blackColor;
    listVC_1.myCategoryView.titleColorGradientEnabled = YES;
    listVC_1.myCategoryView.titleLabelZoomEnabled = YES;
    listVC_1.myCategoryView.titleLabelZoomScale = 1.3;
    listVC_1.myCategoryView.titleLabelStrokeWidthEnabled = YES;
    listVC_1.myCategoryView.selectedAnimationEnabled = YES;
    listVC_1.myCategoryView.cellWidthZoomEnabled = YES;
    listVC_1.myCategoryView.cellWidthZoomScale = 1.3;
    
    
    listVC_2.lineView.indicatorColor = UIColor.redColor;
    listVC_2.myCategoryView.titleColor = kColor333333;
    listVC_2.myCategoryView.titleSelectedColor = UIColor.redColor;
    listVC_2.myCategoryView.titleFont = kFontWithRealsizeBold(14);
    listVC_2.myCategoryView.titleColorGradientEnabled = YES;
    listVC_2.myCategoryView.titleLabelZoomEnabled = YES;
    listVC_2.myCategoryView.titleLabelZoomScale = 1.5;
    listVC_2.myCategoryView.cellWidthZoomEnabled = YES;
    listVC_2.myCategoryView.cellWidthZoomScale = 1.5;
    listVC_2.myCategoryView.titleLabelAnchorPointStyle = JXCategoryTitleLabelAnchorPointStyleBottom;
    listVC_2.myCategoryView.selectedAnimationEnabled = YES;
    listVC_2.myCategoryView.titleLabelZoomSelectedVerticalOffset = 3;


    listVC_1.titles = @[@"乐库", @"推荐", @"鱼", @"海星"];
    listVC_1.controllers = @[[self getVc],[self getVc],[self getVc],[self getVc]];
    listVC_2.titles = @[@"视频", @"看点",@"葡萄", @"美味西瓜", @"香蕉"];
    listVC_2.controllers = @[[self getVc],[self getVc],[self getVc],[self getVc],[self getVc]];

    vc.sublist = @[listVC_1,listVC_2];
    [XYHelperRouter pushViewController:vc completion:^{
        
    }];
}

/// 锚点样式
- (void)showPagingVIewModel_2 {
    
    XYAnchorPagingViewController *subViewC = [XYAnchorPagingViewController new];
    subViewC.barStyle = 0;
    subViewC.title = @"底部锚点";
    subViewC.categoryViewHeight = 44;
    subViewC.lineView.indicatorColor = kColorWithNull;
    
//    subViewC.categoryViewYOffset = 100;
//    subViewC.navBarHidden = random()%2 > 0 ? true : false;
    
    subViewC.titles = @[@"乐库", @"推荐", @"视频", @"看点"/*, @"葡萄", @"美味西瓜", @"香蕉", @"香甜菠萝", @"鸡肉", @"鱼", @"海星"*/];
    subViewC.controllers = @[[self getVc],[self getVc],[self getVc],[self getVc]];
    
    JXCategoryTitleView *titleCategoryView = (JXCategoryTitleView *)subViewC.categoryView;
    titleCategoryView.titleColorGradientEnabled = YES;
    titleCategoryView.titleLabelZoomEnabled = YES;
    titleCategoryView.titleLabelZoomScale = 1.85;
    titleCategoryView.cellWidthZoomEnabled = YES;
    titleCategoryView.cellWidthZoomScale = 1.85;
    titleCategoryView.titleLabelAnchorPointStyle = JXCategoryTitleLabelAnchorPointStyleBottom;
    titleCategoryView.selectedAnimationEnabled = YES;
    titleCategoryView.titleLabelZoomSelectedVerticalOffset = 3;
    titleCategoryView.titleColor = kColor333333;
    titleCategoryView.titleSelectedColor = UIColor.blackColor;
    titleCategoryView.titleFont = kFontWithRealsizeBold(16);
       
    [XYHelperRouter pushViewController:subViewC];
    
}

/// 等分屏幕宽度样式
- (void)showPagingVIewModel_3 {
   
    XYNestSubPagingViewController *vc = [XYNestSubPagingViewController new];
    
    vc.navTitle = @"标签控制器";
    
    JXCategoryTitleView *titleCategoryView = (JXCategoryTitleView *)vc.myCategoryView;

    titleCategoryView.titleColor = kColor666666;
    titleCategoryView.titleSelectedColor = UIColor.blackColor;
    titleCategoryView.titleColorGradientEnabled = YES;
    titleCategoryView.titleLabelZoomEnabled = YES;
    titleCategoryView.titleLabelZoomScale = 1.1;
    titleCategoryView.titleLabelStrokeWidthEnabled = YES;
    titleCategoryView.selectedAnimationEnabled = YES;
    
    titleCategoryView.cellSpacing = 0;
    titleCategoryView.contentEdgeInsetLeft = 0;
    titleCategoryView.contentEdgeInsetRight = 0;
    titleCategoryView.averageCellSpacingEnabled = NO;
    titleCategoryView.cellWidth = kScreenWidth/4;
    titleCategoryView.titleFont = kFontWithRealsize(14);
            
    vc.lineView.indicatorColor = UIColor.blackColor;
    vc.lineView.indicatorHeight = 2;
    vc.lineView.lineStyle = JXCategoryIndicatorLineStyle_Normal;

//    listVC_1.lineView.lineStyle = JXCategoryIndicatorLineStyle_LengthenOffset;
//    listVC_1.lineView.indicatorWidth = 16;

    vc.titles = @[@"全部", @"租赁中", @"待归还", @"已退租"];
    vc.controllers = @[[self getHomepageVc],[self getHomepageVc],[self getHomepageVc],[self getHomepageVc]];

    [XYHelperRouter pushViewController:vc];
}

- (void)showPagingVIewModel_4 {
    
    XYHomePagingViewController *vc = [[XYHomePagingViewController alloc] init];
    vc.navTitle = @"标签控制器";

    JXCategoryTitleView *titleCategoryView = (JXCategoryTitleView *)vc.myCategoryView;
    titleCategoryView.titleColor = kColor666666;
    titleCategoryView.titleSelectedColor = UIColor.blackColor;
    titleCategoryView.titleColorGradientEnabled = YES;
    titleCategoryView.titleLabelZoomEnabled = YES;
    titleCategoryView.titleLabelZoomScale = 1.1;
    titleCategoryView.titleLabelStrokeWidthEnabled = YES;
    titleCategoryView.selectedAnimationEnabled = YES;
    
    titleCategoryView.cellSpacing = 0;
    titleCategoryView.contentEdgeInsetLeft = 0;
    titleCategoryView.contentEdgeInsetRight = 0;
    titleCategoryView.averageCellSpacingEnabled = NO;
    titleCategoryView.cellWidth = kScreenWidth/4;
    titleCategoryView.titleFont = kFontWithRealsize(14);
            
    vc.lineView.indicatorColor = UIColor.blackColor;
    vc.lineView.indicatorHeight = 2;
    vc.lineView.lineStyle = JXCategoryIndicatorLineStyle_Normal;
    
    vc.headerView.imageView.image = kImageWithName(@"AppIcon_1024");

    vc.titles = @[@"全部", @"租赁中", @"待归还", @"已退租"];
    vc.homepageControllers = @[[self getHomepageVc],[self getHomepageVc],[self getHomepageVc],[self getHomepageVc]];
    
    JXPagerView *pageV = (JXPagerView *)vc.pagerView;
        
    [XYHelperRouter pushViewController:vc];
}


- (XYBasicViewController *)getVc {
    XYBasicViewController * vc = [XYBasicViewController new];
    vc.view.backgroundColor = kColorWithRandom;
    return vc;
}

- (XYHomePagingSubViewController *)getHomepageVc {
    
    KCExploreInformationViewController * vc = [KCExploreInformationViewController new];
    vc.isNeedRefresh = true;

    vc.isHomepageStyle = true;
    
    vc.headerHandler = ^{
        [MBProgressHUD showTextHUD:@"下拉刷新"];
    };
    
    vc.footerHandler = ^{
        [MBProgressHUD showTextHUD:@"上拉加载"];
    };
    
    return vc;
}

#pragma mark -

- (FYFImagePickerController *)imagePicker {
    if (!_imagePicker) {
        __weak typeof(self) weakSelf = self;
        _imagePicker = [[FYFImagePickerController alloc] initWithPresentingViewController:self];
        _imagePicker.callPickerCompletion = ^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (!strongSelf) {
                return;
            }
            [MBProgressHUD showHUDAddedTo:strongSelf.view animated:YES];
        };
        _imagePicker.imagePickerCompletion = ^(NSArray<UIImage *> * _Nonnull images, NSArray<NSURL *> * _Nonnull imageUrls) {
            kLog(@"images:%@",images.debugDescription);
            kLog(@"imageUrls:%@", imageUrls);
            [weakSelf renderImages:images imageUrls:imageUrls];
        };
        _imagePicker.videoPickerCompletion = ^(NSArray<NSData *> * _Nonnull videoDatas, NSArray<NSURL *> * _Nonnull videoUrls) {
            kLog(@"videoDatas:%@",videoDatas.debugDescription);
            kLog(@"videoUrls:%@", videoUrls);
            [weakSelf renderMovieDatas:videoDatas movieUrls:videoUrls];
        };

        _imagePicker.cancelPickerCompletion = ^{
            [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        };
        
        if (@available(iOS 14.0, *)) {
            _imagePicker.selectionLimit = 9;
        } else {
            // Fallback on earlier versions
        }
    }
    return _imagePicker;
}

- (void)renderImages:(NSArray<UIImage *>*)images imageUrls:(NSArray<NSURL *>*)imageUrls {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    NSMutableArray *imageModels = [NSMutableArray arrayWithCapacity:images.count];
    [images enumerateObjectsUsingBlock:^(UIImage*  _Nonnull image, NSUInteger idx, BOOL * _Nonnull stop) {
//        FYFImageModel *imageModel = [[FYFImageModel alloc] initWithImage:image imageUrl:imageUrls[idx]];
//        [imageModels addObject:imageModel];
    }];
//    self.imageCollectionView.imageModels = imageModels;
}

- (void)renderMovieDatas:(NSArray<NSData *>*)movieDatas movieUrls:(NSArray<NSURL *>*)movieUrls {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    NSMutableArray *movieModels = [NSMutableArray arrayWithCapacity:movieDatas.count];
    [movieDatas enumerateObjectsUsingBlock:^(NSData*  _Nonnull movieData, NSUInteger idx, BOOL * _Nonnull stop) {
//        FYFMovieModel *movieModel = [[FYFMovieModel alloc] initWithMovieData:movieData movieUrl:movieUrls[idx] moviePreViewImage:[self requestVideoPreViewImage:movieUrls[idx]]];
//        [movieModels addObject:movieModel];
    }];
//    self.movieCollectionView.movieModels = movieModels;;
}

/// 获取视频第一帧
- (UIImage*)requestVideoPreViewImage:(NSURL *)path {
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:path options:nil];
    AVAssetImageGenerator *assetGen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    assetGen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [assetGen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *videoImage = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return videoImage;
}



@end
