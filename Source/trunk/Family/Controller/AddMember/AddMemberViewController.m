//
//  AddMemberViewController.m
//  Family
//
//  Created by Admin on 7/1/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "AddMemberViewController.h"

@interface AddMemberViewController ()
{
    NSMutableArray *arrMembers;
    IBOutlet UIImageView *imgAvatar;
    IBOutlet UIButton *btnDelete;
}
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
    btnSave.frame = CGRectMake(0, 0, 120, 60);
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

@end
