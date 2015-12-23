//
//  TJPersonalInfo.m
//  TongjiBusHacker
//
//  Created by Leppard on 12/14/15.
//  Copyright © 2015 Leppard. All rights reserved.
//

#import "TJPersonalInfoManager.h"

static NSString *const kTJPersonID   = @"kTJPersonID";
static NSString *const kTJPersonName = @"kTJPersonName";
static NSString *const kTJPersonalInfoUserDefaultsData = @"kTJPersonalInfoUserDefaultsData";

@interface TJPersonalInfoManager ()<NSCoding>

@end

@implementation TJPersonalInfoManager

+ (instancetype)shareManager
{
    static dispatch_once_t token;
    static TJPersonalInfoManager *manager;
    
    dispatch_once(&token, ^{
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        id data = [defaults objectForKey:kTJPersonalInfoUserDefaultsData];
        if (data) {
            manager = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        } else {
            manager = [[TJPersonalInfoManager alloc] init];
            manager.personID   = @"";
            manager.personName = @"";
        }
    });
    
    return manager;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _personID = [aDecoder decodeObjectForKey:kTJPersonID];
        _personName = [aDecoder decodeObjectForKey:kTJPersonName];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.personID forKey:kTJPersonID];
    [aCoder encodeObject:self.personName forKey:kTJPersonName];
}

@end
