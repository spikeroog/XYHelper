//
//  LWIAPHelper.m
//  lwapp
//
//  Created by 路 on 2018/6/22.
//  Copyright © 2018年 路. All rights reserved.
//

#import "XYPaymentManger.h"

@implementation XYPaymentManger

+(XYPaymentManger *)sharedHelper {
    static XYPaymentManger *sharedIAPHelper = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate,^{
        sharedIAPHelper = [[self alloc] init];
    });
    return sharedIAPHelper;
}

- (void)initIAPHelper {
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
}

// 内购-去苹果服务器请求产品信息
- (void)requestProductData:(NSString *)productId userdata:(NSString*)userdata {
    if ([SKPaymentQueue canMakePayments]) {
        kLog(@"用户允许内购");
        NSArray *productArr = [[NSArray alloc]initWithObjects:productId, nil];
        NSSet *productSet = [NSSet setWithArray:productArr];
        SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:productSet];
        request.delegate = self;
        self.productIdIng = productId;
        self.userdataIng = userdata;
        [MBProgressHUD showSimpleHUD:false];
        [request start];
    } else {
        [MBProgressHUD showTextHUD:@"不允许内购"];
    }
}

//内购-收到产品返回信息
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    [MBProgressHUD removeLoadingHud];
    NSArray *productArr = response.products;
    if ([productArr count] == 0) {
        kLog(@"没有该商品");
        [MBProgressHUD showTextHUD:@"未查找到商品信息"];
        return;
    }
    
    kLog(@"productId = %@", response.invalidProductIdentifiers);
    kLog(@"产品付费数量 = %zd", productArr.count);
    
    SKProduct *p = nil;
    for (SKProduct *pro in productArr) {
        kLog(@"description:%@", [pro description]);
        kLog(@"localizedTitle:%@", [pro localizedTitle]);
        kLog(@"localizedDescription:%@", [pro localizedDescription]);
        kLog(@"price:%@", [pro price]);
        kLog(@"productIdentifier:%@", [pro productIdentifier]);
        if ([pro.productIdentifier isEqualToString:self.productIdIng]) {
            p = pro;
        }
    }
    
    SKPayment *payment = [SKPayment paymentWithProduct:p];
    
    //发送内购请求
    [MBProgressHUD showSimpleHUD:false];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

- (void)requestDidFinish:(SKRequest *)request {
    [MBProgressHUD removeLoadingHud];
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error {
    kLog(@"支付失败");
    [MBProgressHUD removeLoadingHud];
    [MBProgressHUD showTextHUD:@"支付失败"];
}

// 内购-监听购买结果
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray<SKPaymentTransaction *> *)transactions {
    [MBProgressHUD removeLoadingHud];
    for (SKPaymentTransaction *tran in transactions) {
        switch (tran.transactionState) {
            case SKPaymentTransactionStatePurchased: {
                //交易完成，通知去接口校验支付凭证
                NSURL *receiptURL = [[NSBundle mainBundle] appStoreReceiptURL];
                NSData *receiptData = [NSData dataWithContentsOfURL:receiptURL];
                NSString *receiptDataStr = [receiptData base64EncodedStringWithOptions:0];
                
                //TODO:如果是之前未完成的单子需要延时校验，这里偷懒返回可能导致掉单情况
//                if ([LWUserManager sharedInstance] == nil || self.productIdIng == nil) {
//                    [[SKPaymentQueue defaultQueue] finishTransaction:tran];
//                    return;
//                }
                
                //去服务器校验
                NSDictionary *params = @{@"user_id":@"",
                                         @"productid":self.productIdIng,
                                         @"receipt_data":receiptDataStr,
                                         @"payee_id":self.userdataIng,
                                         @"channel_id":@"",
                                         @"appVersion":kAppVersion,
                                         @"appBuild":kBuildVersion,
                                         @"systemVersion":@(kSystemVersion).stringValue,
                                         @"device_ios_Type":@""
                                         };
                [PPNetworkHelper POST:@"" parameters:params success:^(id responseObject) {
                    if (responseObject[@"code"] == 0) {
                        [MBProgressHUD showTextHUD:@"购买成功"];
                        //通知刷新余额
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"updateBalance" object:nil];
                    } else {
                        [MBProgressHUD showTextHUD:@"购买失败"];
                    }
                } failure:^(NSError *error) {
                    [MBProgressHUD showTextHUD:@"请求失败，请稍后重试"];
                }];
                
                [[SKPaymentQueue defaultQueue] finishTransaction:tran];
                break;
            }
            case SKPaymentTransactionStatePurchasing:   //商品添加进列表
                break;
            case SKPaymentTransactionStateRestored:     //购买过
                // 发送到苹果服务器验证凭证
                [[SKPaymentQueue defaultQueue] finishTransaction:tran];
                break;
            case SKPaymentTransactionStateFailed: {
                [[SKPaymentQueue defaultQueue] finishTransaction:tran];
                // 购买失败
                [MBProgressHUD showTextHUD:@"购买失败，如有疑问请联系客服"];
                break;
            }
            default:
                break;
        }
    }
}

@end
