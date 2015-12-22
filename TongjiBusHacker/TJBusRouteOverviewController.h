//
//  TJBusLineSelectController.h
//  TongjiBusHacker
//
//  Created by Leppard on 12/15/15.
//  Copyright © 2015 Leppard. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TJBusDataSourceType) {
    TJBusDataSourceTypeProxy  = 0,
    TJBusDataSourceTypeCustom = 1,
};

@interface TJBusRouteOverviewController : UIViewController

- (instancetype)initWithDataSourceType:(NSUInteger)type;

@end
