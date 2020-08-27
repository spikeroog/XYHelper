// 通过Runtime为UITextView添加占位文字placeholder(支持Xib) eg: 在xib的User Defined Runtime Attributes的keyPath中设置 placeholderColor (Color)还有 placeholder (String) 还有TextView下对应输入一样的placeholderColor和placeholder 即可生效

#if __has_feature(modules)
@import UIKit;
#else
#import <UIKit/UIKit.h>
#endif

FOUNDATION_EXPORT double UITextView_PlaceholderVersionNumber;
FOUNDATION_EXPORT const unsigned char UITextView_PlaceholderVersionString[];

@interface UITextView (XYHelper)

@property (nonatomic, readonly) UITextView *placeholderTextView NS_SWIFT_NAME(placeholderTextView);

@property (nonatomic, strong) IBInspectable NSString *placeholder;
@property (nonatomic, strong) NSAttributedString *attributedPlaceholder;
@property (nonatomic, strong) IBInspectable UIColor *placeholderColor;

+ (UIColor *)defaultPlaceholderColor;

@end
