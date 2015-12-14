//
//  TJBusRouteTableViewCell.m
//  TongjiBusHacker
//
//  Created by Leppard on 12/14/15.
//  Copyright © 2015 Leppard. All rights reserved.
//

#import "TJBusRouteDetailCell.h"

static NSString *const kTJBusRouteID   = @"kTJBusRouteID";
static NSString *const kTJBusRouteTime = @"kTJBusRouteTime";
static NSString *const kTJBUsRouteLine = @"kTJBusRouteLine";
static NSString *const kTJBusRouteRest = @"kTJBusRouteRest";

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

- (instancetype)initWithDictionary:(NSDictionary *)dictionary reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpRoute:dictionary];
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
}

- (void)setUpViewsWithConstraints
{
    [self addSubview:self.timeInfo];
    [self addSubview:self.lineInfo];
    [self addSubview:self.restInfo];
    
    
    
}

#pragma mark - setters & getters

- (UILabel *)lineInfo
{
    if (!_lineInfo) {
        _lineInfo = [[UILabel alloc] init];
        _lineInfo.font = [UIFont systemFontOfSize:20];
    }
    return _lineInfo;
}

- (UILabel *)timeInfo
{
    if (!_timeInfo) {
        _timeInfo = [[UILabel alloc] init];
        _timeInfo.font = [UIFont systemFontOfSize:12];
    }
    return _timeInfo;
}

- (UILabel *)restInfo
{
    if (!_restInfo) {
        _restInfo = [[UILabel alloc] init];
        _restInfo.font = [UIFont systemFontOfSize:12];
    }
    return _restInfo;
}

@end
