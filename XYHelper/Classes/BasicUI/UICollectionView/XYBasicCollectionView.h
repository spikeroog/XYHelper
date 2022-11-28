//
//  XYBasicCollectionView.h
//  XYHelper
//
//  Created by spikeroog on 2022/11/23.
//  Copyright © 2022 spikeroog. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

typedef void(^XYCollectionViewEmptyViewClickBlock) ();

NS_ASSUME_NONNULL_BEGIN

@interface XYBasicCollectionView : UICollectionView
@property (nonatomic, copy) XYCollectionViewEmptyViewClickBlock collectionViewEmptyViewClickBlock;

@end

NS_ASSUME_NONNULL_END
