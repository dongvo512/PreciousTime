//
//  MainViewController.h
//  Family
//
//  Created by Admin on 7/1/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Member.h"
#import "MemberInfoView.h"
@interface MainViewController : UIViewController 
@property (nonatomic, retain) Member *aMemberCurr;
-(void) setDataForTableView:(int) index;
@property (nonatomic, retain) MemberInfoView *aMemberInfoCurr;
@end
