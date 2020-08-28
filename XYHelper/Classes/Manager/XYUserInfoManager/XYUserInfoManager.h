//
//  XYUserInfoManager.h
//  XYHelper
//
//  Created by spikeroog on 2019/11/25.
//  Copyright © 2019 spikeroog. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYUserBasicModel.h"

static NSString * _Nullable const loginUserCurrent = @"XY_CurrentLoginUser";

NS_ASSUME_NONNULL_BEGIN

@interface XYUserInfoManager : NSObject

+ (instancetype)shareInstance;

/// 获取当前登陆的用户信息
+ (__kindof XYUserBasicModel *)currentLoginUser;
/// 保存当前登陆用户信息
+ (void)saveCurrentLoginUser:(__kindof XYUserBasicModel *)loginUser;
/// 清除登陆用户信息
+ (void)clearCurrentLoginUser;
/// 是否登陆
+ (BOOL)hasSignIn;


@end

NS_ASSUME_NONNULL_END
