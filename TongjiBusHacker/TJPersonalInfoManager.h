//
//  TJPersonalInfo.h
//  TongjiBusHacker
//
//  Created by Leppard on 12/14/15.
//  Copyright © 2015 Leppard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TJPersonalInfoManager : NSObject

@property (nonatomic, strong) NSString *personName;
@property (nonatomic, strong) NSString *personID;

+ (instancetype)shareManager;

@end
