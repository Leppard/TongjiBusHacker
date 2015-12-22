//
//  TJTicketInfoManager.m
//  TongjiBusHacker
//
//  Created by Leppard on 12/22/15.
//  Copyright © 2015 Leppard. All rights reserved.
//

#import "TJTicketInfoManager.h"

@implementation TJTicketInfoManager

+ (instancetype)shareManager
{
    static dispatch_once_t token;
    static TJTicketInfoManager *manager;
    
    dispatch_once(&token, ^{
        manager = [[TJTicketInfoManager alloc] init];
    });
    
    return manager;
}

@end
