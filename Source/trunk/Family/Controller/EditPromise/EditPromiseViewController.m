//
//  EditPromiseViewController.m
//  Family
//
//  Created by Admin on 7/3/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "EditPromiseViewController.h"

@interface EditPromiseViewController ()
{
    IBOutlet UITextField *txtName;
   
    IBOutlet UITextView *textViewDescription;
    IBOutlet UILabel *lblDueDate;
    IBOutlet UIButton *btnDelete;
    IBOutlet UIDatePicker *datePicker;
    IBOutlet UIView *viewDueDate;
}
@end

@implementation EditPromiseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Display
    [self radiusForView];
    if(self.isEditPromiseViewController)
        [self displayWithEditPromiseViewController];
    else
        [self displayWithAddNewPromiseViewController];
    // Data for view
    [self loadDataForView];
    
}
-(void)radiusForView
{
    [textViewDescription.layer setCornerRadius:5.0f];
    [textViewDescription.layer setBorderWidth:1.0f];
    [viewDueDate.layer setCornerRadius:5.0f];
    [viewDueDate.layer setBorderWidth:1.0f];

}
-(void) displayWithEditPromiseViewController
{
    self.title = @"Edit Promise";
}
-(void) displayWithAddNewPromiseViewController
{
    self.title = @"New Promise";
    [self createButtonSave_Edit];
    [btnDelete setImage:[UIImage imageNamed:@"btn_save.png"] forState:UIControlStateNormal];
    CGRect frameBtnDelete = btnDelete.frame;
    frameBtnDelete.size.width = 120;
    frameBtnDelete.size.height = 60;
    btnDelete.frame = frameBtnDelete;
}
-(void) createButtonSave_Edit
{
    // Button Member
    UIButton *btnSaveEdit = [UIButton buttonWithType:UIButtonTypeCustom];
    btnSaveEdit.frame = CGRectMake(0, 0, 60, 40);
    [btnSaveEdit setImage:[UIImage imageNamed:@"btn_saveedit.png"] forState:UIControlStateNormal];
    [btnSaveEdit addTarget:self action:@selector(saveEditActivity) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *saveEditBarButton = [[UIBarButtonItem alloc] initWithCustomView:btnSaveEdit];
    self.navigationItem.rightBarButtonItem = saveEditBarButton;
}
-(void) saveEditActivity
{

}
-(void) loadDataForView
{
    txtName.text = self.aPromise.name;
    textViewDescription.text = self.aPromise.description;
    lblDueDate.text = self.aPromise.dueDate;
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
