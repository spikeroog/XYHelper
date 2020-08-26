//
//  XYCommentView.h
//  XYHelper
//
//  Created by spikeroog on 2019/11/21.
//  Copyright © 2019 spikeroog. All rights reserved.
//  重置textView的约束记得remakeConstraint
//  评论，回复弹窗，限制输入，弹窗自动顶起，此类作为基类

#import "XYObserverView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^CommentViewDidChangeBlock) (NSString *text);

@interface XYCommentView : XYObserverView
/// 限制输入的最大字数
@property (nonatomic, assign) NSInteger inputNumber;
/// 隐藏限制输入label，默认为NO
@property (nonatomic, assign) BOOL inputLabelHidden;
/// 开发textView，用来remakeConstraint，重新设置位置
@property (nonatomic, strong) UITextView *textView;
/// 最大字数label
@property (nonatomic, strong) UILabel *textNumLabel;
/** cell中textView的输入回调，用以将textView的text赋值进DataSources或VC的model中*/
@property (nonatomic, copy) CommentViewDidChangeBlock textViewDidChangeBlock;

@end

NS_ASSUME_NONNULL_END
