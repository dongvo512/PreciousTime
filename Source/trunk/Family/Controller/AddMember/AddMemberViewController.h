//
//  AddMemberViewController.h
//  Family
//
//  Created by Admin on 7/1/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddMemberViewController : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (assign) Boolean isAddNewMember;
@end
