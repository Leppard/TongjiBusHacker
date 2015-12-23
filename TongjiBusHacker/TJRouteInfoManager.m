//
//  TJTicketInfoManager.m
//  TongjiBusHacker
//
//  Created by Leppard on 12/22/15.
//  Copyright © 2015 Leppard. All rights reserved.
//

#import "TJRouteInfoManager.h"

@implementation TJRouteInfoManager

+ (instancetype)shareManager
{
    static dispatch_once_t token;
    static TJRouteInfoManager *manager;
    
    dispatch_once(&token, ^{
        manager = [[TJRouteInfoManager alloc] init];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd";
        manager.date = [formatter stringFromDate:[NSDate date]];
    });
    
    return manager;
}

@end
