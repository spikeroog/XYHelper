//
//  UIImage+Nonprint.m
//  KYMCOCloud
//
//  Created by 杭州英捷鑫科技 on 2022/9/14.
//  Copyright © 2022 KYMCO. All rights reserved.
//

#import "UIImage+Nonprint.h"
#import "XYHelperUtils.h"
#import <objc/runtime.h>

@implementation UIImage (Nonprint)

+ (void)load {
    Method imageNamed = class_getClassMethod(self,@selector(imageNamed:));
    Method foo_ImageNamed = class_getClassMethod(self,@selector(foo_nonprint_imageNamed:));
    method_exchangeImplementations(imageNamed, foo_ImageNamed);
}

+ (instancetype)foo_nonprint_imageNamed:(NSString*)name {
    
    if (![XYHelperUtils isNull:name]) {
        
        return  [self foo_nonprint_imageNamed:name];
        
    } else {
        
        return nil;
    }
}

@end
