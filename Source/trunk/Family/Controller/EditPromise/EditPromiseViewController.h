//
//  EditPromiseViewController.h
//  Family
//
//  Created by Admin on 7/3/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Promise.h"
@protocol EditPromiseViewControllerDelegate <NSObject>
-(void)reloadDataPromise;
@end
@interface EditPromiseViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate>
{
    id <EditPromiseViewControllerDelegate> _delegate;
}
@property (retain) id delegate;
@property (nonatomic, retain) Promise *aPromise;
@property (nonatomic) Boolean isEditPromiseViewController;
@end
