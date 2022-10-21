//
//  FYFImagePickerController.m
//  FYFImagePicker
//
//  Created by 范云飞 on 2022/8/3.
//

#import "FYFImagePickerController.h"
#import <Photos/PHPhotoLibrary.h>
#import <CoreServices/CoreServices.h>
#import <PhotosUI/PhotosUI.h>
#import "FYFAppAuthorizations.h"

typedef NS_OPTIONS(NSUInteger, FYFImagePickerSourceType) {
    /// 录像
    FYFImagePickerSourceTypeCameraVedio = 1 << 0,
    /// 拍摄照片
    FYFImagePickerSourceTypeCameraPhoto = 1 << 1,
    /// 选择图片
    FYFImagePickerSourceTypePhotoLibraryImage = 1 << 2,
    /// 选择视频
    FYFImagePickerSourceTypePhotoLibraryVideo = 1 << 3,
};

API_AVAILABLE(ios(14))
@interface FYFImagePickerController ()<PHPickerViewControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, weak) UIViewController *presentingViewController;
@property (nonatomic, assign) NSUInteger sourceType;
@property (nonatomic, strong) PHPickerViewController *phImagePickerViewController;
@property (nonatomic, strong) PHPickerViewController *phVideoPickerViewController;

@end

@implementation FYFImagePickerController
- (void)dealloc {
#ifdef DEBUG
    NSLog(@"FYFImagePickerController dealloc");
#endif
}

/// 初始化
/// @param presentingViewController presentingViewController
- (instancetype)initWithPresentingViewController:(UIViewController *)presentingViewController {
    if (self = [super init]) {
        _presentingViewController = presentingViewController;
        _selectionLimit = 1;
    }
    return self;
}

#pragma mark - Take Video
/// 录像
- (void)cameraVedioPicker {
    _sourceType = FYFImagePickerSourceTypeCameraVedio;
    [self requestCameraVedioAuthorization];
}

- (void)requestCameraVedioAuthorization {
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSLog(@"该设备不支持录像");
        return;
    }
    __weak typeof(self) weakSelf = self;
    [FYFCameraAuthorization requestAuthorizationStatusForVideoWithCompletionHandler:^(FYFAVAuthorizationStatus status) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
#if TARGET_IPHONE_SIMULATOR
        NSLog(@"模拟器不支持相机");
#elif TARGET_OS_IPHONE
        if (status == FYFAVAuthorizationStatusAuthorized) {
            [strongSelf takeVideo];
        } else {
            if (status == FYFAVAuthorizationStatusNotDetermined) {
                NSLog(@"应用还未被授权是否可以访问相机");
            } else if (status == FYFAVAuthorizationStatusRestricted) {
                NSLog(@"应用未被授权访问相机");
            } else if (status == FYFAVAuthorizationStatusDenied){
                NSLog(@"应用被拒绝访问相机");
            }
        }
#endif
    }];
}

- (void)takeVideo {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePickerController.mediaTypes = @[(NSString*)kUTTypeMovie];
    imagePickerController.allowsEditing = YES;
    imagePickerController.videoQuality = UIImagePickerControllerQualityTypeMedium;
    imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
    imagePickerController.modalPresentationStyle = UIModalPresentationOverFullScreen;
    __weak typeof(self) weakSelf = self;
    [self.presentingViewController presentViewController:imagePickerController animated:YES completion:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        if (strongSelf.callPickerCompletion) {
            strongSelf.callPickerCompletion();
        }
    }];
}

#pragma mark - Take Photo
/// 拍照
- (void)cameraPhotoPicker {
    _sourceType = FYFImagePickerSourceTypeCameraPhoto;
    [self requestCameraPhotoAuthorization];
}

- (void)requestCameraPhotoAuthorization {
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSLog(@"该设备不支持拍照");
        return;
    }
    __weak typeof(self) weakSelf = self;
    [FYFCameraAuthorization requestAuthorizationStatusForVideoWithCompletionHandler:^(FYFAVAuthorizationStatus status) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
#if TARGET_IPHONE_SIMULATOR
        NSLog(@"模拟器不支持相机");
#elif TARGET_OS_IPHONE
        if (status == FYFAVAuthorizationStatusAuthorized) {
            [strongSelf takePhoto];
        } else {
            if (status == FYFAVAuthorizationStatusNotDetermined) {
                NSLog(@"应用还未被授权是否可以访问相机");
            } else if (status == FYFAVAuthorizationStatusRestricted) {
                NSLog(@"应用未被授权访问相机");
            } else if (status == FYFAVAuthorizationStatusDenied){
                NSLog(@"应用被拒绝访问相机");
            }
        }
#endif
    }];
}

- (void)takePhoto {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePickerController.mediaTypes = @[(NSString*)kUTTypeImage];
    imagePickerController.allowsEditing = YES;
    imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
    imagePickerController.modalPresentationStyle = UIModalPresentationOverFullScreen;
    __weak typeof(self) weakSelf = self;
    [self.presentingViewController presentViewController:imagePickerController animated:YES completion:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        if (strongSelf.callPickerCompletion) {
            strongSelf.callPickerCompletion();
        }
    }];
}

#pragma mark - Image or Video Picker
/// 选择图片
- (void)imagePicker {
    _sourceType = FYFImagePickerSourceTypePhotoLibraryImage;
    [self requestPhotoLibraryAuthorization];
}

/// 选择视频
- (void)videoPicker {
    _sourceType = FYFImagePickerSourceTypePhotoLibraryVideo;
    [self requestPhotoLibraryAuthorization];
}

- (void)requestPhotoLibraryAuthorization {
    __weak typeof(self) weakSelf = self;
    [FYFPhotoAuthorization requestPhotosAuthorizationWithHandler:^(FYFPHAuthorizationStatus status) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        if (status == FYFPHAuthorizationStatusLimited || status == FYFPHAuthorizationStatusAuthorized) {
            [strongSelf photoLibrary];
        } else {
            if (status == FYFPHAuthorizationStatusRestricted) {
                NSLog(@"应用未被授权访问相册");
            } else if (status == FYFPHAuthorizationStatusNotDetermined) {
                NSLog(@"应用还未被授权是否可以访问相册");
            } else if (status == FYFPHAuthorizationStatusDenied) {
                NSLog(@"应用被拒绝访问相册");
            }
        }
    }];
}

- (void)photoLibrary {
    if (@available(iOS 14, *)){
        __weak typeof(self) weakSelf = self;
        PHPickerViewController *phPickerViewController;
        if (_sourceType == FYFImagePickerSourceTypePhotoLibraryImage) {
            phPickerViewController = self.phImagePickerViewController;
        } else {
            phPickerViewController = self.phVideoPickerViewController;
        }
        [self.presentingViewController presentViewController:phPickerViewController animated:YES completion:^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (!strongSelf) {
                return;
            }
            if (strongSelf.callPickerCompletion) {
                strongSelf.callPickerCompletion();
            }
        }];
    } else {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        if (_sourceType == FYFImagePickerSourceTypePhotoLibraryVideo) {
            imagePickerController.mediaTypes = @[(NSString *)kUTTypeVideo,(NSString *)kUTTypeMovie];
        } else {
            imagePickerController.mediaTypes = @[(NSString*)kUTTypeImage];
        }
        imagePickerController.allowsEditing = YES;
        imagePickerController.modalPresentationStyle = UIModalPresentationOverFullScreen;
        __weak typeof(self) weakSelf = self;
        [self.presentingViewController presentViewController:imagePickerController animated:YES completion:^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (!strongSelf) {
                return;
            }
            if (strongSelf.callPickerCompletion) {
                strongSelf.callPickerCompletion();
            }
        }];
    }
}

- (PHPickerViewController *)phImagePickerViewController  API_AVAILABLE(ios(14)){
    if (!_phImagePickerViewController) {
        _phImagePickerViewController = [self createPHPickerViewController:FYFImagePickerSourceTypePhotoLibraryImage];
    }
    return _phImagePickerViewController;
}

- (PHPickerViewController *)phVideoPickerViewController  API_AVAILABLE(ios(14)){
    if (!_phVideoPickerViewController) {
        _phVideoPickerViewController = [self createPHPickerViewController:FYFImagePickerSourceTypePhotoLibraryVideo];
    }
    return _phVideoPickerViewController;
}

- (PHPickerViewController *)createPHPickerViewController:(FYFImagePickerSourceType)sourceType  API_AVAILABLE(ios(14)){
    PHPickerConfiguration *config = [PHPickerConfiguration new];
    if (_selectionLimit > 9) {
        _selectionLimit = 9;
    }
    config.selectionLimit = _selectionLimit;
    PHPickerFilter *imageFilter = [PHPickerFilter imagesFilter];
    PHPickerFilter *livePhotosFilter = [PHPickerFilter livePhotosFilter];
    PHPickerFilter *videosFilter = [PHPickerFilter videosFilter];
    if (sourceType == FYFImagePickerSourceTypePhotoLibraryImage) {
        config.filter = [PHPickerFilter anyFilterMatchingSubfilters:@[imageFilter, livePhotosFilter]];
    } else {
        config.filter = [PHPickerFilter anyFilterMatchingSubfilters:@[videosFilter]];
    }
    config.preferredAssetRepresentationMode = PHPickerConfigurationAssetRepresentationModeCompatible;
    PHPickerViewController *phPickerViewController = [[PHPickerViewController alloc] initWithConfiguration:config];
    phPickerViewController.modalPresentationStyle = UIModalPresentationOverFullScreen;
    phPickerViewController.delegate = self;
    return phPickerViewController;
}

#pragma mark - PHPickerViewControllerDelegate
- (void)picker:(PHPickerViewController *)picker didFinishPicking:(NSArray<PHPickerResult *> *)results  API_AVAILABLE(ios(14)) {
    [picker dismissViewControllerAnimated:YES completion:nil];
    if (!results.count) {
        if (self.cancelPickerCompletion) {
            self.cancelPickerCompletion();
        }
        return;
    }
    if (_sourceType == FYFImagePickerSourceTypePhotoLibraryImage) {
        [self loadImages:results];
    } else {
        [self loadVideos:results];
    }
}

- (void)loadImages:(NSArray<PHPickerResult *> *)results  API_AVAILABLE(ios(14)){
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:results.count];
    NSMutableArray *imageUrls = [NSMutableArray arrayWithCapacity:results.count];
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [results enumerateObjectsUsingBlock:^(PHPickerResult * _Nonnull result, NSUInteger idx, BOOL * _Nonnull stop) {
            dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
            if ([result.itemProvider canLoadObjectOfClass:[PHLivePhoto class]]) {
                [result.itemProvider loadObjectOfClass:[PHLivePhoto class] completionHandler:^(__kindof id<NSItemProviderReading>  _Nullable object, NSError * _Nullable error) {
                    PHLivePhoto *livePhoto = (PHLivePhoto *)object;
                    /// 图片本地url
                    NSURL *url = [livePhoto valueForKey:@"imageURL"];
                    UIImage *image = [UIImage imageWithContentsOfFile:[url path]];
                    
                    NSData *imageData = UIImageJPEGRepresentation(image, 1);
                    NSError *fileManagerError = nil;
                    NSURL *tempImageUrl = [FYFImagePickerController fyf_tempImageUrl];
                    BOOL writeSuccesss = [imageData writeToURL:tempImageUrl atomically:YES];
                    if (image) {
                        [images addObject:image];
                        if (writeSuccesss && tempImageUrl) {
                            [imageUrls addObject:tempImageUrl];
                        }
                    }
                    dispatch_semaphore_signal(semaphore);
                }];
            } else if ([result.itemProvider canLoadObjectOfClass:[UIImage class]]) {
                [result.itemProvider loadObjectOfClass:[UIImage class] completionHandler:^(__kindof id<NSItemProviderReading>  _Nullable object, NSError * _Nullable error) {
                    if ([object isKindOfClass:[UIImage class]]) {
                        UIImage *image = (UIImage *)object;
                        
                        NSData *imageData = UIImageJPEGRepresentation(image, 1);
                        NSError *fileManagerError = nil;
                        NSURL *tempImageUrl = [FYFImagePickerController fyf_tempImageUrl];
                        BOOL writeSuccesss = [imageData writeToURL:tempImageUrl atomically:YES];
                        if (image) {
                            [images addObject:image];
                            if (writeSuccesss && tempImageUrl) {
                                [imageUrls addObject:tempImageUrl];
                            }
                        }
                    }
                    dispatch_semaphore_signal(semaphore);
                }];
            } else {
                dispatch_semaphore_signal(semaphore);
            }
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        }];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (!strongSelf) {
                return;
            }
            if (strongSelf.imagePickerCompletion) {
                strongSelf.imagePickerCompletion(images, imageUrls);
            }
        });
    });
}

- (void)loadVideos:(NSArray<PHPickerResult *> *)results  API_AVAILABLE(ios(14)){
    NSMutableArray *videoDatas = [NSMutableArray arrayWithCapacity:results.count];
    NSMutableArray *videoUrls = [NSMutableArray arrayWithCapacity:results.count];
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [results enumerateObjectsUsingBlock:^(PHPickerResult * _Nonnull result, NSUInteger idx, BOOL * _Nonnull stop) {
            dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
            [result.itemProvider loadFileRepresentationForTypeIdentifier:(NSString *)kUTTypeMovie completionHandler:^(NSURL * _Nullable url, NSError * _Nullable error) {
                NSData *videoData = [NSData dataWithContentsOfURL:url]; /// 视频本地URL
                NSURL *tempVideoUrl = [FYFImagePickerController fyf_tempVideoUrl];
                BOOL writeSuccess = [videoData writeToURL:tempVideoUrl atomically:YES];
                if (videoData) {
                    [videoDatas addObject:videoData];
                    if (writeSuccess && tempVideoUrl) {
                        [videoUrls addObject:tempVideoUrl];
                    }
                }
                dispatch_semaphore_signal(semaphore);
            }];
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (!strongSelf) {
                return;
            }
            if (strongSelf.videoPickerCompletion) {
                strongSelf.videoPickerCompletion(videoDatas, videoUrls);
            }
        });
    });
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    if (!info.allKeys.count) {
        if (self.cancelPickerCompletion) {
            self.cancelPickerCompletion();
        }
        return;
    }
    
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(NSString*)kUTTypeMovie]) {
        NSURL *url = [info objectForKey:UIImagePickerControllerMediaURL];
        NSString *path = [url path];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(path)) {
                UISaveVideoAtPathToSavedPhotosAlbum(path, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
            }
            NSData *videoData = [NSData dataWithContentsOfFile:path];
            NSError *fileManagerError = nil;
            NSURL *tempVideoUrl = [FYFImagePickerController fyf_tempVideoUrl];
            BOOL writeSuccesss = [videoData writeToURL:tempVideoUrl atomically:YES];
            NSArray *videoDatas;
            NSArray *videoUrls;
            if (videoData) {
                videoDatas = @[videoData];
                if (writeSuccesss && tempVideoUrl) {
                    videoUrls = @[tempVideoUrl];
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self.videoPickerCompletion) {
                    self.videoPickerCompletion(videoDatas, videoUrls);
                }
            });
        });
    } else if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(NSString*)kUTTypeImage]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
        if (!image) {
            image = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
            
            NSData *imageData = UIImageJPEGRepresentation(image, 1);
            NSError *fileManagerError = nil;
            NSURL *tempImageUrl = [FYFImagePickerController fyf_tempImageUrl];
            BOOL writeSuccesss = [imageData writeToURL:tempImageUrl atomically:YES];
            
            NSArray *images;
            NSArray *imageUrls;
            if (image) {
                images = @[image];
                if (writeSuccesss && tempImageUrl) {
                    imageUrls = @[tempImageUrl];
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self.imagePickerCompletion) {
                    self.imagePickerCompletion(images, imageUrls);
                }
            });
        });
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    __weak typeof(self) weakSelf = self;
    [picker dismissViewControllerAnimated:YES completion:^{
        if (weakSelf.cancelPickerCompletion) {
            weakSelf.cancelPickerCompletion();
        }
    }];
}

- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error == nil){
        NSLog(@"Video was saved successfully.");
    } else {
        NSLog(@"An error happened while saving the video. error:%@",error.debugDescription);
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error == nil){
        NSLog(@"Image was saved successfully.");
    } else {
        NSLog(@"An error happened while saving the image. error:%@",error.debugDescription);
    }
}

#pragma mark - Private
+ (NSURL *)fyf_tempImageUrl {
    return [NSURL fileURLWithPath:[[NSTemporaryDirectory() stringByAppendingPathComponent:[[NSUUID UUID] UUIDString]] stringByAppendingPathExtension:@"jpg"]];
}

+ (NSURL *)fyf_tempVideoUrl {
    return [NSURL fileURLWithPath:[[NSTemporaryDirectory() stringByAppendingPathComponent:[[NSUUID UUID] UUIDString]] stringByAppendingPathExtension:@"MOV"]];
}

@end
