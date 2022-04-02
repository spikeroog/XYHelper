//
//  UIApplication+AEHook.h
//  syapp
//
//  Created by spikeroog on 2021/12/1.
//  Copyright © 2021 spikeroog. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIApplication (AEHook)
+ (void)hookUIApplication;

@end

NS_ASSUME_NONNULL_END
