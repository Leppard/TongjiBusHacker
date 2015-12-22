//
//  TJBusRouteDetailController.m
//  TongjiBusHacker
//
//  Created by Leppard on 12/15/15.
//  Copyright © 2015 Leppard. All rights reserved.
//

#import "TJBusRouteDetailController.h"
#import "TJTicketController.h"
#import "TJBusRouteDetailCell.h"
#import "TJBusProxyManager.h"

@interface TJBusRouteDetailController ()<UITableViewDataSource, UITableViewDelegate>

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

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSDictionary *dictionary = [self]
//}

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

//- (NSDictionary *)setUpTicketDictionary
//{
//    NSDictionary *dictionary = [NSDictionary dictionary];
//    dictionary setValue: forKey:<#(nonnull NSString *)#>
//}

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
