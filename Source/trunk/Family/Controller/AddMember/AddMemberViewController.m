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
}
- (IBAction)setBirthDay:(id)sender;
- (IBAction)setGender:(id)sender;
- (IBAction)doneDatePicker:(id)sender;
- (IBAction)handleAvatar:(id)sender;

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
    [self isAddMemberViewController];
    [self customizeBackButton];
    [self radiusAvatarCircle];
    [scrollViewContent setContentSize:CGSizeMake(self.view.frame.size.width, scrollViewContent.frame.size.height)];
    [viewDatePicker setFrame:CGRectMake(0, [Utilities getScreenSize].size.height, viewDatePicker.frame.size.width, viewDatePicker.frame.size.height)];
    
}

-(void)isAddMemberViewController
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
    btnAvatar.layer.cornerRadius = btnAvatar.frame.size.width / 2;
    btnAvatar.clipsToBounds = YES;
    btnAvatar.layer.borderWidth = 3.0f;
    btnAvatar.layer.borderColor = [UIColor blackColor].CGColor;
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
    [pickerViewGender setHidden:YES];
    [datePicker setHidden:NO];
    datePicker.datePickerMode = UIDatePickerModeDate;
   // [self tranfromScrollViewDatePicker:sender];
    [self upScrollViewDatePicker];
    [self setContentOfSetScrollView:sender];
}
- (IBAction)setGender:(id)sender
{
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
    [self animationSlideY:viewDatePicker OriginY:self.view.frame.size.height - viewDatePicker.frame.size.height];
    [self scaleScrollViewContent:scrollViewContent.frame.size.height - viewDatePicker.frame.size.height];
}
-(void)returnScrollViewDatePicker
{
    [self animationSlideY:viewDatePicker OriginY:[Utilities getScreenSize].size.height];
    [self scaleScrollViewContent:[Utilities getScreenSize].size.height];
}
-(void)upScrollViewWithKeyBoard
{
    isShowKeyBoard = YES;
    if(isShowViewPicker)
        [self returnScrollViewDatePicker];
    [self scaleScrollViewContent:scrollViewContent.frame.size.height - KEY_BOARD_HEIGHT];
}
-(void)returnScrollViewWithKeyBoard
{
    [self scaleScrollViewContent:[Utilities getScreenSize].size.height];
    [self returnKeyBoard];
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

- (IBAction)doneDatePicker:(id)sender
{
    //[self animationSlideY:viewDatePicker OriginY:[Utilities getScreenSize].size.height];
    //[self scaleScrollViewContent:[Utilities getScreenSize].size.height];
    [self returnScrollViewDatePicker];
    isShowViewPicker = NO;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    NSString *dateBirthDay = [formatter stringFromDate:datePicker.date];
    [btnBirthday setTitle:dateBirthDay forState:UIControlStateNormal];
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
    [btnGender setTitle:[arrGender objectAtIndex:row] forState:UIControlStateNormal];
}
#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    isShowKeyBoard = NO;
    [self returnScrollViewWithKeyBoard];
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self upScrollViewWithKeyBoard];
    [self setContentOfSetScrollView:textField];
}
-(Boolean) isCheckCamrera
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        return NO;
    }
    else
        return YES;
}
- (IBAction)handleAvatar:(id)sender
{
    BlockActionSheet *blockActionSheet = [[BlockActionSheet alloc] initWithTitle:@"Image Option"];
    [blockActionSheet setCancelButtonWithTitle:@"Cancel" block:^{
        NSLog(@"Cancel");
    }];
    [blockActionSheet setDestructiveButtonWithTitle:@"Take a Picture" block:^{
        NSLog(@"Take a Picture");
        [self takeAPickture];
    }];
    [blockActionSheet addButtonWithTitle:@"Camera Roll" block:^{
        NSLog(@"Camera Roll");
        if([self isCheckCamrera])
            [self cameraRoll];
    }];
    [blockActionSheet showInView:self.view];
}
- (void)takeAPickture
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}
-(void)cameraRoll
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
}
#pragma mark - Image Picker Controller delegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    [btnAvatar setImage:chosenImage forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
@end
