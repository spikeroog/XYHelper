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

@interface XYViewController ()
@property (nonatomic, strong) FYFImagePickerController *imagePicker;

@end

@implementation XYViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"首页";

    self.barStyle = 1;
    
    self.view.backgroundColor = UIColor.blackColor;
    /// 导航栏背景颜色
    self.navBgImageStr = @"launcher_image_2020_0709";
//    self.navBgColor = UIColor.systemYellowColor;
    /// 导航栏标题颜色
    self.navTitleColor = UIColor.redColor;
    
    self.leftBarItemTitle = @"嵌套使用";
    self.rightBarItemTitle = @"底部锚点";
    self.barItemTextFont = kFontWithRealsize(20);
    self.navItemTitleFont = kFontWithRealsize(20);
    
    self.view.backgroundColor = kColorWithRandom;

    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = UIColor.systemBlueColor;
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    @weakify(self);
    [view addGestureForView:^{
        @strongify(self);

    }];
}

- (void)rightActionInController {
    [self gotoImagePickVc];
}

- (void)gotoImagePickVc {
    
    [[XYImagePickerManager shareInstance] imagePickerallowPickingMuitlple:true allowTakePhoto:true allowTakeVideo:true sortAscending:true allowPickingPhoto:true allowPickingVideo:true allowPickingOriginalPhoto:true showSheet:true showCornermark:true allowCrop:true needCircleCrop:true maxCount:10 maxImageSize:10 maxVideoSize:20 pictureCallBack:^(NSArray<UIImage *> * _Nonnull backupsImgArray, NSArray<PHAsset *> * _Nonnull assetArray) {
        
    } videoCallBack:^(NSString * _Nonnull outputPath, UIImage * _Nonnull coverImage) {
        
    } targetVC:self];
}


- (void)leftActionInController {
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
