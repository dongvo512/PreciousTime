//
//  AddMemberViewController.m
//  Family
//
//  Created by Admin on 7/1/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "AddMemberViewController.h"
#import "Utilities.h"
@interface AddMemberViewController ()
{
    NSMutableArray *arrMembers;
    IBOutlet UIImageView *imgAvatar;
    IBOutlet UIButton *btnDelete;
    IBOutlet UIScrollView *scrollViewContent;
    IBOutlet UIButton *btnBirthday;
    IBOutlet UIButton *btnGender;
    IBOutlet UIDatePicker *datePicker;
    IBOutlet UIPickerView *pickerViewGender;
    IBOutlet UIView *viewDatePicker;
    NSArray *arrGender;
    Boolean isSelectedButtonBirthDay;
}
- (IBAction)setBirthDay:(id)sender;
- (IBAction)setGender:(id)sender;
- (IBAction)doneDatePicker:(id)sender;

@end

@implementation AddMemberViewController

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
    [self isBrandMemberViewController];
    [self customizeBackButton];
    [self radiusAvatarCircle];
    [scrollViewContent setContentSize:CGSizeMake(self.view.frame.size.width, scrollViewContent.frame.size.height)];
    [viewDatePicker setFrame:CGRectMake(0, [Utilities getScreenSize].size.height, viewDatePicker.frame.size.width, viewDatePicker.frame.size.height)];
    
}

-(void)isBrandMemberViewController
{
    if(self.isAddNewMember)
    {
        self.title = @"Add Member";
        [btnDelete setImage:[UIImage imageNamed:@"btn_save.png"] forState:UIControlStateNormal];
    }
    else
    {
        self.title = @"Edit Member";
        [self createButtonSaveMember];
    }
}
-(void)radiusAvatarCircle
{
    imgAvatar.layer.cornerRadius = imgAvatar.frame.size.width / 2;
    imgAvatar.clipsToBounds = YES;
    imgAvatar.layer.borderWidth = 3.0f;
    imgAvatar.layer.borderColor = [UIColor blackColor].CGColor;
}
-(void)customizeBackButton
{
    // Button Member
    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    btnBack.frame = CGRectMake(0, 0, 30, 30);
    [btnBack setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc] initWithCustomView:btnBack];
    
    self.navigationItem.leftBarButtonItem = backBarButton;
}
-(void) popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)createButtonSaveMember
{
    UIButton *btnSave = [UIButton buttonWithType:UIButtonTypeCustom];
    btnSave.frame = CGRectMake(0, 0, 60, 40);
    [btnSave setImage:[UIImage imageNamed:@"btn_save.png"] forState:UIControlStateNormal];
    [btnSave addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *saveBarButton = [[UIBarButtonItem alloc] initWithCustomView:btnSave];
    
    self.navigationItem.rightBarButtonItem = saveBarButton;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)setBirthDay:(id)sender
{
    isSelectedButtonBirthDay = YES;
    [pickerViewGender setHidden:YES];
    [datePicker setHidden:NO];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [self tranfromScrollViewDatePicker:sender];
}
- (IBAction)setGender:(id)sender
{
    isSelectedButtonBirthDay = NO;
    [datePicker setHidden:YES];
    [pickerViewGender setHidden:NO];
    [self createDataGender];
    pickerViewGender.dataSource = self;
    pickerViewGender.delegate = self;
    [self tranfromScrollViewDatePicker:sender];
}

-(void)tranfromScrollViewDatePicker:(id) sender
{
    UIView *viewCurr = (UIView *)sender;
    [viewCurr setUserInteractionEnabled:NO];
    [self animationSlideY:viewDatePicker OriginY:self.view.frame.size.height - viewDatePicker.frame.size.height];
    [self scaleScrollViewContent:scrollViewContent.frame.size.height - viewDatePicker.frame.size.height];
    float pointCenterScrollView = (self.view.frame.size.height - viewDatePicker.frame.size.height)/2;
    [scrollViewContent setContentOffset:CGPointMake(0, viewCurr.frame.origin.y - pointCenterScrollView)];
  
}

-(void)animationSlideY:(UIView *)viewCurrent OriginY:(float) y
{
     [UIView beginAnimations:nil context:nil];
     [UIView animateWithDuration:0.5 animations:^{
     CGRect frameViewDatePicker = viewCurrent.frame;
     frameViewDatePicker.origin.y = y;
     viewCurrent.frame = frameViewDatePicker;
     }completion:^(BOOL finished){}];
     
     [UIView commitAnimations];
}
-(void)scaleScrollViewContent:(float) height
{
     CGRect frameScrollView = scrollViewContent.frame;
    frameScrollView.size.height = height;
    scrollViewContent.frame = frameScrollView;
}
#define TAG_OF_BUTTON_BIRTHDAY 1001
#define TAG_OF_BUTTON_GENDER 1002
- (IBAction)doneDatePicker:(id)sender
{
    [self animationSlideY:viewDatePicker OriginY:[Utilities getScreenSize].size.height];
    [self scaleScrollViewContent:[Utilities getScreenSize].size.height];
    if(isSelectedButtonBirthDay)
    {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    NSString *dateBirthDay = [formatter stringFromDate:datePicker.date];
    [btnBirthday setTitle:dateBirthDay forState:UIControlStateNormal];
   
    }
        [btnBirthday setUserInteractionEnabled:YES];
        [btnGender setUserInteractionEnabled:YES];
   
}
-(void)createDataGender
{
        UILabel *lblgenderMale = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, datePicker.frame.size.width, datePicker.frame.size.height)];
        lblgenderMale.textAlignment = NSTextAlignmentCenter;
        lblgenderMale.text = @"Male";
        lblgenderMale.textColor = [UIColor blackColor];
    
        UILabel *lblgenderFemale = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, datePicker.frame.size.width, datePicker.frame.size.height)];
        lblgenderFemale.textAlignment = NSTextAlignmentCenter;
        lblgenderFemale.text = @"Female";
        lblgenderFemale.textColor = [UIColor blackColor];
    
    arrGender = [NSArray arrayWithObjects:lblgenderMale,lblgenderFemale, nil];
}
#pragma mark - Picker view data source
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [arrGender count];
}
#pragma mark - Picker view delegate
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    return [arrGender objectAtIndex:row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    UILabel *lblSelected = [arrGender objectAtIndex:row];
    [btnGender setTitle:lblSelected.text forState:UIControlStateNormal];
}
#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self animationSlideY:viewDatePicker OriginY:[Utilities getScreenSize].size.height];
    [self scaleScrollViewContent:[Utilities getScreenSize].size.height];
    [textField resignFirstResponder];
    return YES;
}
#define KEY_BOARD_HEIGHT 216
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self scaleScrollViewContent:scrollViewContent.frame.size.height - KEY_BOARD_HEIGHT];
    float pointCenterScrollView = (self.view.frame.size.height - KEY_BOARD_HEIGHT)/2;
    [scrollViewContent setContentOffset:CGPointMake(0, textField.frame.origin.y - pointCenterScrollView)];

}
@end
