//
//  FYFImagePickerController.h
//  FYFImagePicker
//
//  Created by 范云飞 on 2022/8/3.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface FYFImagePickerController : NSObject

/// 可选择的资源数量，最大数量为9，默认值为1.
@property (nonatomic, assign) NSInteger selectionLimit API_AVAILABLE(ios(14.0));
/// 调起回调
@property (nonatomic, copy) void(^callPickerCompletion)(void);
/// 取消回调
@property (nonatomic, copy) void(^cancelPickerCompletion)(void);
/// 图片资源选择完成回调， 图片文件地址(NSTemporaryDirectory() 目录下)，无压缩
@property (nonatomic, copy) void(^imagePickerCompletion)(NSArray<UIImage *>*images, NSArray<NSURL *>*imageUrls);
/// 视频资源选择完成回调， 视频文件地址(NSTemporaryDirectory() 目录下)，无压缩
@property (nonatomic, copy) void(^videoPickerCompletion)(NSArray<NSData *>*videoDatas, NSArray<NSURL *>*videoUrls);

/// 初始化
/// @param presentingViewController presentingViewController
- (instancetype)initWithPresentingViewController:(UIViewController *)presentingViewController;
/// 录像
- (void)cameraVedioPicker;
/// 拍照
- (void)cameraPhotoPicker;
/// 选择图片
- (void)imagePicker;
/// 选择视频
- (void)videoPicker;

@end

NS_ASSUME_NONNULL_END

