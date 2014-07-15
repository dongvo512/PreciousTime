//
//  ActivityViewController.h
//  Family
//
//  Created by Admin on 7/2/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityTableViewCell.h"
#import "EditActivityViewController.h"

@class Member;
@interface ActivityViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,ActivityTableViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate,EditActivityViewControllerDelegate>
@property (nonatomic, retain) Member *member;
@end
