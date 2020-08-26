//
//  WeakWebViewScriptMessageDelegate.h
//  XYHelper
//
//  Created by spikeroog on 2019/9/16.
//  Copyright © 2019年 spikeroog. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

// WKWebView引入js方法，导致内存不释放的解决方案
@interface WeakWebViewScriptMessageDelegate : NSObject
<WKScriptMessageHandler>

//WKScriptMessageHandler 这个协议类专门用来处理JavaScript调用原生OC的方法
@property (nonatomic, weak) id<WKScriptMessageHandler> scriptDelegate;

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate;

@end

NS_ASSUME_NONNULL_END
