//
//  XYViewController.m
//  XYHelper
//
//  Created by spikeroog on 2020/12/15.
//  Copyright © 2020 spikeroog. All rights reserved.
// 

#import "XYViewController.h"

@interface XYViewController ()

@end

@implementation XYViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"首页";
    
    
    self.view.backgroundColor = UIColor.blackColor;
    /// 导航栏背景颜色
    self.navBgImageStr = @"launcher_image_2020_0709";
    /// 导航栏标题颜色
    self.navTitleColor = kColorWithRandom;
    /// 导航栏按钮字体颜色
    self.hbd_tintColor = kColorWithRandom;
    self.hbd_barStyle = UIBarStyleBlack;
    
    self.leftBarItemTitle = @"嵌套使用";
    self.rightBarItemTitle = @"底部锚点";
   
    self.view.backgroundColor = kColorWithRandom;
    
    
}

- (void)leftActionInController {

}

- (void)rightActionInController {

}

- (id)getVc {
    XYViewController * vc = [XYViewController new];
    vc.view.backgroundColor = kColorWithRandom;
    return vc;
    
}

- (void)gotoImagePickVc {
    
    [[XYImagePickerManager shareInstance] imagePickerallowPickingMuitlple:true allowTakePhoto:true allowTakeVideo:true sortAscending:true allowPickingPhoto:true allowPickingVideo:true allowPickingOriginalPhoto:true showSheet:true showCornermark:true allowCrop:true needCircleCrop:true maxCount:10 maxImageSize:10 maxVideoSize:20 pictureCallBack:^(NSArray<UIImage *> * _Nonnull backupsImgArray, NSArray<PHAsset *> * _Nonnull assetArray) {
            
        } videoCallBack:^(NSString * _Nonnull outputPath, UIImage * _Nonnull coverImage) {
            
        } targetVC:self];
}

@end
