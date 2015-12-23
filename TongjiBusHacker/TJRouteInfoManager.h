//
//  TJTicketInfoManager.h
//  TongjiBusHacker
//
//  Created by Leppard on 12/22/15.
//  Copyright © 2015 Leppard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TJRouteInfoManager : NSObject

@property (nonatomic, strong) NSString *from;
@property (nonatomic, strong) NSString *to;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *detail; // 线路信息

+ (instancetype)shareManager;

@end
