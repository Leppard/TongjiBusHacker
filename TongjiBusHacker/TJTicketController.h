//
//  TJTicketController.h
//  TongjiBusHacker
//
//  Created by Leppard on 12/15/15.
//  Copyright © 2015 Leppard. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const kTJTicketName     = @"kTJTicketName";
static NSString *const kTJTicketIdentity = @"kTJTicketIdentity";
static NSString *const kTJTicketFrom     = @"kTJTicketFrom";
static NSString *const kTJTicketTo       = @"kTJTicketTo";
static NSString *const kTJTicketTime     = @"kTJTicketTime";
static NSString *const kTJTicketDate     = @"kTJTicketDate";
static NSString *const kTJTicketDetail   = @"kTJTicketDetail";

@interface TJTicketController : UIViewController

- (instancetype)initWithRouteDictionary:(NSDictionary *)dictionary;

@end
