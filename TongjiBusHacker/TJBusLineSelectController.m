//
//  TJBusLineSelectController.m
//  TongjiBusHacker
//
//  Created by Leppard on 12/15/15.
//  Copyright © 2015 Leppard. All rights reserved.
//

#import "TJBusLineSelectController.h"
#import "TJBusLineInfoCell.h"

typedef NS_ENUM(NSUInteger, TJBusLine) {
    TJBusLineSipingToJiading  = 0,
    TJBusLineJiadingToSiping  = 1,
    TJBusLineHuxiToJiading    = 2,
    TJBusLineJiadingToHuxi    = 3,
    TJBusLineBeiyuanToJiading = 4,
    TJBusLineJiadingTobeiyuan = 5,
    TJBusLineCaoyangToJiading = 6,
    TJBusLineJiadingToCaoyang = 7,
};

@interface TJBusLineSelectController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger dataSourceType;

@end

@implementation TJBusLineSelectController

#pragma mark - life cycle

- (instancetype)initWithDataSourceType:(NSUInteger)type
{
    self = [super init];
    if (self) {
        _dataSourceType = type;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"路线选择";
    [self.view addSubview:self.tableView];
    
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TJBusLineInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TJBusLineInfoCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.row) {
        case TJBusLineSipingToJiading: {
            [cell setUpTitleFromLocation:@"四平校区" to:@"嘉定校区"];
            break;
        }
        case TJBusLineJiadingToSiping: {
            [cell setUpTitleFromLocation:@"嘉定校区" to:@"四平校区"];
            break;
        }
        case TJBusLineHuxiToJiading: {
            [cell setUpTitleFromLocation:@"沪西校区" to:@"嘉定校区"];
            break;
        }
        case TJBusLineJiadingToHuxi: {
            [cell setUpTitleFromLocation:@"嘉定校区" to:@"沪西校区"];
            break;
        }
        case TJBusLineBeiyuanToJiading: {
            [cell setUpTitleFromLocation:@"同济北苑" to:@"嘉定校区"];
            break;
        }
        case TJBusLineJiadingTobeiyuan: {
            [cell setUpTitleFromLocation:@"嘉定校区" to:@"同济北苑"];
            break;
        }
        case TJBusLineCaoyangToJiading: {
            [cell setUpTitleFromLocation:@"曹阳八村" to:@"嘉定校区"];
            break;
        }
        case TJBusLineJiadingToCaoyang: {
            [cell setUpTitleFromLocation:@"嘉定校区" to:@"曹杨八村"];
            break;
        }
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


#pragma mark - getters & setters

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        [_tableView registerClass:[TJBusLineInfoCell class] forCellReuseIdentifier:NSStringFromClass([TJBusLineInfoCell class])];
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.dataSource = self;
        _tableView.delegate   = self;
    }
    return _tableView;
}


@end