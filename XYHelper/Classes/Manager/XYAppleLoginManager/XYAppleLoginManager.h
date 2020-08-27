//
//  XYAppleLoginManager.h
//  XYHelper
//
//  Created by spikeroog on 2019/12/18.
//  Copyright © 2019 spikeroog. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^AppleLoginCompleteHandler)(BOOL successed,NSString * _Nullable user, NSString *_Nullable familyName, NSString *_Nullable givenName, NSString *_Nullable email,NSString *_Nullable password, NSData *_Nullable identityToken, NSData *_Nullable authorizationCode, NSError *_Nullable error, NSString * msg);

typedef void(^AppleLoginObserverHandler)(void);

@interface XYAppleLoginManager : NSObject

+ (instancetype)shared;

+ (UIView *)creatAppleIDAuthorizedButtonWithTarget:(id)target selector:(SEL)selector;

+ (void)checkAuthorizationStateWithUser:(NSString *)user
                         completeHandler:(void(^)(BOOL authorized, NSString *msg))completeHandler;

- (void)loginWithExistingAccount:(AppleLoginCompleteHandler)completeHandler;

- (void)loginWithCompleteHandler:(AppleLoginCompleteHandler)completeHandler;

- (void)startAppleIDObserverWithCompleteHandler:(AppleLoginObserverHandler) handler;

@end

NS_ASSUME_NONNULL_END
