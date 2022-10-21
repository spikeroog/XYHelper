//
//  FYFCameraAuthorization.m
//  Pods
//
//  Created by 范云飞 on 2022/8/3.
//

#import "FYFCameraAuthorization.h"
#import <AVFoundation/AVFoundation.h>

/**
 请在info.plist中添加 Privacy - Camera Usage Description
 */

@implementation FYFCameraAuthorization

+ (void)requestAuthorizationStatusForVideoWithCompletionHandler:(void(^)(FYFAVAuthorizationStatus status))completionHandler {
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusAuthorized) {
        completionHandler(FYFAVAuthorizationStatusAuthorized);
    } else if (status == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (granted) {
                    completionHandler(FYFAVAuthorizationStatusAuthorized);
                } else {
                    completionHandler(FYFAVAuthorizationStatusDenied);
                }
            });
        }];
    } else if (status == AVAuthorizationStatusDenied) {
        completionHandler(FYFAVAuthorizationStatusDenied);
    } else {
        completionHandler(FYFAVAuthorizationStatusRestricted);
    }
}

@end

