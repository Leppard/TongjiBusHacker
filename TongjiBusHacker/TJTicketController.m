//
//  TJTicketController.m
//  TongjiBusHacker
//
//  Created by Leppard on 12/15/15.
//  Copyright © 2015 Leppard. All rights reserved.
//

#import "TJTicketController.h"
#import <Masonry.h>

@interface TJTicketController ()

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *identity; // 学号
@property (nonatomic, strong) NSString *from;
@property (nonatomic, strong) NSString *to;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *detail; // 线路信息

@property (nonatomic, strong) UIImageView *titleImage;
@property (nonatomic, strong) UIImageView *mainImage;
@property (nonatomic, strong) UIImageView *trackBGImage;

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *idLabel;
@property (nonatomic, strong) UILabel *dateAndTimeLabel;
@property (nonatomic, strong) UILabel *fromWhereLabel;
@property (nonatomic, strong) UILabel *toWhereLabel;
@property (nonatomic, strong) UILabel *detailLabel;

@end

@implementation TJTicketController

#pragma mark - life cycle

- (instancetype)initWithRouteDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        [self configureRouteByDictionary:dictionary];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _fromWhereLabel   = [self setUpLabelWithText:self.from];
    self.toWhereLabel = [self setUpLabelWithText:self.to];
    self.detailLabel  = [self setUpLabelWithText:self.detail];
    [self setUpViewsWithConstraints];
}

#pragma mark - private methods

- (void)configureRouteByDictionary:(NSDictionary *)dictionary
{
    _name = @"";
    _identity = @"";
    _from = @"";
    _to = @"";
    _time = @"";
    _date = @"";
    _detail = @"";
    if ([dictionary objectForKey:kTJTicketName]) {
        _name = [dictionary objectForKey:kTJTicketName];
    }
    if ([dictionary objectForKey:kTJTicketIdentity]) {
        _identity = [dictionary objectForKey:kTJTicketIdentity];
    }
    if ([dictionary objectForKey:kTJTicketFrom]) {
        _from = [dictionary objectForKey:kTJTicketFrom];
    }
    if ([dictionary objectForKey:kTJTicketTo]) {
        _to = [dictionary objectForKey:kTJTicketTo];
    }
    if ([dictionary objectForKey:kTJTicketTime]) {
        _time = [dictionary objectForKey:kTJTicketTime];
    }
    if ([dictionary objectForKey:kTJTicketDate]) {
        _date = [dictionary objectForKey:kTJTicketDate];
    }
    if ([dictionary objectForKey:kTJTicketDetail]) {
        _detail = [dictionary objectForKey:kTJTicketDetail];
    }
}

- (void)setUpViewsWithConstraints
{
    [self.view addSubview:self.nameLabel];
    [self.view addSubview:self.titleImage];
    
    [self.titleImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@55);
        make.width.equalTo(self.view.mas_width);
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(24);
    }];
    
    [self setUpPersonalInfoViews];
    [self setUpBusInfoViews];
    [self setUpAnimationViews];
}

- (void)setUpPersonalInfoViews
{
    [self.view addSubview:self.nameLabel];
    [self.view addSubview:self.idLabel];
    [self.view addSubview:self.dateAndTimeLabel];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@25);
        make.top.equalTo(self.titleImage.mas_bottom).offset(9);
        make.left.equalTo(self.view.mas_left).offset(94);
    }];
    [self.idLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@25);
        make.centerY.equalTo(self.nameLabel.mas_centerY);
        make.right.equalTo(self.view.mas_right).offset(-87);
    }];
    [self.dateAndTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@18);
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(13);
    }];
}

- (void)setUpBusInfoViews
{
    [self.view addSubview:self.fromWhereLabel];
    [self.view addSubview:self.toWhereLabel];
    [self.view addSubview:self.trackBGImage];
    [self.view addSubview:self.detailLabel];
    [self.view addSubview:self.mainImage];
    
    [self.fromWhereLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@18);
        make.width.equalTo(@40);
        make.top.equalTo(self.dateAndTimeLabel.mas_bottom).offset(66);
        make.left.equalTo(self.view.mas_left).offset(40);
    }];
    [self.toWhereLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@18);
        make.width.equalTo(@40);
        make.centerY.equalTo(self.fromWhereLabel.mas_centerY);
        make.right.equalTo(self.view.mas_right).offset(-32);
    }];
    [self.trackBGImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@11);
        make.centerY.equalTo(self.fromWhereLabel.mas_centerY);
        make.left.equalTo(self.fromWhereLabel.mas_right).offset(16);
        make.right.equalTo(self.toWhereLabel.mas_left).offset(-10);
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@18);
        make.top.equalTo(self.fromWhereLabel.mas_bottom).offset(8);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    [self.mainImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@302);
        make.width.equalTo(@355);
        make.top.equalTo(self.detailLabel.mas_bottom).offset(17);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self startAnimation];
    
}

- (void)setUpAnimationViews
{
    [NSTimer scheduledTimerWithTimeInterval:10.0f target:self selector:@selector(startAnimation) userInfo:nil repeats:YES];
}

- (UILabel *)setUpLabelWithText:(NSString *)text
{
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.font = [UIFont systemFontOfSize:20];
    label.textColor = [UIColor blackColor];
    
    return label;
}

- (void)startAnimation
{
    UIImageView *track = [[UIImageView alloc] init];
    track.image = [[UIImage imageNamed:@"bar_track"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    UIImageView *bus = [[UIImageView alloc] init];
    bus.image = [UIImage imageNamed:@"i6_bus"];
    
    [self.view addSubview:track];
    [self.view addSubview:bus];
    
    [track mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@10);
        make.width.equalTo(@10);
        make.centerY.equalTo(_fromWhereLabel.mas_centerY);
        make.left.equalTo(_fromWhereLabel.mas_right).offset(16);
    }];
    [bus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@27);
        make.width.equalTo(@56);
        make.centerX.equalTo(track.mas_right).offset(-8);
        make.bottom.equalTo(self.trackBGImage.mas_top).offset(-16);
    }];
    [self.view layoutIfNeeded];
    
    [UIView animateWithDuration:10.0f
                     animations:^{
                         [track mas_remakeConstraints:^(MASConstraintMaker *make) {
                             make.height.equalTo(@10);
                             make.centerY.equalTo(_fromWhereLabel.mas_centerY);
                             make.left.equalTo(_fromWhereLabel.mas_right).offset(16);
                             make.right.equalTo(self.toWhereLabel.mas_left).offset(-10);
                         }];
                         [self.view layoutIfNeeded];
                     }
                     completion:^(BOOL completed){
                         [track removeFromSuperview];
                         [bus removeFromSuperview];
                     }
     ];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

#pragma mark - getter & setter -

- (UIImageView *)titleImage
{
    if (!_titleImage) {
        _titleImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"i6_title"]];
    }
    return _titleImage;
}

- (UIImageView *)mainImage
{
    if (!_mainImage) {
        _mainImage = [[UIImageView alloc] init];
        if ([_from isEqualToString:@"嘉定"]) {
            _mainImage.image = [UIImage imageNamed:@"jiading"];
        }
        else if([_from isEqualToString:@"四平"]){
            _mainImage.image = [UIImage imageNamed:@"siping"];
        }
        else if([_from isEqualToString:@"沪西"]){
            _mainImage.image = [UIImage imageNamed:@"huxi"];
        }
        else if([_from isEqualToString:@"曹杨"]){
            _mainImage.image = [UIImage imageNamed:@"caoyang"];
        }
        else if([_from isEqualToString:@"同济"]){
            _mainImage.image = [UIImage imageNamed:@"beiyuan"];
        }
    }
    return _mainImage;
}

- (UIImageView *)trackBGImage
{
    if (!_trackBGImage) {
        _trackBGImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bar_background"]];
    }
    return _trackBGImage;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor colorWithRed:42/225.0 green:117/255.0 blue:216/255.0 alpha:1.0];
        _nameLabel.font = [UIFont systemFontOfSize:24];
        if (_name) {
            _nameLabel.text = _name;
        }
    }
    return _nameLabel;
}

- (UILabel *)idLabel
{
    if (!_idLabel) {
        _idLabel = [[UILabel alloc] init];
        _idLabel.textColor = [UIColor colorWithRed:42/225.0 green:117/255.0 blue:216/255.0 alpha:1.0];
        _idLabel.font = [UIFont systemFontOfSize:24];
        if (_identity) {
            _idLabel.text = _identity;
        }
    }
    return _idLabel;
}

- (UILabel *)dateAndTimeLabel
{
    if (!_dateAndTimeLabel) {
        _dateAndTimeLabel = [[UILabel alloc] init];
        _dateAndTimeLabel.textColor = [UIColor colorWithRed:205/225.0 green:56/255.0 blue:68/255.0 alpha:1.0];
        _dateAndTimeLabel.font = [UIFont systemFontOfSize:18];
        if (_date && _time) {
            _dateAndTimeLabel.text = [NSString stringWithFormat:@"%@ %@", _date, _time];
        }
    }
    return _dateAndTimeLabel;
}



@end
