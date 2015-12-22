//
//  TJPersonalInfo.m
//  TongjiBusHacker
//
//  Created by Leppard on 12/14/15.
//  Copyright © 2015 Leppard. All rights reserved.
//

#import "TJPersonalInfo.h"

static NSString *const kTJPersonID = @"kTJPersonID";
static NSString *const kTJPersonName = @"kTJPersonName";

@interface TJPersonalInfo ()<NSCoding>

@end

@implementation TJPersonalInfo

+ (instancetype)shareInfo
{
    static dispatch_once_t token;
    static TJPersonalInfo *info;
    
    dispatch_once(&token, ^{
        info = [[TJPersonalInfo alloc] init];
        info.personID = @"";
        info.personName = @"";
    });
    
    return info;
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
