//
//  EditActivityViewController.m
//  Family
//
//  Created by Admin on 7/3/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "EditActivityViewController.h"
#import "Utilities.h"
#import "ImagePickerViewController.h"
#import "BlockActionSheet.h"
#import "Activity.h"
#import "DataHandler.h"
@interface EditActivityViewController ()
{
    IBOutlet UIButton *btnDelete;
    IBOutlet UIView *viewPickerMinutes;
    IBOutlet UIPickerView *pickerView;
    IBOutlet UITextField *txtPoint;
    IBOutlet UIButton *btnUnitType;
    IBOutlet UITextField *txtName;
    Boolean isShowViewPicker;
    IBOutlet UIScrollView *scrollViewContent;
    Boolean isShowKeyBoard;
    IBOutlet UIButton *btnAvatarActivity;
    int unitType;
    NSMutableArray *arrTimeStyle;
    ImagePickerViewController *vcImagePicker;
}
- (IBAction)takeAvatarActivity:(id)sender;
- (IBAction)deleteOrSaveActivity:(id)sender;


- (IBAction)cancelPickerView:(id)sender;

- (IBAction)donePickerView:(id)sender;

- (IBAction)setMinutesActivity:(id)sender;

@end

@implementation EditActivityViewController
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
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]]];
      [scrollViewContent setContentSize:CGSizeMake(self.view.frame.size.width, scrollViewContent.frame.size.height)];
    
    if(self.isEditActivityViewController)
        [self displayForEditViewController];
    else
        [self displayForAddNewActivityViewController];
    
    [self addGestureSingleTagForScrollView];
    [self radiusAvatarCircleActivity];
    [viewPickerMinutes setFrame:CGRectMake(0, [Utilities getScreenSize].size.height, viewPickerMinutes.frame.size.width, viewPickerMinutes.frame.size.height)];

    
}
-(void)radiusAvatarCircleActivity
{
    btnAvatarActivity.layer.cornerRadius = btnAvatarActivity.frame.size.width / 2;
    btnAvatarActivity.clipsToBounds = YES;
    btnAvatarActivity.layer.borderWidth = 3.0f;
    btnAvatarActivity.layer.borderColor = [UIColor whiteColor].CGColor;
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
-(void) displayForEditViewController
{
    self.title = @"Edit Activity";
    [self createButtonSave_Edit];
    @try {
        NSData *data = [[NSFileManager defaultManager] contentsAtPath:self.aActivityCurr.strAvatar];
        UIImage *imgCurr = [UIImage imageNamed:self.aActivityCurr.strAvatar];
        if(data != nil)
            [btnAvatarActivity setImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
        else if(imgCurr != nil)
            [btnAvatarActivity setImage:[UIImage imageNamed:self.aActivityCurr.strAvatar] forState:UIControlStateNormal];
        else
            [btnAvatarActivity setImage:[UIImage imageNamed:@"logo_03.png"] forState:UIControlStateNormal];
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
   
   
    txtName.text = self.aActivityCurr.name;
    
    switch (self.aActivityCurr.unitTypeValue)
    {
        case 0:
            [btnUnitType setTitle:@"Second" forState:UIControlStateNormal];
            break;
        case 1:
            [btnUnitType setTitle:@"Minute" forState:UIControlStateNormal];
            break;
        case 2:
            [btnUnitType setTitle:@"Hour" forState:UIControlStateNormal];
            break;
        default:
            break;
    }
    
    txtPoint.text = [NSString stringWithFormat:@"%d",self.aActivityCurr.point];
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
    UIButton *btnSaveEdit = [UIButton buttonWithType:UIButtonTypeSystem];
    btnSaveEdit.frame = CGRectMake(0, 0, 60, 40);
    [btnSaveEdit setTitle:@"Save" forState:UIControlStateNormal];
    //[btnSaveEdit setImage:[UIImage imageNamed:@"btn_saveedit.png"] forState:UIControlStateNormal];
    [btnSaveEdit addTarget:self action:@selector(saveEditActivity) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *saveEditBarButton = [[UIBarButtonItem alloc] initWithCustomView:btnSaveEdit];
    self.navigationItem.rightBarButtonItem = saveEditBarButton;
}
-(void)saveEditActivity
{
    NSError *error = nil;
    Activity *activity = [[Activity alloc] init];
    activity.name = txtName.text;
    activity.unitTypeValue = unitType;
    NSString *documentsDirectory = [Utilities getPathOfDocument];
    NSString *avatarPath = nil;
    
    if(vcImagePicker.nameImageChosenCurr != nil)
    {
        avatarPath = [documentsDirectory stringByAppendingPathComponent:vcImagePicker.nameImageChosenCurr];
    }
    else
        avatarPath = self.aActivityCurr.strAvatar;
    
    activity.strAvatar = avatarPath;
    activity.point = txtPoint.text.intValue;
    
    activity.idActivity = self.aActivityCurr.idActivity;
    BOOL isSuccess = [[DataHandler sharedManager] updateActivityInfo:activity isSync:false error:&error];
    NSAssert(isSuccess, error.description);
    if(isSuccess)
    [_delegate reloadDataActivity];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Take Photo
- (IBAction)takeAvatarActivity:(id)sender
{
    vcImagePicker = [[ImagePickerViewController alloc] init];
    vcImagePicker.btnCurrent = btnAvatarActivity;
    BlockActionSheet *blockActionSheet = [[BlockActionSheet alloc] initWithTitle:nil];
    [blockActionSheet setCancelButtonWithTitle:@"Cancel" block:^{
        NSLog(@"Cancel");
    }];
    [blockActionSheet addButtonWithTitle:@"Take a Picker" block:^{
        //NSLog(@"Take a Picture");
        [vcImagePicker takeAPickture:self];
    }];
    [blockActionSheet addButtonWithTitle:@"Camera Roll" block:^{
        // NSLog(@"Camera Roll");
        [vcImagePicker cameraRoll:self];
    }];
    [blockActionSheet showInView:self.view];
}

- (IBAction)deleteOrSaveActivity:(id)sender
{
    if(self.isEditActivityViewController)
    {
        NSError *error = nil;
        BOOL isDeleteActivity = [[DataHandler sharedManager] updateDeletedActivity:self.aActivityCurr.idActivity error:&error];
        if(isDeleteActivity)
            [_delegate reloadDataActivity];
    }
    else
    {
        NSError *error = nil;
        Activity *activity = [[Activity alloc] init];
        activity.name = txtName.text;
        activity.unitTypeValue = unitType;
        NSString *documentsDirectory = [Utilities getPathOfDocument];
        NSString *avatarPath = [documentsDirectory stringByAppendingPathComponent:vcImagePicker.nameImageChosenCurr];

        activity.strAvatar = avatarPath;
        activity.point = txtPoint.text.intValue;
        
        NSString *idActivity = nil;
        BOOL isSuccess = [[DataHandler sharedManager] insertActivity:activity isSync:false idActivity:&idActivity error:&error];
        DLog(@"%@",idActivity);
      //  NSAssert(isSuccess, error.description);
        if(isSuccess)
          [_delegate reloadDataActivity];
    }
    [self.navigationController popViewControllerAnimated:YES];

}

- (IBAction)cancelPickerView:(id)sender
{
    isShowViewPicker = NO;
    [self returnScrollViewPickerView];
}

- (IBAction)donePickerView:(id)sender
{
    isShowViewPicker = NO;
    [self returnScrollViewPickerView];
}

- (IBAction)setMinutesActivity:(id)sender
{
    isShowViewPicker = YES;
    [self createDataTime];
    pickerView.dataSource = self;
    pickerView.delegate = self;
    [self upScrollViewPickerMinutes];
    [self setContentOfSetScrollView:sender];
}
-(void)upScrollViewPickerMinutes
{
    isShowViewPicker = YES;
    if(isShowKeyBoard)
        [self returnScrollViewWithKeyBoard];
    
    [Utilities animationSlideY:viewPickerMinutes OriginY:self.view.frame.size.height - viewPickerMinutes.frame.size.height];
    [Utilities scaleScrollViewContent:scrollViewContent.frame.size.height - viewPickerMinutes.frame.size.height scrollViewCurrent:scrollViewContent];
}
-(void)returnScrollViewPickerView
{
    [Utilities animationSlideY:viewPickerMinutes OriginY:[Utilities getScreenSize].size.height];
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
    float pointCenterScrollView = (self.view.frame.size.height - viewPickerMinutes.frame.size.height)/2;
    [scrollViewContent setContentOffset:CGPointMake(0, viewCurr.frame.origin.y - pointCenterScrollView)];
}

-(void)returnKeyBoard
{
    [txtName resignFirstResponder];
    [txtPoint resignFirstResponder];
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
-(void)createDataTime
{
    arrTimeStyle = [NSMutableArray array];
    [arrTimeStyle addObject:@"Second"];
    [arrTimeStyle addObject:@"Minute"];
    [arrTimeStyle addObject:@"Hour"];
    
}
#pragma mark - Picker view data source
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [arrTimeStyle count];
}
#pragma mark - Picker view delegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
   // NSLog(@"%@",arrMinutes objectAtIndex:row);
    return [arrTimeStyle objectAtIndex:row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    unitType = row;
    NSString *strMinuteCur = [arrTimeStyle objectAtIndex:row];
    [btnUnitType setTitle:strMinuteCur forState:UIControlStateNormal];
}

@end
