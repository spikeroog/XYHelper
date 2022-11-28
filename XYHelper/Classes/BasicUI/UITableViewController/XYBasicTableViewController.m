//
//  XYBasicTableViewController.m
//  XYHelper
//
//  Created by spikeroog on 2022/11/23.
//  Copyright © 2022 spikeroog. All rights reserved.
//

#import "XYBasicTableViewController.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import <Masonry/Masonry.h>
#import "XYMJRefreshManager.h"
#import "XYHelperMarco.h"

@interface XYBasicTableViewController ()
<UITableViewDelegate,
UITableViewDataSource,
DZNEmptyDataSetSource,
DZNEmptyDataSetDelegate>
@property (nonatomic, strong) XYMJRefreshManager *freshM;

@end

@implementation XYBasicTableViewController

/// 配置
/// @param need 头部尾部视图高度是否自适应
- (void)estimatedSectionHeaderFooterHeight:(BOOL)need {
    if (need) {
        _basicTableView.sectionHeaderHeight = UITableViewAutomaticDimension;
        _basicTableView.sectionFooterHeight = UITableViewAutomaticDimension;
        _basicTableView.estimatedSectionFooterHeight = 100;
        _basicTableView.estimatedSectionHeaderHeight = 100;
    } else {
        _basicTableView.sectionHeaderHeight = 0.01f;
        _basicTableView.sectionFooterHeight = 0.01f;
        _basicTableView.estimatedSectionFooterHeight = 0.01f;
        _basicTableView.estimatedSectionHeaderHeight = 0.01f;
    }
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setbasicTableViewControllerUpUI];
    
    [self estimatedSectionHeaderFooterHeight:false];
    
    if (_isNeedRefresh) {
        self.freshM = [[XYMJRefreshManager alloc] init];
        @weakify(self);
        [self.freshM initialMJHeaderWithTargetView:self.basicTableView pullDownCallBack:^{
            @strongify(self);
            !self.headerHandler ? : self.headerHandler();
        }];
        
        [self.freshM initialMJFooterWithTargetView:self.basicTableView pullUpCallBack:^{
            !self.footerHandler ? : self.footerHandler();
        }];
        
    } else {
        self.freshM = nil;
    }
}

/// warning:此方法名不能和子类一样，不然父类子类重名，会先走子类setUpUI方法再走父类
- (void)setbasicTableViewControllerUpUI {
    
    _basicTableView = [[XYBasicTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    
    if (@available(iOS 11.0, *)) {
        _basicTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    if (@available(iOS 15.0, *)) {
        _basicTableView.sectionHeaderTopPadding = 0;
    }
    
    _basicTableView.rowHeight = UITableViewAutomaticDimension;
    _basicTableView.estimatedRowHeight = 100;
    _basicTableView.delegate = self;
    _basicTableView.dataSource = self;
    _basicTableView.backgroundColor = UIColor.whiteColor;
    /// 去掉分割线
    _basicTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    /// 去掉滑动条
    _basicTableView.showsVerticalScrollIndicator = false;
    _basicTableView.showsHorizontalScrollIndicator = false;
    /// 滑动cell收起键盘
    _basicTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    [self.view addSubview:_basicTableView];
    
    [_basicTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

}

- (void)reloadSection:(NSInteger)index {
    [self.basicTableView reloadSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)registerClassWithName:(NSString *)className {
    [self.basicTableView registerClass:NSClassFromString(className) forCellReuseIdentifier:className];
}

- (void)registerHeaderFooterWithName:(NSString *)headerfooterName {
    [self.basicTableView registerClass:NSClassFromString(headerfooterName) forHeaderFooterViewReuseIdentifier:headerfooterName];
}

#pragma mark - NSObject
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

@end
