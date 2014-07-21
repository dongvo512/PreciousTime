//
//  EditPromiseViewController.m
//  Family
//
//  Created by Admin on 7/3/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "EditPromiseViewController.h"
#import "Utilities.h"
#import "Datahandler.h"

@interface EditPromiseViewController ()
{
    IBOutlet UITextField *txtName;
    IBOutlet UITextView *textViewDescription;
    IBOutlet UIButton *btnDelete;
    IBOutlet UIDatePicker *datePicker;
    IBOutlet UIView *viewDatePicker;
    IBOutlet UIButton *btnDueDate;
    Boolean isShowViewPicker;
    IBOutlet UIScrollView *scrollViewContent;
    Boolean isShowKeyBoard;
}
- (IBAction)cancelDatePicker:(id)sender;
- (IBAction)doneDatePicker:(id)sender;
- (IBAction)setDueDate:(id)sender;
- (IBAction)deleteOrSavePromise:(id)sender;

@end

@implementation EditPromiseViewController
#define KEY_BOARD_HEIGHT 216
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
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]]];
    
    if(self.isEditPromiseViewController)
        [self displayWithEditPromiseViewController];
    else
        [self displayWithAddNewPromiseViewController];
    
     [scrollViewContent setContentSize:CGSizeMake(self.view.frame.size.width, scrollViewContent.frame.size.height)];
    [viewDatePicker setFrame:CGRectMake(0, [Utilities getScreenSize].size.height, viewDatePicker.frame.size.width, viewDatePicker.frame.size.height)];
    [self addGestureSingleTagForScrollView];
    // Data for view
    [self setDataForView];
    
}
-(void)radiusForView
{
    [textViewDescription.layer setCornerRadius:5.0f];
    [textViewDescription.layer setBorderWidth:0.5f];
    
    [txtName.layer setCornerRadius:5.0f];
    [txtName.layer setBorderWidth:0.5f];
    
    [btnDueDate.layer setCornerRadius:5.0f];
    [btnDueDate.layer setBorderWidth:0.5f];
    
}
-(void) displayWithEditPromiseViewController
{
    self.title = @"Edit Promise";
     [self createButtonSave_Edit];
}
-(void) displayWithAddNewPromiseViewController
{
    self.title = @"New Promise";
   
    [btnDelete setImage:[UIImage imageNamed:@"btn_save.png"] forState:UIControlStateNormal];
    CGRect frameBtnDelete = btnDelete.frame;
    frameBtnDelete.size.width = 120;
    frameBtnDelete.size.height = 60;
    btnDelete.frame = frameBtnDelete;
}
-(void) createButtonSave_Edit
{
    // Button Member
    UIButton *btnSaveEdit = [UIButton buttonWithType:UIButtonTypeSystem];
    btnSaveEdit.frame = CGRectMake(0, 0, 60, 40);
    [btnSaveEdit setTitle:@"Save" forState:UIControlStateNormal];
   // [btnSaveEdit setImage:[UIImage imageNamed:@"btn_saveedit.png"] forState:UIControlStateNormal];
    [btnSaveEdit addTarget:self action:@selector(saveEditPromise) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *saveEditBarButton = [[UIBarButtonItem alloc] initWithCustomView:btnSaveEdit];
    self.navigationItem.rightBarButtonItem = saveEditBarButton;
}
-(void) saveEditPromise
{
    NSError *error = nil;
    Promise *promise = [[Promise alloc] init];
    promise.name = txtName.text;
    promise.idMember = [Utilities getCurrentUserNameFromUserDefault];
    promise.description = textViewDescription.text;
    NSString *strDueDate = [Utilities convertddMMyyyyToMMddyyyy:btnDueDate.titleLabel.text];
    promise.dueDate = strDueDate;
    promise.idPromise = self.aPromise.idPromise;
    
    // check Important
    if([self checkImportant:promise])
        return;
    
   BOOL isSuccess = [[DataHandler sharedManager] updatePromiseInfo:promise error:&error];
    NSAssert(isSuccess, error.description);
    if(isSuccess)
        [_delegate reloadDataPromise];
    [self.navigationController popViewControllerAnimated:YES];
}
-(BOOL) checkImportant:(Promise *)promise
{
    if([promise.name isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Promise Name must not be empty " delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return YES;
    }
    else if (promise.dueDate == nil)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Due date must not be empty " delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return YES;
    }
    else
        return NO;
    
}
-(void)addGestureSingleTagForScrollView
{
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [scrollViewContent addGestureRecognizer:singleFingerTap];
    
}
-(void)handleSingleTap:(id)sender
{
    isShowKeyBoard = NO;
    isShowViewPicker = NO;
    [self returnScrollViewWithKeyBoard];
    [self returnScrollViewPickerView];
    
}
-(void) setDataForView
{
    txtName.text = self.aPromise.name;
    textViewDescription.text = self.aPromise.description;
    NSString *strDueDate = [Utilities convertMMddyyyyToddMMyyyy:self.aPromise.dueDate];
    [btnDueDate setTitle:strDueDate forState:UIControlStateNormal];
    
}
- (IBAction)setDueDate:(id)sender
{
       if(isShowKeyBoard)
    {
        [self returnScrollViewWithKeyBoard];
        isShowKeyBoard = NO;
    }
    datePicker.datePickerMode = UIDatePickerModeDate;
    [self upScrollViewDatePicker];
    [self setContentOfSetScrollView:sender];
    isShowViewPicker = YES;
    
}
-(void)upScrollViewDatePicker
{
    isShowViewPicker = YES;
    if(isShowKeyBoard)
        [self returnScrollViewWithKeyBoard];
    
    [Utilities animationSlideY:viewDatePicker OriginY:self.view.frame.size.height - viewDatePicker.frame.size.height];
    [Utilities scaleScrollViewContent:scrollViewContent.frame.size.height - viewDatePicker.frame.size.height scrollViewCurrent:scrollViewContent];
}
-(void)returnScrollViewPickerView
{
    [Utilities animationSlideY:viewDatePicker OriginY:[Utilities getScreenSize].size.height];
    [Utilities scaleScrollViewContent:[Utilities getScreenSize].size.height scrollViewCurrent:scrollViewContent];
}
-(void)upScrollViewWithKeyBoard
{
    isShowKeyBoard = YES;
    if(isShowViewPicker)
        [self returnScrollViewPickerView];
    [Utilities scaleScrollViewContent:scrollViewContent.frame.size.height - KEY_BOARD_HEIGHT scrollViewCurrent:scrollViewContent];
}
-(void)returnScrollViewWithKeyBoard
{
    [self returnKeyBoard];
    [Utilities scaleScrollViewContent:[Utilities getScreenSize].size.height scrollViewCurrent:scrollViewContent];
    
}
-(void)setContentOfSetScrollView:(id)sender
{
    UIView *viewCurr = (UIView *)sender;
    float pointCenterScrollView = (self.view.frame.size.height - viewDatePicker.frame.size.height)/2;
    [scrollViewContent setContentOffset:CGPointMake(0, viewCurr.frame.origin.y - pointCenterScrollView)];
}

-(void)returnKeyBoard
{
    [txtName resignFirstResponder];
    [textViewDescription resignFirstResponder];
}
#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self returnScrollViewWithKeyBoard];
    isShowKeyBoard = NO;
      return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
   if(isShowViewPicker)
   {
       [self returnScrollViewPickerView];
       isShowViewPicker = NO;
   }
    if(isShowKeyBoard == YES)
    {
    [self returnScrollViewPickerView];
        isShowKeyBoard = NO;
    }
    
    [self upScrollViewWithKeyBoard];
    [self setContentOfSetScrollView:textField];
    isShowKeyBoard = YES;
}
#pragma mark - UItextView Delegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
   if(isShowViewPicker)
   {
       [self returnScrollViewPickerView];
       isShowViewPicker = NO;
       
   }
    if(isShowKeyBoard == NO)
    {
        [self upScrollViewWithKeyBoard];
        isShowKeyBoard = YES;
    }
   
    [self setContentOfSetScrollView:textView];
    isShowKeyBoard = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelDatePicker:(id)sender
{
    isShowViewPicker = NO;
    [self returnScrollViewPickerView];
}

- (IBAction)doneDatePicker:(id)sender
{
    NSDate *dateCurrent =[NSDate date];
    NSDate *dateOfDatePicker = datePicker.date;
    
    if([dateCurrent compare:dateOfDatePicker] == NSOrderedDescending)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Date must be larger than to day " delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd/MM/yyyy"];
        NSString *dateBirthDay = [formatter stringFromDate:datePicker.date];
        [btnDueDate setTitle:dateBirthDay forState:UIControlStateNormal];
    }
  
    isShowViewPicker = NO;
    [self returnScrollViewPickerView];
}



- (IBAction)deleteOrSavePromise:(id)sender
{
    
    if(self.isEditPromiseViewController)
    {
        NSError *error = nil;
        self.aPromise.idMember = [Utilities getCurrentUserNameFromUserDefault];
        BOOL isdeletePromise = [[DataHandler sharedManager] updateDeletedPromise:self.aPromise.idPromise idMember:self.aPromise.idMember error:&error];
//        if(isdeletePromise)
//            [_delegate reloadDataPromise];
    }
    else
    {
        NSError *error = nil;
        Promise *promise = [[Promise alloc] init];
        promise.name = txtName.text;
        promise.idMember = [Utilities getCurrentUserNameFromUserDefault];
        promise.description = textViewDescription.text;
         NSString *strDueDate = [Utilities convertddMMyyyyToMMddyyyy:btnDueDate.titleLabel.text];
        promise.dueDate = strDueDate;
        promise.status = 0;
        
        if([self checkImportant:promise])
            return;
        
        NSString *idPromise = nil;
        BOOL isSuccess = [[DataHandler sharedManager] insertPromise:promise idPromise:&idPromise error:&error];
    //    NSAssert(isSuccess, error.description);
    //    if(isSuccess)
    //        [_delegate reloadDataPromise];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
@end
