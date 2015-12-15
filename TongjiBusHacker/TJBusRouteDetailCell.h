//
//  TJBusRouteTableViewCell.h
//  TongjiBusHacker
//
//  Created by Leppard on 12/14/15.
//  Copyright © 2015 Leppard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TJBusRouteDetailCell : UITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

- (void)setUpRoute:(NSDictionary *)dictionary;

@end
