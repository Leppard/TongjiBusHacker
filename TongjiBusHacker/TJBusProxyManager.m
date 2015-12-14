//
//  TJBusProxyManager.m
//  TongjiBusHacker
//
//  Created by Leppard on 12/14/15.
//  Copyright © 2015 Leppard. All rights reserved.
//

#import "TJBusProxyManager.h"


static NSString *const kTJBusSchema = @"http://jiading.tongji.edu.cn:8080/TJbus/";

@implementation TJBusProxyManager

#pragma mark - life cycle

- (instancetype)shareManager
{
    static dispatch_once_t token;
    static TJBusProxyManager *manager;
    
    dispatch_once(&token, ^{
        manager = [[TJBusProxyManager alloc] init];
    });
    
    return manager;
}

#pragma mark - private methods

- (void)queryBusInfoByRoute:(NSInteger)routeNumber
{
    AFHTTPSessionManager *httpManager = [[AFHTTPSessionManager alloc] init];
    NSString *routeUrl = [kTJBusSchema stringByAppendingString:[NSString stringWithFormat:@"GetBusServlet?route_id=%ld", (long)routeNumber]];
    
    [httpManager GET:routeUrl parameters:nil
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 if (responseObject) {
                     
                 }
             } failure:^(NSURLSessionDataTask *task, NSError *error) {
                 
             }];
}


@end
