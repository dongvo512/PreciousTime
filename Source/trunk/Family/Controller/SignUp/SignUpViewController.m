//
//  SignUpViewController.m
//  Family
//
//  Created by Admin on 7/15/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "SignUpViewController.h"
#import "ImagePickerViewController.h"
#import "BlockActionSheet.h"
#import "Utilities.h"
@interface SignUpViewController ()
{
    IBOutlet UIScrollView *scrollViewContent;
    IBOutlet UIButton *btn_Avatar;
    IBOutlet UIButton *btnDateOfBirth;
    IBOutlet UITextField *txtEmail;
    IBOutlet UITextField *txtConfirm;
    IBOutlet UITextField *txtPass;
    IBOutlet UITextField *txtName;
    
    IBOutlet UIView *viewDatePicker;
    ImagePickerViewController *vcImagePicker;
    
    IBOutlet UIDatePicker *datePicker;
    BOOL isShowKeyBoard;
    BOOL isShowDatePicker;
}
- (IBAction)donePickerView:(id)sender;

- (IBAction)setDateOfBirth:(id)sender;
- (IBAction)cancelPickerView:(id)sender;
- (IBAction)takePhoto:(id)sender;
@end

@implementation SignUpViewController
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
    self.title = @"SignUp";
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]]];
     [scrollViewContent setContentSize:CGSizeMake(self.view.frame.size.width, scrollViewContent.frame.size.height)];
    [self radiusForButtonAvatar];
    [self addGestureSingleTagForScrollView];
}
-(void) radiusForButtonAvatar
{
    btn_Avatar.layer.cornerRadius = btn_Avatar.frame.size.width / 2;
    btn_Avatar.clipsToBounds = YES;
    btn_Avatar.layer.borderWidth = 3.0f;
    btn_Avatar.layer.borderColor = [UIColor whiteColor].CGColor;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    isShowDatePicker = NO;
    [self returnScrollViewWithKeyBoard];
    [self returnScrollViewPickerView];
    
}
- (IBAction)donePickerView:(id)sender
{
    isShowDatePicker = NO;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    NSString *dateBirthDay = [formatter stringFromDate:datePicker.date];
    [btnDateOfBirth setTitle:dateBirthDay forState:UIControlStateNormal];
    [self returnScrollViewPickerView];
}

- (IBAction)setDateOfBirth:(id)sender
{
    if(isShowKeyBoard)
    {
        [self returnScrollViewWithKeyBoard];
        isShowKeyBoard = NO;
    }
    
    datePicker.datePickerMode = UIDatePickerModeDate;
    [self upScrollViewDatePicker];
    [self setContentOfSetScrollView:sender];
     isShowDatePicker = YES;

}

- (IBAction)cancelPickerView:(id)sender
{
    isShowDatePicker = NO;
    [self returnScrollViewPickerView];
}

- (IBAction)takePhoto:(id)sender
{
   if(isShowDatePicker)
       [self returnScrollViewPickerView];
    if(isShowKeyBoard)
        [self returnScrollViewWithKeyBoard];
    
    vcImagePicker = [[ImagePickerViewController alloc] init];
    vcImagePicker.btnCurrent = btn_Avatar;
    BlockActionSheet *blockActionSheet = [[BlockActionSheet alloc] initWithTitle:nil];
    [blockActionSheet setCancelButtonWithTitle:@"Cancel" block:^{
        NSLog(@"Cancel");
    }];
    [blockActionSheet addButtonWithTitle:@"Take Photo" block:^{
        //NSLog(@"Take a Picture");
        [vcImagePicker takeAPickture:self];
    }];
    [blockActionSheet addButtonWithTitle:@"Camera Roll" block:^{
        // NSLog(@"Camera Roll");
        [vcImagePicker cameraRoll:self];
    }];
    [blockActionSheet showInView:self.view];
    

}
-(void)upScrollViewDatePicker
{
    isShowDatePicker = YES;
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
    if(isShowDatePicker)
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
    [txtConfirm resignFirstResponder];
    [txtEmail resignFirstResponder];
    [txtName resignFirstResponder];
    [txtPass resignFirstResponder];
}
#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    isShowKeyBoard = NO;
    [self returnScrollViewWithKeyBoard];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(isShowDatePicker)
    {
        [self returnScrollViewPickerView];
        isShowDatePicker = NO;
    }
    if(isShowKeyBoard == NO)
    [self upScrollViewWithKeyBoard];
    
    [self setContentOfSetScrollView:textField];
    isShowKeyBoard = YES;
}



@end
