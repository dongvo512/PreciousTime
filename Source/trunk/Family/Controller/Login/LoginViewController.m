//
//  LoginViewController.m
//  Family
//
//  Created by Admin on 7/15/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "LoginViewController.h"
#import "Utilities.h"
@interface LoginViewController ()
{
    IBOutlet UITextField *txtPass;
    IBOutlet UITextField *txtName;
}


@end

@implementation LoginViewController
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
    //Display
    self.title = @"Login";
    //[self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]]];
    [Utilities setBackGroundForViewWithVersion:self.view];
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
   
}


#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
