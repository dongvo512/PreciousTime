//
//  PromiseViewController.h
//  Family
//
//  Created by Admin on 7/2/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PromiseTableViewCell.h"
#import "EditPromiseViewController.h"
@interface PromiseViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,PromiseTableViewCellDelegate,EditPromiseViewControllerDelegate>
@property (nonatomic,retain) NSString *idMemberCurr;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withIdMember:(NSString*)idMember;
@end
