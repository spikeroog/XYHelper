//
//  FYFPhotoAuthorization.m
//  Pods
//
//  Created by 范云飞 on 2022/8/3.
//

#import "FYFPhotoAuthorization.h"
#import <Photos/Photos.h>

/**
 请在info.plist中添加 Privacy - Photo Library Usage Description
 */

@implementation FYFPhotoAuthorization

+ (void)requestPhotosAuthorizationWithHandler:(void(^)(FYFPHAuthorizationStatus status))handler {
    if (@available(iOS 14, *)) {
        PHAccessLevel level = PHAccessLevelReadWrite;
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatusForAccessLevel:level];
        if (status == PHAuthorizationStatusAuthorized) {
            handler(FYFPHAuthorizationStatusAuthorized);
            return;
        }
        
        if (status == PHAuthorizationStatusLimited) {
            handler(FYFPHAuthorizationStatusLimited);
            return;
        }
        
        [PHPhotoLibrary requestAuthorizationForAccessLevel:PHAccessLevelReadWrite handler:^(PHAuthorizationStatus status) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (status == PHAuthorizationStatusAuthorized || status == PHAuthorizationStatusLimited) {
                    handler(FYFPHAuthorizationStatusAuthorized);
                } else if (status == PHAuthorizationStatusLimited) {
                    handler(FYFPHAuthorizationStatusLimited);
                } else if (status == PHAuthorizationStatusDenied) {
                    handler(FYFPHAuthorizationStatusDenied);
                } else if (status == PHAuthorizationStatusRestricted) {
                    handler(FYFPHAuthorizationStatusRestricted);
                } else if (status == PHAuthorizationStatusNotDetermined) {
                    handler(FYFPHAuthorizationStatusNotDetermined);
                }
            });
        }];
        
    } else {
        PHAuthorizationStatus photoStatus= PHPhotoLibrary.authorizationStatus;
        if (photoStatus == PHAuthorizationStatusAuthorized) {
            handler(FYFPHAuthorizationStatusAuthorized);
            return;
        }
        
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (status == PHAuthorizationStatusAuthorized) {
                    handler(FYFPHAuthorizationStatusAuthorized);
                } else if (status == PHAuthorizationStatusDenied) {
                    handler(FYFPHAuthorizationStatusDenied);
                } else if (status == PHAuthorizationStatusRestricted) {
                    handler(FYFPHAuthorizationStatusRestricted);
                } else if (status == PHAuthorizationStatusNotDetermined) {
                    handler(FYFPHAuthorizationStatusNotDetermined);
                }
            });
        }];
    }
}

@end

