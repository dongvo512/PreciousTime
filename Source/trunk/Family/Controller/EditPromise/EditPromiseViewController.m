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
    [self radiusForViewDescription];
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
-(void)radiusForViewDescription
{
    [textViewDescription.layer setCornerRadius:5.0f];
    [textViewDescription.layer setBorderWidth:0.5f];
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
    promise.description = textViewDescription.text;
    promise.dueDate = btnDueDate.titleLabel.text;
    promise.status = 1;
    
    promise.idPromise = self.aPromise.idPromise;
   BOOL isSuccess = [[DataHandler sharedManager] updatePromiseInfo:promise error:&error];
    NSAssert(isSuccess, error.description);
    if(isSuccess)
        [_delegate reloadDataPromise];
    [self.navigationController popViewControllerAnimated:YES];
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
    [btnDueDate setTitle:self.aPromise.dueDate forState:UIControlStateNormal];
    
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
    isShowKeyBoard = NO;
    [self returnScrollViewWithKeyBoard];
    //[textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(isShowKeyBoard == NO)
        [self upScrollViewWithKeyBoard];
    [self setContentOfSetScrollView:textField];
    isShowKeyBoard = YES;
}
#pragma mark - UItextView Delegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if(isShowKeyBoard == NO)
        [self upScrollViewWithKeyBoard];
    [self setContentOfSetScrollView:textView];
    isShowKeyBoard = YES;
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    isShowKeyBoard = NO;
    [textView resignFirstResponder];
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
    isShowViewPicker = NO;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    NSString *dateBirthDay = [formatter stringFromDate:datePicker.date];
    [btnDueDate setTitle:dateBirthDay forState:UIControlStateNormal];
    isShowViewPicker = NO;
    [self returnScrollViewPickerView];
}

- (IBAction)setDueDate:(id)sender
{
    isShowViewPicker = YES;
    datePicker.datePickerMode = UIDatePickerModeDate;
    [self upScrollViewDatePicker];
    [self setContentOfSetScrollView:sender];

}

- (IBAction)deleteOrSavePromise:(id)sender
{
    
    if(self.isEditPromiseViewController)
    {
        NSError *error = nil;
        BOOL isdeletePromise = [[DataHandler sharedManager] updateDeletedPromise:self.aPromise.idPromise error:&error];
        if(isdeletePromise)
            [_delegate reloadDataPromise];
    }
    else
    {
    NSError *error = nil;
    Promise *promise = [[Promise alloc] init];
    promise.name = txtName.text;
    promise.idMember = self.aPromise.idPromise;
    promise.description = textViewDescription.text;
    promise.dueDate = btnDueDate.titleLabel.text;
    promise.status = 1;
    
    NSString *idPromise = nil;
    BOOL isSuccess = [[DataHandler sharedManager] insertPromise:promise idPromise:&idPromise error:&error];
    NSAssert(isSuccess, error.description);
    if(isSuccess)
        [_delegate reloadDataPromise];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
@end
