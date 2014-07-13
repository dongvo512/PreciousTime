//
//  MemberViewController.h
//  Family
//
//  Created by Admin on 7/1/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MemberTableViewCell.h"
#import "AddMemberViewController.h"
#import "MemberInfoView.h"
@interface MemberViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MemberTableViewCellDelegate,AddMemberViewControllerDelegate>

@end
