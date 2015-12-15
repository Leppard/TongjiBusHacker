//
//  TJBusLineInfoCell.m
//  TongjiBusHacker
//
//  Created by Leppard on 12/14/15.
//  Copyright © 2015 Leppard. All rights reserved.
//

#import "TJBusLineInfoCell.h"
#import <Masonry.h>

@interface TJBusLineInfoCell ()

@property (nonatomic, strong) UILabel *fromLocation;
@property (nonatomic, strong) UILabel *connectLabel;
@property (nonatomic, strong) UILabel *toLocation;

@end

@implementation TJBusLineInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpViewsWithConstraints];
    }
    return self;
}

#pragma mark - private methods

- (void)setUpViewsWithConstraints
{
    [self.contentView addSubview:self.fromLocation];
    [self.contentView addSubview:self.toLocation];
    [self.contentView addSubview:self.connectLabel];

    [self.fromLocation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@30);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.connectLabel.mas_left).offset(-10);
    }];
    [self.connectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@30);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.centerX.equalTo(self.contentView.mas_centerX);
    }];
    [self.toLocation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@30);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.connectLabel.mas_right).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
    }];
}

- (void)setUpTitleFromLocation:(NSString *)fromLocation to:(NSString *)toLocation
{
    if (fromLocation && [fromLocation isKindOfClass:([NSString class])]) {
        self.fromLocation.text = fromLocation;
    }
    if (toLocation && [toLocation isKindOfClass:([NSString class])]) {
        self.toLocation.text = toLocation;
    }
}

#pragma mark - getters & setters

- (UILabel *)fromLocation
{
    if (!_fromLocation) {
        _fromLocation = [[UILabel alloc] init];
        _fromLocation.font = [UIFont systemFontOfSize:20];
        _fromLocation.textAlignment = NSTextAlignmentRight;
        _fromLocation.text = @"";
    }
    return _fromLocation;
}

- (UILabel *)connectLabel
{
    if (!_connectLabel) {
        _connectLabel = [[UILabel alloc] init];
        _connectLabel.textColor = [UIColor darkGrayColor];
        _connectLabel.font = [UIFont systemFontOfSize:14];
        _connectLabel.textAlignment = NSTextAlignmentCenter;
        _connectLabel.text = @"到";
    }
    return _connectLabel;
}

- (UILabel *)toLocation
{
    if (!_toLocation) {
        _toLocation = [[UILabel alloc] init];
        _toLocation.font = [UIFont systemFontOfSize:20];
        _toLocation.textAlignment = NSTextAlignmentLeft;
        _toLocation.text = @"";
    }
    return _toLocation;
}

@end