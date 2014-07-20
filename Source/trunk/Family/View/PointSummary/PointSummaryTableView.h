//
//  PointSummaryTableView.h
//  Family
//
//  Created by Admin on 7/10/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PointSummaryTableView : UITableView<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, retain) NSString *idMember;

-(void) setDataForTableView:(int) index;
@end
