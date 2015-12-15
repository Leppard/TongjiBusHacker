//
//  TJBusRouteTableViewCell.m
//  TongjiBusHacker
//
//  Created by Leppard on 12/14/15.
//  Copyright © 2015 Leppard. All rights reserved.
//

#import "TJBusRouteDetailCell.h"
#import <Masonry.h>

static NSString *const kTJBusRouteID   = @"bus_id";
static NSString *const kTJBusRouteTime = @"time";
static NSString *const kTJBUsRouteLine = @"line";
static NSString *const kTJBusRouteRest = @"rest";

@interface TJBusRouteDetailCell ()

@property (nonatomic, strong) NSString *busID;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *line;
@property (nonatomic, strong) NSString *rest;

@property (nonatomic, strong) UILabel *lineInfo;
@property (nonatomic, strong) UILabel *timeInfo;
@property (nonatomic, strong) UILabel *restInfo;

@end

@implementation TJBusRouteDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpViewsWithConstraints];
    }
    return self;
}

- (void)setUpRoute:(NSDictionary *)dictionary
{
    _busID = @"";
    _time  = @"";
    _line  = @"";
    _rest  = @"";
    if ([dictionary objectForKey:kTJBusRouteID]) {
        _busID = [dictionary objectForKey:kTJBusRouteID];
    }
    if ([dictionary objectForKey:kTJBusRouteTime]) {
        _time = [dictionary objectForKey:kTJBusRouteTime];
    }
    if ([dictionary objectForKey:kTJBUsRouteLine]) {
        _line = [dictionary objectForKey:kTJBUsRouteLine];
    }
    if ([dictionary objectForKey:kTJBusRouteRest]) {
        _rest = [dictionary objectForKey:kTJBusRouteRest];
    }
    
    [self updateLabelText];
}

- (void)updateLabelText
{
    self.lineInfo.text = [NSString stringWithFormat:@"线路：%@", _line];
    self.timeInfo.text = [NSString stringWithFormat:@"时间：%@", _time];
    self.restInfo.text = [NSString stringWithFormat:@"余票：%@", _rest];
}

- (void)setUpViewsWithConstraints
{
    [self.contentView addSubview:self.timeInfo];
    [self.contentView addSubview:self.lineInfo];
    [self.contentView addSubview:self.restInfo];
    
    [self.lineInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@30);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.top.equalTo(self.contentView.mas_top).offset(10);
    }];
    [self.timeInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@20);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
    [self.restInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@20);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
}

#pragma mark - setters & getters

- (UILabel *)lineInfo
{
    if (!_lineInfo) {
        _lineInfo = [[UILabel alloc] init];
        _lineInfo.font = [UIFont systemFontOfSize:18];
    }
    return _lineInfo;
}

- (UILabel *)timeInfo
{
    if (!_timeInfo) {
        _timeInfo = [[UILabel alloc] init];
        _timeInfo.font = [UIFont systemFontOfSize:14];
        _timeInfo.textColor = [UIColor darkGrayColor];
    }
    return _timeInfo;
}

- (UILabel *)restInfo
{
    if (!_restInfo) {
        _restInfo = [[UILabel alloc] init];
        _restInfo.font = [UIFont systemFontOfSize:14];
        _restInfo.textColor = [UIColor darkGrayColor];
    }
    return _restInfo;
}

@end
