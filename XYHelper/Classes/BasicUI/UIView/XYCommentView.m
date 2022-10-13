//
//  XYCommentView.m
//  XYHelper
//
//  Created by spikeroog on 2019/11/21.
//  Copyright © 2019 spikeroog. All rights reserved.
//

#import "XYCommentView.h"
#import <Masonry/Masonry.h>
#import <YYCategories/YYCategories.h>
#import "UITextView+XYHelper.h"
#import "UIColor+XYHelper.h"

@interface XYCommentView () <UITextViewDelegate>

@end

@implementation XYCommentView

- (void)setInputNumber:(NSInteger)inputNumber {
    _inputNumber = inputNumber;
    _textNumLabel.text = [NSString stringWithFormat:@"0/%ld", inputNumber];
}

- (void)setInputLabelHidden:(BOOL)inputLabelHidden {
    _inputLabelHidden = inputLabelHidden;
    if (inputLabelHidden) {
        _textNumLabel.hidden = YES;
        _textView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    } else {
        _textNumLabel.hidden = NO;
        _textView.contentInset = UIEdgeInsetsMake(0, 0, kRl(30), 0);
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setCommentViewUpUI];
    }
    return self;
}

/// warning:此方法名不能和子类一样，不然父类子类重名，会先走子类setupui方法再走父类
- (void)setCommentViewUpUI {
    
    self.layer.cornerRadius = kRl(2);
    self.layer.masksToBounds = true;
    
    _textView = [[UITextView alloc] init];
    _textView.placeholder = @"请输入内容";
    _textView.placeholderColor = [UIColor textfieldPlaceholderColor];
    _textView.backgroundColor = kColorWithNull;
    _textView.textColor = kColor333333;
    _textView.font = kFontWithRealsize(15);
    _textView.contentInset = UIEdgeInsetsMake(0, 0, kRl(30), 0);
    _textView.delegate = self;
    [self addSubview:_textView];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kRl(7));
        make.left.equalTo(self).offset(kRl(7));
        make.right.equalTo(self).offset(-kRl(7));
        make.bottom.equalTo(self).offset(-kRl(7));

    }];
    
    _textNumLabel = [[UILabel alloc] init];
    _textNumLabel.text = [NSString stringWithFormat:@"0/%ld", _inputNumber];
    _textNumLabel.font = kFontWithRealsize(15);
    _textNumLabel.textColor = kColor666666;
    _textNumLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_textNumLabel];
    
    [_textNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_textView.mas_bottom).offset(-kRl(10));
        make.right.equalTo(_textView.mas_right).offset(-kRl(10));
    }];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) { // 输入回车
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    
    /*** 限制输入 */
    UITextRange *selectedRange = [textView markedTextRange];
    // 获取高亮部分 中文联想
    UITextPosition *posi = [textView positionFromPosition:selectedRange.start offset:0];
    
    // 如果在变化中是高亮部分在变，就不要计算字符
    if (selectedRange && posi) {
        return;
    }
    
    // 实际总长度
    NSInteger realLength = textView.text.length;
    NSRange selection = textView.selectedRange;
    //    NSString *headText = [textView.text substringToIndex:selection.location];   // 光标前的文本
    NSString *tailText = [textView.text substringFromIndex:selection.location]; // 光标后的文本
    NSInteger restLength = _inputNumber - tailText.length;                     // 光标前允许输入的最大数量
    
    if (realLength > _inputNumber) {
        // 解决半个emoji 定位到index位置时，返回在此位置的完整字符的range
        NSRange range = [textView.text rangeOfComposedCharacterSequenceAtIndex:restLength];
        NSString *subHeadText = [textView.text substringToIndex:range.location];
        
        // NSString *subHeadText = [headText substringToIndex:restLength];
        textView.text = [subHeadText stringByAppendingString:tailText];
        [textView setSelectedRange:NSMakeRange(restLength, 0)];
        // 解决粘贴过多之后，撤销粘贴 崩溃问题 —— 不会出现弹框
        [textView.undoManager removeAllActions];
    } else {
        !_textViewDidChangeBlock ? : _textViewDidChangeBlock(_textView.text);
    }
    self.textNumLabel.text = [NSString stringWithFormat:@"%ld/%ld", textView.text.length, _inputNumber];
}

@end
