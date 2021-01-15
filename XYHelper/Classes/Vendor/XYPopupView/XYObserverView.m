//
//  XYObserverView.m
//  XYHelper
//
//  Created by spikeroog on 2019/8/28.
//  Copyright © 2019年 spikeroog. All rights reserved.
//

#import "XYObserverView.h"
#import "UIView+XYPop.h"
#import "UIView+XYHelper.h"
#import "XYHelperMarco.h"
#import "XYScreenAdapter.h"

@implementation XYObserverView

- (void)dealloc {
    @try {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    }
    @catch (NSException *exception) {
        NSLog(@"多次删除了");
    }
}

//这个方法相当于vc中的viewDidLoad
- (void)didMoveToWindow {
    if (self.window) {
        if (self.xy_y > kScreenHeight) {
            self.myOriginY = self.xy_y-self.xy_size.height*2;
        } else {
            self.myOriginY = self.xy_y;
        }
        @try {
            // 添加通知监听见键盘弹出/退出
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAction:) name:UIKeyboardWillShowNotification object:nil];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAction:) name:UIKeyboardWillHideNotification object:nil];
        }
        @catch (NSException *exception) {
            NSLog(@"多次添加了");
        }
    }
}

- (void)keyboardAction:(NSNotification *)sender {
    // 通过通知对象获取键盘frame: [value CGRectValue]
    NSDictionary *useInfo = [sender userInfo];
    CGRect beginUserRect = [[useInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    if (beginUserRect.size.height <= 0) {
        /**
         搜狗输入法弹出时会发出三次UIKeyboardWillShowNotification的通知,
         和官方输入法相比,
         有效的一次为dUIKeyboardFrameBeginUserInfoKey.size.height都大于零时.
         */
        return;
    }
    CGRect endUserRect = [[useInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // <注意>具有约束的控件通过改变约束值进行frame的改变处理
    CGFloat duration = [sender.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    if ([sender.name isEqualToString:UIKeyboardWillShowNotification]) {

        CGFloat transformY = endUserRect.origin.y-self.xy_size.height;

        [UIView animateWithDuration:duration animations:^{
            self.frame = CGRectMake(self.xy_origin.x, transformY, self.xy_size.width, self.xy_size.height);
            [self layoutIfNeeded];
        }];
       
        
    } else {
        
        [UIView animateWithDuration:duration animations:^{
            self.frame = CGRectMake(self.xy_origin.x, self.myOriginY, self.xy_size.width, self.xy_size.height);
            [self layoutIfNeeded];
        }];
        
    }
}



//从当前window删除 相当于-viewDidUnload
- (void)willMoveToWindow:(UIWindow *)newWindow {
    [super willMoveToWindow:newWindow];
    
    if (newWindow == nil) {
        // 注意这里不要移除改界面所有的通知，可能有的通知我们还需要使用
        @try {
            [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
            [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
        }
        @catch (NSException *exception) {
            NSLog(@"多次删除了");
        }
    }
}

@end
