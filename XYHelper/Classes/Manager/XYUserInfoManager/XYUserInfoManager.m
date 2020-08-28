//
//  XYUserInfoManager.m
//  XYHelper
//
//  Created by spikeroog on 2019/11/25.
//  Copyright © 2019 spikeroog. All rights reserved.
//

#import "XYUserInfoManager.h"
#import "XYHelperMarco.h"

@implementation XYUserInfoManager

+ (instancetype)shareInstance {
    static XYUserInfoManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[XYUserInfoManager alloc] init];
    });
    return manager;
}

/// 获取当前登陆的用户信息
+ (__kindof XYUserBasicModel *)currentLoginUser {
    NSData *userData = [kUserDefaults objectForKey:loginUserCurrent];
    if (!userData) {
        return nil;
    }
    id user = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    if (!user) {
        return nil;
    }
    return user;
}

/// 保存当前登陆用户信息
+ (void)saveCurrentLoginUser:(__kindof XYUserBasicModel *)loginUser {
    if (!loginUser) {
        return;
    }
    
    NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:loginUser];
    
    if (userData) {
        [kUserDefaults setObject:userData forKey:loginUserCurrent];
        [kUserDefaults synchronize];
    }
}

/// 清除登陆用户信息
+ (void)clearCurrentLoginUser {
    [kUserDefaults removeObjectForKey:loginUserCurrent];
    [kUserDefaults synchronize];
}

/// 是否登陆
+ (BOOL)hasSignIn {
    id user = [XYUserInfoManager currentLoginUser];
    return !(user == nil);
}


@end
