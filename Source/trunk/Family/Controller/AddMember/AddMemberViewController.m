//
//  AddMemberViewController.m
//  Family
//
//  Created by Admin on 7/1/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "AddMemberViewController.h"
#import "Utilities.h"
#import "BlockActionSheet.h"
#import "ImagePickerViewController.h"
#import "Member.h"
#import "DataHandler.h"
@interface AddMemberViewController ()
{
    NSMutableArray *arrMembers;
    
    IBOutlet UIButton *btnDelete;
    IBOutlet UIScrollView *scrollViewContent;
    IBOutlet UIButton *btnAvatar;
    IBOutlet UIButton *btnBirthday;
    IBOutlet UIButton *btnGender;
    IBOutlet UIDatePicker *datePicker;
    IBOutlet UIPickerView *pickerViewGender;
    IBOutlet UIView *viewDatePicker;
    IBOutlet UITextField *txtRelationship;
    NSArray *arrGender;
    Boolean isShowViewPicker;
    Boolean isShowKeyBoard;
    IBOutlet UITextField *txtName;
    ImagePickerViewController *vcImagePicker;
    int genderChosen;
}
- (IBAction)setBirthDay:(id)sender;
- (IBAction)setGender:(id)sender;
- (IBAction)doneDatePicker:(id)sender;
- (IBAction)handleAvatar:(id)sender;
- (IBAction)cancelViewPicker:(id)sender;
- (IBAction)deleteOrSaveMember:(id)sender;



@end

@implementation AddMemberViewController
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
    // Do any additional setup after loading the view from its nib.
    // Display
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]]];
    [self displayForView];
    [self addGestureSingleTagForViewParent];
    [self radiusAvatarCircle];
    [scrollViewContent setContentSize:CGSizeMake(self.view.frame.size.width, scrollViewContent.frame.size.height)];
    [viewDatePicker setFrame:CGRectMake(0, [Utilities getScreenSize].size.height, viewDatePicker.frame.size.width, viewDatePicker.frame.size.height)];
    
}

-(void)displayForView
{
    if(self.isAddNewMember)
        [self loadDisplayAddNewMember];
    else
    {
        [self loadDisplayWithEditMember];
    }
}
-(void)loadDisplayWithEditMember
{
    self.title = @"Edit Member";
    [self createButtonSaveMember];
    @try {
        NSData *data = [[NSFileManager defaultManager] contentsAtPath:self.aMemberCurr.avatarUrl];
        if(data != nil)
        [btnAvatar setImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
        NSString *genderCurr = (self.aMemberCurr.genderValue == 0)?@"Male":@"Female";
        [btnGender setTitle:genderCurr forState:UIControlStateNormal];
        [btnBirthday setTitle:self.aMemberCurr.bithday forState:UIControlStateNormal];
        txtName.text = self.aMemberCurr.name;
        txtRelationship.text = self.aMemberCurr.relationship;

    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
    
   }
-(void)loadDisplayAddNewMember
{
    self.title = @"Add Member";
    [btnDelete setImage:[UIImage imageNamed:@"btn_save.png"] forState:UIControlStateNormal];

}
-(void)radiusAvatarCircle
{
    btnAvatar.layer.cornerRadius = btnAvatar.frame.size.width / 2;
    btnAvatar.clipsToBounds = YES;
    btnAvatar.layer.borderWidth = 3.0f;
    btnAvatar.layer.borderColor = [UIColor whiteColor].CGColor;
}

#pragma mark - Take Photo
- (IBAction)handleAvatar:(id)sender
{
    vcImagePicker = [[ImagePickerViewController alloc] init];
    vcImagePicker.btnCurrent = btnAvatar;
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
-(void)createButtonSaveMember
{
    UIButton *btnSave = [UIButton buttonWithType:UIButtonTypeSystem];
    btnSave.frame = CGRectMake(0, 0, 60, 40);
    [btnSave setTitle:@"Save" forState:UIControlStateNormal];
    //[btnSave setImage:[UIImage imageNamed:@"btn_save.png"] forState:UIControlStateNormal];
    [btnSave addTarget:self action:@selector(saveMember) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *saveBarButton = [[UIBarButtonItem alloc] initWithCustomView:btnSave];
    
    self.navigationItem.rightBarButtonItem = saveBarButton;
}
-(void)saveMember
{
    NSError *error = nil;
    Member *member = [[Member alloc] init];
    member.idMember = self.aMemberCurr.idMember;
    member.name = txtName.text;
    
    NSString *documentsDirectory = [Utilities getPathOfDocument];
    NSString *avatarPath = nil;
    
    if(vcImagePicker.nameImageChosenCurr != nil)
    {
        avatarPath = [documentsDirectory stringByAppendingPathComponent:vcImagePicker.nameImageChosenCurr];
    }
    else
        avatarPath = self.aMemberCurr.avatarUrl;
    
    member.avatarUrl = avatarPath;
    
    member.bithday = btnBirthday.titleLabel.text;
    member.genderValue = genderChosen;
    member.relationship = txtRelationship.text;
    
   // NSString *idMember = nil;
    //BOOL isSuccess = [[DataHandler sharedManager] insertMember:member isSync:false idMember:&idMember error:&error];
   // member.idMember = idMember;
    BOOL  isSuccess = [[DataHandler sharedManager] updateMemberInfo:member isSync:false  error:&error];
    NSAssert(isSuccess, error.description);
    if(isSuccess)
        [_delegate reloadDataMember];
    [self.navigationController popViewControllerAnimated:YES];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)addGestureSingleTagForViewParent
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
    [self returnScrollViewDatePicker];
    
}

- (IBAction)setBirthDay:(id)sender
{
    isShowViewPicker = YES;
    [pickerViewGender setHidden:YES];
    [datePicker setHidden:NO];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [self upScrollViewDatePicker];
    [self setContentOfSetScrollView:sender];
}
- (IBAction)setGender:(id)sender
{
    isShowViewPicker = YES;
    [datePicker setHidden:YES];
    [pickerViewGender setHidden:NO];
    [self createDataGender];
    pickerViewGender.dataSource = self;
    pickerViewGender.delegate = self;
    [self upScrollViewDatePicker];
    [self setContentOfSetScrollView:sender];
}
-(void)upScrollViewDatePicker
{
    isShowViewPicker = YES;
    if(isShowKeyBoard)
       [self returnScrollViewWithKeyBoard];
    else if (isShowViewPicker)
        [self returnScrollViewDatePicker];
    
    [Utilities animationSlideY:viewDatePicker OriginY:self.view.frame.size.height - viewDatePicker.frame.size.height];
    [Utilities scaleScrollViewContent:scrollViewContent.frame.size.height - viewDatePicker.frame.size.height scrollViewCurrent:scrollViewContent];
}
-(void)returnScrollViewDatePicker
{
    [Utilities animationSlideY:viewDatePicker OriginY:[Utilities getScreenSize].size.height];
    [Utilities scaleScrollViewContent:[Utilities getScreenSize].size.height scrollViewCurrent:scrollViewContent];
}
-(void)upScrollViewWithKeyBoard
{
    isShowKeyBoard = YES;
    if(isShowViewPicker)
        [self returnScrollViewDatePicker];
     [Utilities scaleScrollViewContent:scrollViewContent.frame.size.height - KEY_BOARD_HEIGHT scrollViewCurrent:scrollViewContent];
}
-(void)returnScrollViewWithKeyBoard
{
    [self returnKeyBoard];
    [Utilities scaleScrollViewContent:[Utilities getScreenSize].size.height scrollViewCurrent:scrollViewContent];
   
}
-(void)returnKeyBoard
{
    [txtName resignFirstResponder];
    [txtRelationship resignFirstResponder];
}
-(void)setContentOfSetScrollView:(id)sender
{
    UIView *viewCurr = (UIView *)sender;
    float pointCenterScrollView = (self.view.frame.size.height - viewDatePicker.frame.size.height)/2;
     [scrollViewContent setContentOffset:CGPointMake(0, viewCurr.frame.origin.y - pointCenterScrollView)];
}

- (IBAction)doneDatePicker:(id)sender
{
    [self returnScrollViewDatePicker];
    isShowViewPicker = NO;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    NSString *dateBirthDay = [formatter stringFromDate:datePicker.date];
    [btnBirthday setTitle:dateBirthDay forState:UIControlStateNormal];
}
- (IBAction)cancelViewPicker:(id)sender
{
    isShowViewPicker = NO;
    [self returnScrollViewDatePicker];
}

- (IBAction)deleteOrSaveMember:(id)sender
{
   //With AddMemberPage this button Save
   //With EditMemberPage this button Delete
    if(self.isAddNewMember)
    {
        NSError *error = nil;
        Member *member = [[Member alloc] init];
        member.name = txtName.text;
        NSString *documentsDirectory = [Utilities getPathOfDocument];
        NSString *avatarPath = [documentsDirectory stringByAppendingPathComponent:vcImagePicker.nameImageChosenCurr];
        member.avatarUrl = avatarPath;
        member.bithday = btnBirthday.titleLabel.text;
        member.genderValue = genderChosen;
        member.relationship = txtRelationship.text;
        
        NSString *idMember = nil;
        BOOL isSuccess = [[DataHandler sharedManager] insertMember:member isSync:false idMember:&idMember error:&error];
       // DLog(@"%@",idMember);
       // NSAssert(isSuccess, error.description);
        if(isSuccess)
           [_delegate reloadDataMember];
        [self.navigationController popViewControllerAnimated:YES];

    }
    else
    {
        NSError *error = nil;
        BOOL isDeleteAMember = [[DataHandler sharedManager] updateDeletedMember:self.aMemberCurr.idMember error:&error];
        if (isDeleteAMember)
            [_delegate reloadDataMember];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)createDataGender
{
    arrGender = [NSArray arrayWithObjects:@"Male",@"Female", nil];
}
#pragma mark - Picker view data source
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [arrGender count];
}
#pragma mark - Picker view delegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
   return [arrGender objectAtIndex:row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    genderChosen = row;
    [btnGender setTitle:[arrGender objectAtIndex:row] forState:UIControlStateNormal];
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
    if(isShowKeyBoard)
        [self returnScrollViewDatePicker];
    if(isShowKeyBoard == NO)
    [self upScrollViewWithKeyBoard];
    [self setContentOfSetScrollView:textField];
    
    isShowKeyBoard = YES;
}





@end
