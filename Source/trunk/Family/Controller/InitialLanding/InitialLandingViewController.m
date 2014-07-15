//
//  LoginViewController.m
//  Family
//
//  Created by Admin on 7/1/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "InitialLandingViewController.h"
#import "MainViewController.h"
#import "SignUpViewController.h"
#import "LoginViewController.h"
@interface InitialLandingViewController ()
- (IBAction)signUpUser:(id)sender;
- (IBAction)loginUser:(id)sender;

@end

@implementation InitialLandingViewController
- (IBAction)skipMainViewController:(id)sender
{
     MainViewController *vcMain = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    [self.navigationController pushViewController:vcMain animated:YES];
}


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
     [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]]];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signUpUser:(id)sender
{
    SignUpViewController *vcSignUp = [[SignUpViewController alloc] initWithNibName:@"SignUpViewController" bundle:nil];
    [self.navigationController pushViewController:vcSignUp animated:YES];
}

- (IBAction)loginUser:(id)sender
{
    LoginViewController *vcLogin = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    [self.navigationController pushViewController:vcLogin animated:YES];
}
@end
