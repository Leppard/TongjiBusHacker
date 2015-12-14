//
//  TJPersonalInfo.m
//  TongjiBusHacker
//
//  Created by Leppard on 12/14/15.
//  Copyright © 2015 Leppard. All rights reserved.
//

#import "TJPersonalInfo.h"

@implementation TJPersonalInfo

+ (instancetype)shareInfo
{
    static dispatch_once_t token;
    static TJPersonalInfo *info;
    
    dispatch_once(&token, ^{
        info = [[TJPersonalInfo alloc] init];
    });
    
    return info;
}



@end
