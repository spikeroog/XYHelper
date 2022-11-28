//
//  XYBasicTableView.h
//  XYHelper
//
//  Created by spikeroog on 2022/11/23.
//  Copyright © 2022 spikeroog. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

typedef void(^XYTableViewEmptyViewClickBlock) ();

NS_ASSUME_NONNULL_BEGIN

@interface XYBasicTableView : UITableView
@property (nonatomic, copy) XYTableViewEmptyViewClickBlock tableViewEmptyViewClickBlock;

@end

NS_ASSUME_NONNULL_END
