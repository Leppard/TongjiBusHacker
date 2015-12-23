//
//  TJBusRouteDetailController.m
//  TongjiBusHacker
//
//  Created by Leppard on 12/15/15.
//  Copyright © 2015 Leppard. All rights reserved.
//

#import "TJBusRouteDetailController.h"
#import "TJEditPersonalInfoController.h"
#import "TJTicketController.h"
#import "TJBusRouteDetailCell.h"
#import "TJPersonalInfoManager.h"
#import "TJRouteInfoManager.h"
#import "TJBusProxyManager.h"

#define IS_OS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface TJBusRouteDetailController ()<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIActivityIndicatorView *indicator;
@property (nonatomic, strong) NSArray *routesArray;
@property (nonatomic, assign) NSUInteger routeNumber;

@end

@implementation TJBusRouteDetailController

#pragma mark - life cycle

- (instancetype)initWithRouteNumber:(NSUInteger)routeNumber
{
    self = [super init];
    if (self) {
        _routeNumber = routeNumber + 1; // routeID从1开始
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"班次";
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.indicator];
    self.indicator.center = self.view.center;
    
    [self.indicator startAnimating];
    [self loadRouteData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.routesArray.count;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TJBusRouteDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TJBusRouteDetailCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setUpRoute:[self.routesArray objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // save route time for ticket
    TJBusRouteDetailCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [TJRouteInfoManager shareManager].time   = cell.time;
    [TJRouteInfoManager shareManager].detail = cell.line;
    
    NSDictionary *dictionary = [self setUpTicketDictionary];
    TJTicketController *ticketVC = [[TJTicketController alloc] initWithRouteDictionary:dictionary];
    [self.navigationController pushViewController:ticketVC animated:YES];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (0 == buttonIndex) {
        TJEditPersonalInfoController *vc = [[TJEditPersonalInfoController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - private methods

- (void)loadRouteData
{
    __weak typeof(self) weakSelf = self;
    [[TJBusProxyManager shareManager] queryBusInfoArrayByRoute:self.routeNumber complete:^(NSArray *data) {
        if (data.count > 0) {
            weakSelf.routesArray = data;
            [weakSelf.tableView reloadData];
            
            [weakSelf.indicator stopAnimating];
            [weakSelf.indicator removeFromSuperview];
        }
    }];
}

- (NSDictionary *)setUpTicketDictionary
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    TJPersonalInfoManager *manager = [TJPersonalInfoManager shareManager];
    if (manager.personID.length == 0 || manager.personName.length == 0) {
        [self showEmptyInfoAlert];
    }
    [dictionary setObject:[TJPersonalInfoManager shareManager].personName forKey:kTJTicketName];
    [dictionary setObject:[TJPersonalInfoManager shareManager].personID forKey:kTJTicketIdentity];
    [dictionary setObject:[TJRouteInfoManager shareManager].from forKey:kTJTicketFrom];
    [dictionary setObject:[TJRouteInfoManager shareManager].to forKey:kTJTicketTo];
    [dictionary setObject:[TJRouteInfoManager shareManager].date forKey:kTJTicketDate];
    [dictionary setObject:[TJRouteInfoManager shareManager].time forKey:kTJTicketTime];
    [dictionary setObject:[TJRouteInfoManager shareManager].detail forKey:kTJTicketDetail];
    return dictionary;
}

- (void)showEmptyInfoAlert
{
    if (IS_OS_8_OR_LATER) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请先设置个人信息再出票" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction *action) {
                                                                  [alert dismissViewControllerAnimated:YES completion:nil];
                                                              }];
        UIAlertAction *setAction = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [alert dismissViewControllerAnimated:YES completion:nil];
            TJEditPersonalInfoController *vc = [[TJEditPersonalInfoController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }];
        
        [alert addAction:defaultAction];
        [alert addAction:setAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else {
        UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"请先设置个人信息再出票" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        [view show];
    }
}

#pragma mark - getters & setters

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        [_tableView registerClass:[TJBusRouteDetailCell class] forCellReuseIdentifier:NSStringFromClass([TJBusRouteDetailCell class])];
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.dataSource = self;
        _tableView.delegate   = self;
    }
    return _tableView;
}

- (UIActivityIndicatorView *)indicator
{
    if (!_indicator) {
        _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    return _indicator;
}

- (NSArray *)routesArray
{
    if (!_routesArray) {
        _routesArray = [NSArray array];
    }
    return _routesArray;
}

@end
