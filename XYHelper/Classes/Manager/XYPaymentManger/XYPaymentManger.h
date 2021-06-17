//
//  XYPaymentManger.h
//  lwapp
//
//  Created by spikeroog on 2018/6/22.
//  Copyright © 2018年 spikeroog. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import "PPNetworkHelper.h"
#import "MBProgressHUD+XYHelper.h"
#import "XYHelperMarco.h"

@interface XYPaymentManger : NSObject <SKPaymentTransactionObserver, SKProductsRequestDelegate>

@property NSString *productIdIng;
@property NSString *userdataIng;

+ (XYPaymentManger *)sharedHelper;
- (void)initIAPHelper;
- (void)requestProductData:(NSString *)productId userdata:(NSString *)userdata;

@end
