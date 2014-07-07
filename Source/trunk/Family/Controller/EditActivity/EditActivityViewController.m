//
//  EditActivityViewController.m
//  Family
//
//  Created by Admin on 7/3/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "EditActivityViewController.h"

@interface EditActivityViewController ()
{
    IBOutlet UIButton *btnDelete;
}
@end

@implementation EditActivityViewController

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
    if(self.isEditActivityViewController)
        [self displayForEditViewController];
    else
        [self displayForAddNewActivityViewController];
    
}
-(void) displayForEditViewController
{
    self.title = @"Edit Activity";
    [self createButtonSave_Edit];
}
-(void) displayForAddNewActivityViewController
{
    self.title = @"New Activity";

    [btnDelete setImage:[UIImage imageNamed:@"btn_save.png"] forState:UIControlStateNormal];
    CGRect btnDeleteframe = btnDelete.frame;
    btnDeleteframe.size.width = 120;
    btnDeleteframe.size.height = 60;
    btnDelete.frame = btnDeleteframe;
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
-(void)saveEditActivity
{
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
