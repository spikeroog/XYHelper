//
//  XYViewController.m
//  XYHelper
//
//  Created by spikeroog on 08/25/2020.
//  Copyright (c) 2020 spikeroog. All rights reserved.
//

#import "XYViewController.h"
#import <XYHelper/XYHelper.h>

@interface XYViewController ()

@end

@implementation XYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    UIButton *button = [XYHelperUtils createUserProButtonWithFullstring:@"登录即代表同意用户协议、隐私声明" normalSelectTitle:@"登录即代表同意" highlightSelectTitleArr:@[@"用户协议",@"、",@"隐私声明"] normalColor:kColor666666 highlightColor:kColorWithRGB16Radix(0x75B4FF) normalFont:kAutoCs(12) highlightFont:kAutoCs(12) isShowCheck:true checkNormalImage:nil checkHighlightImage:nil isDefaultCheck:true completion:^(NSInteger idx) {
        
    }];
    
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(kAutoCs(65));
        make.right.equalTo(self.view).offset(-kAutoCs(65));
        make.bottom.equalTo(self.view).offset(-(kAutoCs(10)+kBottomBarHeight));
        make.height.offset(kAutoCs(17));
    }];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
