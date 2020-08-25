//
//  XYBarItemCustomView.m
//  XYKit
//
//  Created by Xiao Yuen on 2019/11/6.
//  Copyright © 2020 Xiao Yuen. All rights reserved.
//

#import "XYBarItemCustomView.h"

@implementation XYBarItemCustomView


/// Usage，如何使用？
//if (@available(iOS 11.0, *)) { // 适配ios11及以上
//    XYBarItemCustomView *rigBtn...
//    rigBtn.isRight = YES;
//    rigBtn.translatesAutoresizingMaskIntoConstraints = NO;
//    超出 stack view 的部分将无法响应点击事件，只要在 stack view 中添加一个 非 customView 创建的 UIBarButtonItem， 系统就会给我们减少 item 与屏幕间的距离
//    UIBarButtonItem *rigItem = [[UIBarButtonItem alloc] initWithCustomView:rigBtn];
//    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    space.width = -kAutoCs(8);
//    [barItemArrays addObject:space];
//    [barItemArrays addObject:rigItem];
//} else { // 适配ios10及以下
//    UIBarButtonItem *rigItem = [[UIBarButtonItem alloc] initWithCustomView:rigBtn];
//    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    space.width = -kAutoCs(8);
//    [barItemArrays addObject:space];
//    [barItemArrays addObject:rigItem];
//}



/// iOS11及以上，设置这个方法能只能保证 item 距离屏幕的边缘为 8 - 12 pt，如果你想让 item 与屏幕的距离更近一些的话，就可能会出现其他的问题
- (UIEdgeInsets)alignmentRectInsets {
    return _isRight ? UIEdgeInsetsMake(0, -_offset, 0, _offset) : UIEdgeInsetsMake(0, _offset, 0, -_offset);
}



@end
