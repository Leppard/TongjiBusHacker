//
//  TJBusProxyManager.h
//  TongjiBusHacker
//
//  Created by Leppard on 12/14/15.
//  Copyright © 2015 Leppard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TJBusProxyManager : NSObject

+ (TJBusProxyManager *)shareManager;

- (void)queryBusInfoArrayByRoute:(NSInteger)routeNumber complete:(void (^)(NSArray *data))completion;

@end
