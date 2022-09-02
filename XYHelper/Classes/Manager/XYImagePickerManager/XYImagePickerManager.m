//
//  XYImagePickerManager.m
//  XYHelper
//
//  Created by spikeroog on 2019/10/16.
//  Copyright © 2019 spikeroog. All rights reserved.
//

#import "XYImagePickerManager.h"

#import <MobileCoreServices/MobileCoreServices.h>
#import <Photos/Photos.h>
#import <PhotosUI/PhotosUI.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <ReactiveObjC/ReactiveObjC.h>

#import "XYHelperRouter.h"
#import "XYHelperMarco.h"
#import "XYScreenAdapter.h"
#import "UIView+XYHelper.h"
#import "MBProgressHUD+XYHelper.h"
#import "XYHelperUtils.h"

#import "TZImageUploadOperation.h"

// 视频最大拍摄时间(s)
#define kVideoMaxTime 10

@interface XYImagePickerManager ()
<TZImagePickerControllerDelegate,
UIImagePickerControllerDelegate,
UIAlertViewDelegate,
UINavigationControllerDelegate> {
    NSMutableArray *_selectedPhotos;
    NSMutableArray *_selectedAssets;
}
@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@property (nonatomic, strong) TZImagePickerController *tz_ImagePickerVc;
@property (nonatomic, strong) CLLocation *location;
@property (nonatomic, copy) XYPictureCallBack pictureCallBackBlock;
@property (nonatomic, copy) XYVideoCallBack videoCallBackBlock;

@property (nonatomic, assign) NSInteger maxImageSize;
@property (nonatomic, assign) NSInteger maxVideoSize;
@property (nonatomic, assign) NSInteger maxCount;
@property (nonatomic, assign) BOOL allowCrop;
@property (nonatomic, assign) BOOL needCircleCrop;
@property (nonatomic, assign) BOOL isSelectOriginalPhoto;
@property (nonatomic, assign) BOOL isOriginalPhoto;
@property (nonatomic, strong) UIViewController *targetVC;

@property (nonatomic, strong) NSOperationQueue *operationQueue;

@end

@implementation XYImagePickerManager

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

+ (instancetype)shareInstance {
    static XYImagePickerManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[XYImagePickerManager alloc] init];
    });
    return manager;
}

#pragma mark - NSObject

- (UIImagePickerController *)imagePickerVc {
    if (!_imagePickerVc) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        // 视频最大拍摄时间
        _imagePickerVc.videoMaximumDuration = kVideoMaxTime;
        // set appearance / 改变相册选择页的导航栏外观
        _imagePickerVc.navigationBar.translucent = NO;
        _imagePickerVc.navigationBar.barTintColor = [XYHelperRouter navBgColor];
        _imagePickerVc.navigationBar.tintColor = [UIColor whiteColor];
        _imagePickerVc.allowsEditing = NO; // 不允许裁剪
        _imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
        
        UIBarButtonItem *tzBarItem, *BarItem;
        if (@available(iOS 9, *)) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    }
    return _imagePickerVc;
}

#pragma mark - 跳转TZImagePickerController
/**
 跳转TZImagePickerController
 
 @param allowPickingMuitlple 允许多选
 @param allowTakePhoto 允许拍照
 @param allowTakeVideo 允许拍视频
 @param sortAscending 照片排列按修改时间升序，默认是YES。如果设置为NO,最新的照片会显示在最前面，内部的拍照按钮会排在第一个
 @param allowPickingPhoto 允许选择照片
 @param allowPickingVideo 允许选择视频
 @param allowPickingOriginalPhoto 允许选择原图
 @param showSheet 显示一个sheet,把拍照/拍视频按钮放在外面
 @param showCornermark 多选时，显示选中图片的数字（第几个）
 @param allowCrop 单选模式下允许裁剪
 @param needCircleCrop 使用圆形裁剪框
 @param maxCount 照片最大可选张数，设置为1即为单选模式
 @param maxImageSize 最大图片大小
 @param maxVideoSize 最大视频大小
 @param pictureCallBack 图片回调
 @param videoCallBack 视频回调
 */
- (void)imagePickerallowPickingMuitlple:(BOOL)allowPickingMuitlple
                         allowTakePhoto:(BOOL)allowTakePhoto
                         allowTakeVideo:(BOOL)allowTakeVideo
                          sortAscending:(BOOL)sortAscending
                      allowPickingPhoto:(BOOL)allowPickingPhoto
                      allowPickingVideo:(BOOL)allowPickingVideo
              allowPickingOriginalPhoto:(BOOL)allowPickingOriginalPhoto
                              showSheet:(BOOL)showSheet
                         showCornermark:(BOOL)showCornermark
                              allowCrop:(BOOL)allowCrop
                         needCircleCrop:(BOOL)needCircleCrop
                               maxCount:(NSInteger)maxCount
                           maxImageSize:(CGFloat)maxImageSize
                           maxVideoSize:(CGFloat)maxVideoSize
                        pictureCallBack:(XYPictureCallBack)pictureCallBack
                          videoCallBack:(XYVideoCallBack)videoCallBack targetVC:(__kindof UIViewController *)targetVC {
    
    self.pictureCallBackBlock = pictureCallBack;
    self.videoCallBackBlock = videoCallBack;
    self.maxImageSize = maxImageSize;
    self.maxVideoSize = maxVideoSize;
    self.maxCount = maxCount;
    self.allowCrop = allowCrop;
    self.needCircleCrop = needCircleCrop;
    self.isOriginalPhoto = allowPickingOriginalPhoto;
    self.targetVC = targetVC;
    
    _selectedPhotos = [NSMutableArray new];
    _selectedAssets = [NSMutableArray new];
    
    // 参数介绍： MaxImagesCount：最多选择多少张图片  columnNumber：最少选择几张
    self.tz_ImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:maxCount columnNumber:1 delegate:self pushPhotoPickerVc:YES];
    self.tz_ImagePickerVc.allowPickingMultipleVideo = allowPickingMuitlple;
    self.tz_ImagePickerVc.allowTakePicture = allowTakePhoto;
    self.tz_ImagePickerVc.allowTakeVideo = allowTakeVideo;
    self.tz_ImagePickerVc.sortAscendingByModificationDate = sortAscending;
    self.tz_ImagePickerVc.allowPickingImage = allowPickingPhoto;
    self.tz_ImagePickerVc.allowPickingVideo = allowPickingVideo;
    self.tz_ImagePickerVc.allowPickingOriginalPhoto = allowPickingOriginalPhoto;
    self.tz_ImagePickerVc.allowCrop = allowCrop;
    self.tz_ImagePickerVc.needCircleCrop = needCircleCrop;
    self.tz_ImagePickerVc.showSelectedIndex = showCornermark;
    self.tz_ImagePickerVc.preferredLanguage = @"zh-Hans";
    self.tz_ImagePickerVc.allowPickingGif = true;
    self.tz_ImagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
    
    self.tz_ImagePickerVc.navigationBar.translucent = NO;
    self.tz_ImagePickerVc.navigationBar.barTintColor = [XYHelperRouter navBgColor];
    self.tz_ImagePickerVc.navigationBar.tintColor = [UIColor whiteColor];
    
    
    if (showSheet) {
        NSString *takePhotoTitle = @"拍照";
        if (self.tz_ImagePickerVc.allowTakeVideo && self.tz_ImagePickerVc.allowTakePicture) {
            takePhotoTitle = @"相机";
        } else if (self.tz_ImagePickerVc.allowTakeVideo) {
            takePhotoTitle = @"拍摄";
        }
        UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        @weakify(self);
        UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:takePhotoTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            @strongify(self);
            [self takePhoto:self.tz_ImagePickerVc];
        }];
        [alertVc addAction:takePhotoAction];
        UIAlertAction *imagePickerAction = [UIAlertAction actionWithTitle:@"去相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            @strongify(self);
            [self pushTZImagePickerController:self.tz_ImagePickerVc];
        }];
        [alertVc addAction:imagePickerAction];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertVc addAction:cancelAction];
        [[XYHelperRouter currentVC] presentViewController:alertVc animated:YES completion:nil];
    } else {
        [self pushTZImagePickerController:self.tz_ImagePickerVc];
    }
}

#pragma mark - TZImagePickerController Delegate

- (void)pushTZImagePickerController:(TZImagePickerController *)imagePickerVc {
    
#pragma mark - 设置导航栏默认字体大小
    imagePickerVc.naviTitleFont = kFontWithAutoSize(17);
    imagePickerVc.barItemTextFont = kFontWithAutoSize(15);
#pragma mark - 五类个性化设置，这些参数都可以不传，此时会走默认设置
    imagePickerVc.isSelectOriginalPhoto = self.isSelectOriginalPhoto;
    
    if (imagePickerVc.maxImagesCount > 1) {
        // 1.设置目前已经选中的图片数组
        imagePickerVc.selectedAssets = _selectedAssets; // 目前已经选中的图片数组
    }
    
    imagePickerVc.videoMaximumDuration = kVideoMaxTime; // 视频最大拍摄时间
    [imagePickerVc setUiImagePickerControllerSettingBlock:^(UIImagePickerController *imagePickerController) {
        imagePickerController.videoQuality = UIImagePickerControllerQualityTypeIFrame1280x720;
    }];
    
    // 自定义imagePickerVc导航栏背景颜色 标题颜色等
    imagePickerVc.navigationBar.translucent = NO;
    imagePickerVc.navigationBar.barTintColor = [XYHelperRouter navBgColor];
    imagePickerVc.navigationBar.tintColor = [UIColor whiteColor];
    
    imagePickerVc.iconThemeColor = [UIColor colorWithRed:31 / 255.0 green:185 / 255.0 blue:34 / 255.0 alpha:1.0];
    imagePickerVc.showPhotoCannotSelectLayer = YES;
    imagePickerVc.cannotSelectLayerColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    [imagePickerVc setPhotoPickerPageUIConfigBlock:^(UICollectionView *collectionView, UIView *bottomToolBar, UIButton *previewButton, UIButton *originalPhotoButton, UILabel *originalPhotoLabel, UIButton *doneButton, UIImageView *numberImageView, UILabel *numberLabel, UIView *divideLine) {
        [doneButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }];
    
    
    imagePickerVc.showSelectBtn = NO;
    imagePickerVc.allowCrop = self.allowCrop;
    imagePickerVc.needCircleCrop = self.needCircleCrop;
    // 设置竖屏下的裁剪尺寸
    CGFloat width = kScreenWidth;
    CGFloat height = width;
    CGFloat left = [XYHelperRouter fetchKeyWindow].xy_centerX-width/2;
    CGFloat top = [XYHelperRouter fetchKeyWindow].xy_centerY-height/2;
    imagePickerVc.cropRect = CGRectMake(left, top, width, height);
    // 设置横屏下的裁剪尺寸
    // imagePickerVc.cropRectLandscape = CGRectMake(left, top, kScreenWidth, kScreenWidth);
    /*
     [imagePickerVc setCropViewSettingBlock:^(UIView *cropView) {
     cropView.layer.borderColor = [UIColor redColor].CGColor;
     cropView.layer.borderWidth = 2.0;
     }];*/
    
    imagePickerVc.statusBarStyle = UIStatusBarStyleLightContent;
    
    // 自定义gif播放方案
    [[TZImagePickerConfig sharedInstance] setGifImagePlayBlock:^(TZPhotoPreviewView *view, UIImageView *imageView, NSData *gifData, NSDictionary *info) {
        FLAnimatedImage *animatedImage = [FLAnimatedImage animatedImageWithGIFData:gifData];
        FLAnimatedImageView *animatedImageView;
        for (UIView *subview in imageView.subviews) {
            if ([subview isKindOfClass:[FLAnimatedImageView class]]) {
                animatedImageView = (FLAnimatedImageView *)subview;
                animatedImageView.frame = imageView.bounds;
                animatedImageView.animatedImage = nil;
            }
        }
        if (!animatedImageView) {
            animatedImageView = [[FLAnimatedImageView alloc] initWithFrame:imageView.bounds];
            animatedImageView.runLoopMode = NSDefaultRunLoopMode;
            [imageView addSubview:animatedImageView];
        }
        animatedImageView.animatedImage = animatedImage;
    }];
    
    // 设置首选语言 / Set preferred language
    //     imagePickerVc.preferredLanguage = @"zh-Hans";
    //
    //    // 设置languageBundle以使用其它语言 / Set languageBundle to use other language
    //     imagePickerVc.languageBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"tz-ru" ofType:@"lproj"]];
    
#pragma mark - 到这里为止
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
    }];
    
    imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
    
    [[XYHelperRouter currentVC] presentViewController:imagePickerVc animated:YES completion:nil];
}

/// 用户点击了取消
- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker {
    // kLog(@"cancel");
}


// The picker should dismiss itself; when it dismissed these handle will be called.
// You can also set autoDismiss to NO, then the picker don't dismiss itself.
// If isOriginalPhoto is YES, user picked the original photo.
// You can get original photo with asset, by the method [[TZImageManager manager] getOriginalPhotoWithAsset:completion:].
// The UIImage Object in photos default width is 828px, you can set it by photoWidth property.
// 这个照片选择器会自己dismiss，当选择器dismiss的时候，会执行下面的代理方法
// 你也可以设置autoDismiss属性为NO，选择器就不会自己dismis了
// 如果isSelectOriginalPhoto为YES，表明用户选择了原图
// 你可以通过一个asset获得原图，通过这个方法：[[TZImageManager manager] getOriginalPhotoWithAsset:completion:]
// photos数组里的UIImage对象，默认是828像素宽，你可以通过设置photoWidth属性的值来改变它
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos {
    
    _selectedPhotos = [NSMutableArray arrayWithArray:photos];
    _selectedAssets = [NSMutableArray arrayWithArray:assets];
    _isSelectOriginalPhoto = isSelectOriginalPhoto;

    // _collectionView.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));

    // 1.打印图片名字
    [self printAssetsName:assets];
    // 2.图片位置信息
    for (PHAsset *phAsset in assets) {
        NSLog(@"location:%@",phAsset.location);
    }
    
    NSMutableArray *muPhotos = [photos mutableCopy];
    
    NSMutableArray *muPhotosAsset = [[NSMutableArray alloc] init];
    
    @weakify(self);
    
    [photos enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        @strongify(self);
        
        /// 获取本地图片的名字
        PHAsset *asset = assets[idx];
        [muPhotosAsset addObject:asset];
        
        if (self.maxImageSize > 0) {
            if ([XYHelperUtils fetchImageSize:obj] > self.maxImageSize) {
                [muPhotos removeObjectAtIndex:idx];
                [MBProgressHUD showTextHUD:[NSString stringWithFormat:@"请选择小于等于%ldM的图片文件", (long)self.maxImageSize]];
            }
        }
    }];
    if (muPhotos.count > 0) {
        !self.pictureCallBackBlock ? : self.pictureCallBackBlock(muPhotos, muPhotosAsset);
    }
    
    

    // 3. 获取原图的示例，用队列限制最大并发为1，避免内存暴增
//    self.operationQueue = [[NSOperationQueue alloc] init];
//    self.operationQueue.maxConcurrentOperationCount = 1;
//    for (NSInteger i = 0; i < assets.count; i++) {
//        PHAsset *asset = assets[i];
//        // 图片上传operation，上传代码请写到operation内的start方法里，内有注释
//        TZImageUploadOperation *operation = [[TZImageUploadOperation alloc] initWithAsset:asset completion:^(UIImage * photo, NSDictionary *info, BOOL isDegraded) {
//            if (isDegraded) return;
//            NSLog(@"图片获取&上传完成");
//        } progressHandler:^(double progress, NSError * _Nonnull error, BOOL * _Nonnull stop, NSDictionary * _Nonnull info) {
//            NSLog(@"获取原图进度 %f", progress);
//        }];
//        [self.operationQueue addOperation:operation];
//    }
}

#pragma mark - Private

/// 打印图片名字
- (void)printAssetsName:(NSArray *)assets {
    NSString *fileName;
    for (PHAsset *asset in assets) {
        fileName = [asset valueForKey:@"filename"];
        // NSLog(@"图片名字:%@",fileName);
    }
}

// 如果用户选择了一个视频且allowPickingMultipleVideo是NO，下面的代理方法会被执行
// 如果allowPickingMultipleVideo是YES，将会调用imagePickerController:didFinishPickingPhotos:sourceAssets:isSelectOriginalPhoto:
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(PHAsset *)asset {
    _selectedPhotos = [NSMutableArray arrayWithArray:@[coverImage]];
    _selectedAssets = [NSMutableArray arrayWithArray:@[asset]];
    
    PHAssetResource *resource = [[PHAssetResource assetResourcesForAsset:asset] firstObject];
    long long size = [[resource valueForKey:@"fileSize"] longLongValue];
    if (self.maxVideoSize > 0) {
        if ((CGFloat)size/(1024*1024) > self.maxVideoSize) {
            [MBProgressHUD showTextHUD:[NSString stringWithFormat:@"请选择小于等于%ldM的视频文件", (long)self.maxVideoSize]];
            return;
        }
    }
    
    // 选择视频后，有个导出的过程，视频越大越费时
    [MBProgressHUD showLoadingHUD:@"导出视频中.." canTouch:false];
    
    // open this code to send video / 打开这段代码发送视频
    @weakify(self);
    [[TZImageManager manager] getVideoOutputPathWithAsset:asset presetName:AVAssetExportPreset640x480 success:^(NSString *outputPath) {
        
        @strongify(self);
        
        [MBProgressHUD removeLoadingHud];
        
        !self.videoCallBackBlock ? : self.videoCallBackBlock(outputPath, coverImage);
        
        kLog(@"视频导出到本地完成,沙盒路径为:%@",outputPath);
        // Export completed, send video here, send by outputPath or NSData
        // 导出完成，在这里写上传代码，通过路径或者通过NSData上传
        
    } failure:^(NSString *errorMessage, NSError *error) {
        kLog(@"视频导出失败:%@,error:%@",errorMessage, error);
    }];
    
}


// 如果用户选择了一个gif图片且allowPickingMultipleVideo是NO，下面的代理方法会被执行
// 如果allowPickingMultipleVideo是YES，将会调用imagePickerController:didFinishPickingPhotos:sourceAssets:isSelectOriginalPhoto:
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingGifImage:(UIImage *)animatedImage
                 sourceAssets:(PHAsset *)asset {
    _selectedPhotos = [NSMutableArray arrayWithArray:@[animatedImage]];
    _selectedAssets = [NSMutableArray arrayWithArray:@[asset]];
}

// 决定相册显示与否
- (BOOL)isAlbumCanSelect:(NSString *)albumName result:(PHFetchResult *)result {
    /*
     if ([albumName isEqualToString:@"个人收藏"]) {
     return NO;
     }
     if ([albumName isEqualToString:@"视频"]) {
     return NO;
     }*/
    return YES;
}

// 决定asset显示与否
- (BOOL)isAssetCanSelect:(PHAsset *)asset {
    /*
     switch (asset.mediaType) {
     case PHAssetMediaTypeVideo: {
     // 视频时长
     // NSTimeInterval duration = phAsset.duration;
     return NO;
     } break;
     case PHAssetMediaTypeImage: {
     // 图片尺寸
     if (phAsset.pixelWidth > 3000 || phAsset.pixelHeight > 3000) {
     // return NO;
     }
     return YES;
     } break;
     case PHAssetMediaTypeAudio:
     return NO;
     break;
     case PHAssetMediaTypeUnknown:
     return NO;
     break;
     default: break;
     }
     */
    return YES;
}


#pragma mark - UIImagePickerController Delegate
- (void)takePhoto:(TZImagePickerController *)tzImagePickerController {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        // 无相机权限 做一个友好的提示
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        [alert show];
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        @weakify(self);
        // fix issue 466, 防止用户首次拍照拒绝授权时相机页黑屏
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            @strongify(self);
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self takePhoto:tzImagePickerController];
                });
            }
        }];
        // 拍照之前还需要检查相册权限
    } else if ([PHPhotoLibrary authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        [alert show];
    } else if ([PHPhotoLibrary authorizationStatus] == 0) { // 未请求过相册权限
        [[TZImageManager manager] requestAuthorizationWithCompletion:^{
            [self takePhoto:tzImagePickerController];
        }];
    } else {
        [self pushImagePickerController:tzImagePickerController];
    }
}

// 调用相机
- (void)pushImagePickerController:(TZImagePickerController *)tzImagePickerController {
    // 提前定位
    __weak typeof(self) weakSelf = self;
    [[TZLocationManager manager] startLocationWithSuccessBlock:^(NSArray<CLLocation *> *locations) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.location = [locations firstObject];
    } failureBlock:^(NSError *error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.location = nil;
    }];
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerVc.sourceType = sourceType;
        NSMutableArray *mediaTypes = [NSMutableArray array];
        if (tzImagePickerController.allowTakeVideo) {
            [mediaTypes addObject:(NSString *)kUTTypeMovie];
        }
        if (tzImagePickerController.allowTakePicture) {
            [mediaTypes addObject:(NSString *)kUTTypeImage];
        }
        if (mediaTypes.count) {
            self.imagePickerVc.mediaTypes = mediaTypes;
        }
        kLog(@"%d", self.imagePickerVc.allowsEditing);
        [[XYHelperRouter currentVC] presentViewController:self.imagePickerVc animated:YES completion:nil];
    } else {
        kLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    __block TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    
    tzImagePickerVc.sortAscendingByModificationDate = self.tz_ImagePickerVc.sortAscendingByModificationDate;
    
    [tzImagePickerVc showProgressHUD];
    
    if ([type isEqualToString:@"public.image"]) {
        /*
         UIImagePickerControllerOriginalImage 原图
         UIImagePickerControllerEditedImage 裁剪的图片
         */
        __block UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        @weakify(self);
        // save photo and get asset / 保存图片，获取到asset
        [[TZImageManager manager] savePhotoWithImage:image location:self.location completion:^(PHAsset *asset, NSError *error) {
            @strongify(self);
            [tzImagePickerVc hideProgressHUD];
            if (error) {
                kLog(@"图片保存失败 %@",error);
            } else {
                TZAssetModel *assetModel = [[TZImageManager manager] createModelWithAsset:asset];
                if (self.allowCrop) { // 允许裁剪,去裁剪
                    @weakify(self);
                    TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initCropTypeWithAsset:assetModel.asset photo:image completion:^(UIImage *cropImage, PHAsset *asset) {
                        @strongify(self);
                        // 返回图片回调
                        !self.pictureCallBackBlock ? : self.pictureCallBackBlock(@[cropImage], @[asset]);
                        [self refreshCollectionViewWithAddedAsset:asset image:cropImage];
                    }];
                    imagePicker.allowPickingImage = YES;
                    imagePicker.showSelectBtn = NO;
                    imagePicker.needCircleCrop = self.needCircleCrop;
                    imagePicker.allowCrop = self.allowCrop;
                    // 设置竖屏下的裁剪尺寸
                    CGFloat width = kScreenWidth;
                    CGFloat height = width;
                    CGFloat left = [XYHelperRouter fetchKeyWindow].xy_centerX-width/2;
                    CGFloat top = [XYHelperRouter fetchKeyWindow].xy_centerY-height/2;
                    imagePicker.cropRect = CGRectMake(left, top, width, height);
                    
                    imagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
                    [self.targetVC presentViewController:imagePicker animated:YES completion:nil];
                    
                } else {
                    if ([XYHelperUtils fetchImageSize:image] > self.maxImageSize) {
                        [MBProgressHUD showTextHUD:[NSString stringWithFormat:@"请选择小于等于%ldM的图片文件", (long)self.maxImageSize]];
                    } else {
                        // 返回图片回调
                        !self.pictureCallBackBlock ? : self.pictureCallBackBlock(@[image], @[asset]);
                        [self refreshCollectionViewWithAddedAsset:assetModel.asset image:image];
                    }
                }
            }
        }];
    } else if ([type isEqualToString:@"public.movie"]) {
        NSURL *videoUrl = [info objectForKey:UIImagePickerControllerMediaURL];
        if (videoUrl) {
            @weakify(self);
            [[TZImageManager manager]
             saveVideoWithUrl:videoUrl
             location:self.location
             completion:^(PHAsset *asset, NSError *error) {
                @strongify(self);
                [tzImagePickerVc hideProgressHUD];
                if (!error) {
                    TZAssetModel *assetModel = [[TZImageManager manager] createModelWithAsset:asset];
                    [[TZImageManager manager] getPhotoWithAsset:assetModel.asset completion:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {
                        if (!isDegraded && photo) {
                            !self.videoCallBackBlock ? :                             self.videoCallBackBlock([videoUrl absoluteString], photo);
                            [self refreshCollectionViewWithAddedAsset:assetModel.asset image:photo];
                        }
                    }];
                }
            }];
        }
    }
}

- (void)refreshCollectionViewWithAddedAsset:(PHAsset *)asset image:(UIImage *)image {
    [_selectedAssets addObject:asset];
    [_selectedPhotos addObject:image];
    if ([asset isKindOfClass:[PHAsset class]]) {
        PHAsset *phAsset = asset;
        kLog(@"location:%@",phAsset.location);
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if ([picker isKindOfClass:[UIImagePickerController class]]) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - UIAlertView Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) { // 去设置界面，开启相机访问权限
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }
}

#pragma clang diagnostic pop

@end
