//
//  KCExploreInformationViewController.m
//  KYMCOCloud
//
//  Created by spikeroog on 2022/9/13.
//  Copyright © 2022 KYMCO. All rights reserved.
//

#import "KCExploreInformationViewController.h"
#import "KCExploreInformationCell.h"

@interface KCExploreInformationViewController ()

@end

@implementation KCExploreInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUi];
}

- (void)setUpUi {
    
    self.navBarHidden = true;
    
    [self registerClassWithName:KCExploreInformationCell.className];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    KCExploreInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:KCExploreInformationCell.className];
        
    cell.accessoryType = UITableViewCellAccessoryNone;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


@end
