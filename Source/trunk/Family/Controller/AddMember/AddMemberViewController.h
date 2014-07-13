//
//  AddMemberViewController.h
//  Family
//
//  Created by Admin on 7/1/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Member.h"
@protocol AddMemberViewControllerDelegate <NSObject>
-(void)reloadDataMember;
@end
@interface AddMemberViewController : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate>
{
    id <AddMemberViewControllerDelegate> _delegate;
}
@property (retain) id delegate;
@property (assign) Boolean isAddNewMember;
@property (nonatomic, retain) Member *aMemberCurr;
@end
