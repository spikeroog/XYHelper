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

//#import <YBImageBrowser/YBImageBrowser.h> // 浏览图片
//#import <YBImageBrowser/YBIBVideoData.h> // 浏览视频

@interface XYViewController () <UIDocumentPickerDelegate>
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
    
    UIButton *protocolBtn = [XYHelperUtils createUserProButtonWithFullstring:@"已阅读并同意《用户协议》《隐私政策》" normalSelectTitle:@"已阅读并同意" highlightSelectTitleArr:@[@"《用户协议》",@"《隐私政策》"] normalColor:kColor666666 highlightColor:kColorWithRGB16Radix(0x2EA8FF) normalFont:kRl(10.5f) highlightFont:kRl(10.5f) isShowCheck:YES checkNormalImage:kImageWithName(@"icon_login_cycle_uns") checkHighlightImage:kImageWithName(@"icon_login_cycle_s") isDefaultCheck:NO completion:^(NSInteger idx) {
        
        if (idx == 1) {
            [MBProgressHUD showTextHUD:@"1"];
            
        } else if (idx == 2) {
            [MBProgressHUD showTextHUD:@"2"];

        }

        
    }];
    protocolBtn.backgroundColor = UIColor.redColor;

    [self.view addSubview:protocolBtn];
    [protocolBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-kNavBarHeight);
//        make.left.equalTo(self.view).offset(kRl(20));
        make.centerX.equalTo(self.view);
        make.width.offset(kRl(288));
        make.height.offset(kRl(41));
    }];
    
    
    UIButton *protocolBtn2 = [XYHelperUtils createLeftModelUserProButtonWithFullstring:@"已阅读并同意《用户协议》《隐私政策》" normalSelectTitle:@"已阅读并同意" highlightSelectTitleArr:@[@"《用户协议》",@"《隐私政策》"] normalColor:kColor666666 highlightColor:kColorWithRGB16Radix(0x2EA8FF) normalFont:kRl(10.5f) highlightFont:kRl(10.5f) isShowCheck:YES checkNormalImage:kImageWithName(@"icon_login_cycle_uns") checkHighlightImage:kImageWithName(@"icon_login_cycle_s") isDefaultCheck:NO completion:^(NSInteger idx) {
        
        if (idx == 1) {
            [MBProgressHUD showTextHUD:@"1"];
            
        } else if (idx == 2) {
            [MBProgressHUD showTextHUD:@"2"];

        }

    }];

    [self.view addSubview:protocolBtn2];
    [protocolBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-200);
//        make.left.equalTo(self.view).offset(kRl(20));
        make.centerX.equalTo(self.view);
        make.width.offset(kRl(288));
        make.height.offset(kRl(41));
    }];

}

- (void)gotoImagePickVc {
    
    [self pickImage];
}

- (void)pickImage {
    @weakify(self);
//    [[XYImagePickerManager shareInstance] imagePickerallowPickingMuitlple:true allowTakePhoto:true allowTakeVideo:false sortAscending:true allowPickingPhoto:true allowPickingVideo:false allowPickingOriginalPhoto:false showSheet:true showCornermark:true allowCrop:true needCircleCrop:true maxCount:9 maxImageSize:2 maxVideoSize:1000 pictureCallBack:^(NSArray<UIImage *> * _Nonnull backupsImgArray, NSArray<PHAsset *> * _Nonnull assetArray) {
//
//        NSMutableArray *imageArrayMut = [NSMutableArray new];
//        [assetArray enumerateObjectsUsingBlock:^(id  _Nonnull singleObj, NSUInteger singleIdx, BOOL * _Nonnull singleStop) {
//            PHAsset * asset = (PHAsset *)singleObj;
//            YBIBImageData *data = [YBIBImageData new];
//            NSLog(@"%@", [asset valueForKey:@"filename"]);
//            data.imageName = [asset valueForKey:@"filename"];
//            data.projectiveView = self.view;
//            [imageArrayMut addObject:data];
//        }];
//
//        YBImageBrowser *browser = [YBImageBrowser new];
//        browser.dataSourceArray = imageArrayMut;
//        browser.currentPage = 0;
//        [browser show];
//
//    } videoCallBack:^(NSString * _Nonnull outputPath, UIImage * _Nonnull coverImage) {
//        @strongify(self);
//
//
//    } targetVC:self];
}

- (void)pickVideo {
    
    @weakify(self);
    
//    [[XYImagePickerManager shareInstance] imagePickerallowPickingMuitlple:false allowTakePhoto:false allowTakeVideo:true sortAscending:true allowPickingPhoto:false allowPickingVideo:true allowPickingOriginalPhoto:false showSheet:true showCornermark:true allowCrop:true needCircleCrop:true maxCount:9 maxImageSize:1 maxVideoSize:1000 pictureCallBack:^(NSArray<UIImage *> * _Nonnull backupsImgArray, NSArray<PHAsset *> * _Nonnull assetArray) {
//
//    } videoCallBack:^(NSString * _Nonnull outputPath, UIImage * _Nonnull coverImage) {
//        @strongify(self);
//
//        AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:outputPath] options:nil];
//
//        NSMutableArray *videoArrayMut = [NSMutableArray new];
//        YBIBVideoData *data = [YBIBVideoData new];
//
//        data.videoAVAsset = asset;
//        data.projectiveView = self.view;
//        [videoArrayMut addObject:data];
//
//        YBImageBrowser *browser = [YBImageBrowser new];
//        browser.dataSourceArray = videoArrayMut;
//        browser.currentPage = 0;
//        [browser show];
//
//
//    } targetVC:self];
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
    
    
    [self pushToDocumentPickerVC];
    
//    [self showPagingVIewModel_3];
//    return;
    
//    [self gotoImagePickVc];

}

- (void)pushToDocumentPickerVC {
    NSArray *documentTypes = @[@"public.content", @"public.text", @"public.source-code ", @"public.image", @"public.audiovisual-content", @"com.adobe.pdf", @"com.apple.keynote.key", @"com.microsoft.word.doc", @"com.microsoft.excel.xls", @"com.microsoft.powerpoint.ppt", @"public.avi"];
    
    UIDocumentPickerViewController *documentPickerViewController = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:documentTypes inMode:UIDocumentPickerModeOpen];
    documentPickerViewController.delegate = self;

    documentPickerViewController.modalPresentationStyle = UIModalPresentationFormSheet;
//    documentPickerViewController.modalPresentationStyle = UIModalPresentationOverFullScreen;

    [self presentViewController:documentPickerViewController animated:YES completion:nil];
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
    vc.controllers = @[[XYBasicViewController new],[XYBasicViewController new],[XYBasicViewController new],[XYBasicViewController new]];

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

#pragma mark - UIDocumentPickerDelegate

- (void)documentPickerWasCancelled:(UIDocumentPickerViewController *)controller {
    [MBProgressHUD removeLoadingHud];

}

- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentsAtURLs:(nonnull NSArray<NSURL *> *)urls {
    
    BOOL fileUrlAuthozied = [urls.firstObject startAccessingSecurityScopedResource];
    
    __block NSString *fileName;
    __block NSData *musicData;
    __block NSString *pathUrl;
    
    if (fileUrlAuthozied) {
        //通过文件协调工具来得到新的文件地址，以此得到文件保护功能
        NSFileCoordinator *fileCoordinator = [[NSFileCoordinator alloc] init];
        NSError *error;
        [fileCoordinator coordinateReadingItemAtURL:urls.firstObject options:0 error:&error byAccessor:^(NSURL *newURL) {
            
            //读取文件
            fileName = [newURL lastPathComponent];
            NSError *error = nil;
            NSData *fileData = [NSData dataWithContentsOfURL:newURL options:NSDataReadingMappedIfSafe error:&error];
            
            if (error) {
                //读取出错
                [MBProgressHUD removeLoadingHud];

            } else {
                
                //保存
                musicData = fileData;
                NSArray *paths  = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                NSString*path = [paths objectAtIndex:0];
                path = [path stringByAppendingString:@"/YWBG"];
                if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
                    [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
                }
                pathUrl = [path stringByAppendingPathComponent:fileName];
                [musicData writeToFile:pathUrl atomically:YES];
                
#pragma mark - 上传音乐文件
//                [self uploadMusic:pathUrl];
            }
            
            [self dismissViewControllerAnimated:YES completion:NULL];
        }];
        
        [urls.firstObject stopAccessingSecurityScopedResource];
        
    }else{
        //授权失败
    }
}

@end
