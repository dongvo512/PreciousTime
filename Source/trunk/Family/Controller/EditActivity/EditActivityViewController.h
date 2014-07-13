//
//  EditActivityViewController.h
//  Family
//
//  Created by Admin on 7/3/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Activity.h"
@protocol EditActivityViewControllerDelegate <NSObject>
-(void)reloadDataActivity;
@end
@interface EditActivityViewController : UIViewController<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
        id <EditActivityViewControllerDelegate> _delegate;
}
@property (retain) id delegate;
@property (nonatomic) Boolean isEditActivityViewController;
@property (nonatomic, retain) Activity *aActivityCurr;
@end
