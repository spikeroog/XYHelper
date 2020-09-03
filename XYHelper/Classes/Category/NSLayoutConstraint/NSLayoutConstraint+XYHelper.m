//
//  NSLayoutConstraint+XYHelper.m
//  MZFBaseFramework
//
//  Created by spikeroog on 2018/12/5.
//  Copyright © 2018 spikeroog. All rights reserved.
//

#import "NSLayoutConstraint+XYHelper.h"
#import "XYHelperMarco.h"
#import "XYScreenAdapter.h"

@implementation NSLayoutConstraint (XYHelper)

- (void)setWidthScreen:(BOOL)widthScreen {
    if (widthScreen) {
        self.constant = kAutoCs(self.constant);
    } else {
        self.constant = self.constant;
    }
}

- (BOOL)widthScreen {
    return self.widthScreen;
}

@end
