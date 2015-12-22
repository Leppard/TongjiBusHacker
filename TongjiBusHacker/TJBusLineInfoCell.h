//
//  TJBusLineInfoCell.h
//  TongjiBusHacker
//
//  Created by Leppard on 12/14/15.
//  Copyright © 2015 Leppard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TJBusLineInfoCell : UITableViewCell

@property (nonatomic, strong, readonly) UILabel *fromLocation;
@property (nonatomic, strong, readonly) UILabel *toLocation;

- (void)setUpTitleFromLocation:(NSString *)fromLocation to:(NSString *)toLocation;

@end
