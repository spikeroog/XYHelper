//
//  NormalViewController.m
//  XYHelper_Example
//
//  Created by 杭州英捷鑫科技 on 2023/3/18.
//  Copyright © 2023 spikeroog. All rights reserved.
//

#import "NormalViewController.h"

@interface NormalViewController ()<UIDocumentPickerDelegate>

@end

@implementation NormalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton ui_buttonWithTitle:@"哈哈" imageName:nil target:self action:@selector(btnAct)];
    btn.backgroundColor = kColorWithRandom;
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(kRl(80));
        make.centerX.centerY.equalTo(self.view);
    }];
    
}

- (void)btnAct {
    
    [self pushToDocumentPickerVC];
    
}

- (void)pushToDocumentPickerVC {
    UIDocumentPickerViewController *documentPicker = [[UIDocumentPickerViewController alloc]
                                                        initWithDocumentTypes:@[@"public.image"] inMode:UIDocumentPickerModeImport];
      documentPicker.delegate = self;
      documentPicker.modalPresentationStyle = UIModalPresentationFormSheet;
      [self presentViewController:documentPicker animated:YES completion:nil];

//    NSArray *documentTypes = @[@"public.content", @"public.text", @"public.source-code ", @"public.image", @"public.audiovisual-content", @"com.adobe.pdf", @"com.apple.keynote.key", @"com.microsoft.word.doc", @"com.microsoft.excel.xls", @"com.microsoft.powerpoint.ppt", @"public.avi"];
//
//    UIDocumentPickerViewController *documentPickerViewController = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:documentTypes inMode:UIDocumentPickerModeOpen];
//    documentPickerViewController.delegate = self;
//
//    documentPickerViewController.modalPresentationStyle = UIModalPresentationFormSheet;
////    documentPickerViewController.modalPresentationStyle = UIModalPresentationOverFullScreen;
//
//    [self presentViewController:documentPickerViewController animated:YES completion:nil];
}

#pragma mark - UIDocumentPickerDelegate

- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentsAtURLs:(NSArray<NSURL *> *)urls {
    
    if (controller.documentPickerMode == UIDocumentPickerModeImport) {
        NSString *alertMessage = [NSString stringWithFormat:@"Successfully imported %@", [[urls lastObject] lastPathComponent]];
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertController *alertController = [UIAlertController
                                                  alertControllerWithTitle:@"Import"
                                                  message:alertMessage
                                                  preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        });
    }
    
}

//- (void)documentPickerWasCancelled:(UIDocumentPickerViewController *)controller {
//    [MBProgressHUD removeLoadingHud];
//
//}
//
//- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentsAtURLs:(nonnull NSArray<NSURL *> *)urls {
//
//    BOOL fileUrlAuthozied = [urls.firstObject startAccessingSecurityScopedResource];
//
//    __block NSString *fileName;
//    __block NSData *musicData;
//    __block NSString *pathUrl;
//
//    if (fileUrlAuthozied) {
//        //通过文件协调工具来得到新的文件地址，以此得到文件保护功能
//        NSFileCoordinator *fileCoordinator = [[NSFileCoordinator alloc] init];
//        NSError *error;
//        [fileCoordinator coordinateReadingItemAtURL:urls.firstObject options:0 error:&error byAccessor:^(NSURL *newURL) {
//
//            //读取文件
//            fileName = [newURL lastPathComponent];
//            NSError *error = nil;
//            NSData *fileData = [NSData dataWithContentsOfURL:newURL options:NSDataReadingMappedIfSafe error:&error];
//
//            if (error) {
//                //读取出错
//                [MBProgressHUD removeLoadingHud];
//
//            } else {
//
//                //保存
//                musicData = fileData;
//                NSArray *paths  = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//                NSString*path = [paths objectAtIndex:0];
//                path = [path stringByAppendingString:@"/YWBG"];
//                if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
//                    [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
//                }
//                pathUrl = [path stringByAppendingPathComponent:fileName];
//                [musicData writeToFile:pathUrl atomically:YES];
//
//#pragma mark - 上传音乐文件
////                [self uploadMusic:pathUrl];
//            }
//
//            [self dismissViewControllerAnimated:YES completion:NULL];
//        }];
//
//        [urls.firstObject stopAccessingSecurityScopedResource];
//
//    }else{
//        //授权失败
//    }
//}

@end
