//
//  TJBusRouteTableViewCell.h
//  TongjiBusHacker
//
//  Created by Leppard on 12/14/15.
//  Copyright © 2015 Leppard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TJBusRouteDetailCell : UITableViewCell

@property (nonatomic, strong, readonly) NSString *busID;
@property (nonatomic, strong, readonly) NSString *time;
@property (nonatomic, strong, readonly) NSString *line;
@property (nonatomic, strong, readonly) NSString *rest;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

- (void)setUpRoute:(NSDictionary *)dictionary;

@end
