//
//  KCExploreInformationCell.m
//  KYMCOCloud
//
//  Created by spikeroog on 2022/10/18.
//  Copyright © 2022 KYMCO. All rights reserved.
//

#import "KCExploreInformationCell.h"


@interface KCExploreInformationCell ()
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIImageView *imageV;

@property (nonatomic, strong) UIButton *lookBtn;
@property (nonatomic, strong) UILabel *lookLab;

@property (nonatomic, strong) UIButton *shareBtn;
@property (nonatomic, strong) UILabel *shareLab;

@property (nonatomic, strong) UIButton *collectBtn;
@property (nonatomic, strong) UILabel *collectLab;

@property (nonatomic, strong) UIButton *likeBtn;
@property (nonatomic, strong) UILabel *likeLab;



@end

@implementation KCExploreInformationCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    _titleLab = [UILabel ui_labelWithTitle:@"KYMCO光阳电动与速珂携手，智能化强势出击。KYMCO光阳电动与速珂携手，智能化强势出击。智能化强势出击。" color:kColor333333 font:kFontWithRealsizeBold(15)];
    _titleLab.textAlignment = NSTextAlignmentLeft;
    _titleLab.numberOfLines = 0;
    [self.contentView addSubview:_titleLab];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(kRl(20));
        make.right.equalTo(self.contentView).offset(-kRl(20));
        make.top.equalTo(self.contentView);
    }];
    
    _imageV = [UIImageView ui_imageViewWithImageName:@"AppIcon_1024" cornerRadius:4 contentMode:2];
    [self.contentView addSubview:_imageV];
    [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLab.mas_bottom).offset(kRl(14));
        make.height.offset(kRl(201));
        make.left.equalTo(self.contentView).offset(kRl(20));
        make.right.equalTo(self.contentView).offset(-kRl(20));
    }];
    
    _lookBtn = [UIButton ui_buttonWithTitle:nil imageName:@"AppIcon_1024" target:self action:@selector(lookBtnAct:)];
    [_lookBtn setEnlargeEdge:kRl(10)];
    _lookBtn.imageView.contentMode = 1;
    [self.contentView addSubview:_lookBtn];
    [_lookBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageV.mas_bottom).offset(kRl(19));
        make.width.height.offset(kRl(14));
        make.left.equalTo(_imageV);
        make.bottom.equalTo(self.contentView).offset(-kRl(17));
    }];
    
    _lookLab = [UILabel ui_labelWithTitle:@"100000" color:kColorBBBBBB font:kFontWithRealsize(12)];
    [self.contentView addSubview:_lookLab];
    [_lookLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_lookBtn.mas_right).offset(kRl(3));
        make.centerY.equalTo(_lookBtn);
    }];
    
    _likeLab = [UILabel ui_labelWithTitle:@"100000" color:kColorBBBBBB font:kFontWithRealsize(12)];
    [self.contentView addSubview:_likeLab];
    [_likeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-kRl(20));
        make.centerY.equalTo(_lookBtn);
    }];
    
    _likeBtn = [UIButton ui_buttonWithTitle:nil imageName:@"AppIcon_1024" target:self action:@selector(likeBtnAct:)];
    [_likeBtn setEnlargeEdge:kRl(10)];
    _likeBtn.imageView.contentMode = 1;
    [self.contentView addSubview:_likeBtn];
    [_likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_lookBtn);
        make.width.height.offset(kRl(14));
        make.right.equalTo(_likeLab.mas_left).offset(-kRl(3));
    }];
    
    _collectLab = [UILabel ui_labelWithTitle:@"100000" color:kColorBBBBBB font:kFontWithRealsize(12)];
    [self.contentView addSubview:_collectLab];
    [_collectLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_likeBtn.mas_left).offset(-kRl(10));
        make.centerY.equalTo(_lookBtn);
    }];
    
    _collectBtn = [UIButton ui_buttonWithTitle:nil imageName:@"AppIcon_1024" target:self action:@selector(collectBtnAct:)];
    [_collectBtn setEnlargeEdge:kRl(10)];
    _collectBtn.imageView.contentMode = 1;
    [self.contentView addSubview:_collectBtn];
    [_collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_lookBtn);
        make.width.height.offset(kRl(14));
        make.right.equalTo(_collectLab.mas_left).offset(-kRl(3));
    }];
    
    _shareLab = [UILabel ui_labelWithTitle:@"100000" color:kColorBBBBBB font:kFontWithRealsize(12)];
    [self.contentView addSubview:_shareLab];
    [_shareLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_collectBtn.mas_left).offset(-kRl(10));
        make.centerY.equalTo(_lookBtn);
    }];
    
    _shareBtn = [UIButton ui_buttonWithTitle:nil imageName:@"AppIcon_1024" target:self action:@selector(shareBtnAct:)];
    [_shareBtn setEnlargeEdge:kRl(10)];
    _shareBtn.imageView.contentMode = 1;
    [self.contentView addSubview:_shareBtn];
    [_shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_lookBtn);
        make.width.height.offset(kRl(14));
        make.right.equalTo(_shareLab.mas_left).offset(-kRl(3));
    }];
    
    UIView *threadView = [[UIView alloc] init];
    threadView.backgroundColor = kColorWithRGB16Radix(0xF5F5F5);
    [self.contentView addSubview:threadView];
    [threadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(kRl(20));
        make.right.equalTo(self.contentView).offset(-kRl(20));
        make.bottom.equalTo(self.contentView).offset(-kRl(1));
        make.height.offset(kRl(1));
    }];
}

#pragma mark - Action
- (void)lookBtnAct:(UIButton *)sender {
    
}

- (void)shareBtnAct:(UIButton *)sender {
    
}

- (void)collectBtnAct:(UIButton *)sender {
    
}

- (void)likeBtnAct:(UIButton *)sender {
    
}

@end
