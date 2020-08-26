//
//  XYCollectionViewFlowLayout.h
//  XYKit
//
//  Created by spikeroog on 2019/11/5.
//  Copyright © 2019 spikeroog. All rights reserved.
//  头部悬停效果。CollectionView设置headerView，一行代码flowlayout.naviHeight = ISiPhoneX?88:64; 即可实现headerView悬停效果

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYCollectionViewFlowLayout : UICollectionViewFlowLayout

//默认为64.0, default is 64.0
@property (nonatomic, assign) CGFloat naviHeight;

@end

NS_ASSUME_NONNULL_END
