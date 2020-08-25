//
//  NSLayoutConstraint+AutoLayout.m
//  MZFBaseFramework
//
//  Created by Xiao Yuen on 2018/12/5.
//  Copyright © 2018 Xiao Yuen. All rights reserved.
//

#import "NSLayoutConstraint+AutoLayout.h"
#import "XYHelper.h"

@implementation NSLayoutConstraint (AutoLayout)

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
