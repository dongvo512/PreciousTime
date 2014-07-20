//
//  SlicesActivityTableViewCell.h
//  Family
//
//  Created by Admin on 7/6/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "History.h"
@interface SlicesActivityTableViewCell : UITableViewCell
-(void)setObjectForCell:(History *) aHistory;
@property (nonatomic, retain) UIColor *colorCurr;
@end
