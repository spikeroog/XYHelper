//
//  XYHomePagingSubViewController.m
//  XYHelper
//
//  Created by spikeroog on 2022/11/23.
//  Copyright © 2022 spikeroog. All rights reserved.
//

#import "XYHomePagingSubViewController.h"

@interface XYHomePagingSubViewController ()
@property (nonatomic, copy) void(^scrollCallback)(UIScrollView *scrollView);

@end

@implementation XYHomePagingSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerClassWithName:@"UITableViewCell"];
    
    if (self.categoryViewHeight == 0) {
        self.categoryViewHeight = 44;
    }
    
    if (self.isHomepageStyle == false) {
        [self.basicTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.view);
            make.bottom.equalTo(self.view).offset(-self.categoryViewHeight-self.categoryViewYOffset-kNavBarHeight).priorityLow();
        }];
    } else {
        [self.basicTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }

}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    !self.scrollCallback ?: self.scrollCallback(scrollView);
}

#pragma mark - JXPagingViewListViewDelegate

- (UIView *)listView {
    return self.view;
}

- (UIScrollView *)listScrollView {
    return self.basicTableView;
}

- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
    self.scrollCallback = callback;
}

- (void)listWillAppear {
//    NSLog(@"%@:%@", self.title, NSStringFromSelector(_cmd));
}

- (void)listDidAppear {
//    NSLog(@"%@:%@", self.title, NSStringFromSelector(_cmd));
}

- (void)listWillDisappear {
//    NSLog(@"%@:%@", self.title, NSStringFromSelector(_cmd));
}

- (void)listDidDisappear {
//    NSLog(@"%@:%@", self.title, NSStringFromSelector(_cmd));
}


@end
