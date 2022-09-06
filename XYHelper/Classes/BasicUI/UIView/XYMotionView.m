//
//  XYMotionView.m
//  XYHelper
//
//  Created by spikeroog on 2022/9/5.
//  Copyright © 2022 spikeroog. All rights reserved.
//

#import "XYMotionView.h"
#import <Masonry/Masonry.h>

@implementation XYMotionView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat offsetValue = 40.f;
        self.clipsToBounds = true;
        _backgroundImageView = [[UIImageView alloc] init];
        _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
        _backgroundImageView.clipsToBounds = true;
        [self addSubview:_backgroundImageView];
        [_backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(-offsetValue, -offsetValue, -offsetValue, -offsetValue));
        }];
        
        UIInterpolatingMotionEffect *motionX = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        UIInterpolatingMotionEffect *motionY = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        motionX.minimumRelativeValue = @(-offsetValue);
        motionX.maximumRelativeValue = @(offsetValue);
        motionY.minimumRelativeValue = @(-offsetValue);
        motionY.maximumRelativeValue = @(offsetValue);
        UIMotionEffectGroup * motionGroup = [[UIMotionEffectGroup alloc] init];
        motionGroup.motionEffects =@[motionX, motionY];
        [_backgroundImageView addMotionEffect:motionGroup];
    } return self;
}

@end
