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
#import "AppDelegate.h"
@interface InitialLandingViewController ()
{
    AppDelegate *appDelegate;
}
- (IBAction)signUpUser:(id)sender;
- (IBAction)loginUser:(id)sender;
- (IBAction)SigninWithFacebook:(id)sender;

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
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
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

- (IBAction)SigninWithFacebook:(id)sender
{
    if (!FBSession.activeSession.isOpen) {
        // if the session is closed, then we open it here, and establish a handler for state changes
        [FBSession openActiveSessionWithReadPermissions:nil
                                           allowLoginUI:YES
                                      completionHandler:^(FBSession *session,
                                                          FBSessionState state,
                                                          NSError *error) {
                                          if (error) {
                                              
                                              NSLog(@"%@",[error description]);
                                              
                                          } else if (session.isOpen) {
                                              
                                              [self getUserInfo];
                                          }
                                      }];
    }
    else
        [self getUserInfo];

}
-(void) getUserInfo
{
    [[FBRequest requestForMe] startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        appDelegate.accessTK = (NSString *)[FBSession activeSession].accessTokenData;
        NSLog(@"AccessTK :%@",(NSString *)[FBSession activeSession].accessTokenData);
        appDelegate.idFacebook = [result objectForKey:@"id"];
        NSLog(@"IDFacebook :%@",[result objectForKey:@"id"]);
        appDelegate.nameUser = [result objectForKey:@"name"];
        NSLog(@"Facebook Name :%@",[result objectForKey:@"name"]);
        //result contains a dictionary of your user, including Facebook ID.
        if(!error)
        {
            MainViewController *vcMain = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
            [self.navigationController pushViewController:vcMain animated:YES];
        }
        else
            NSLog(@"Error :%@",error);
    }];

}
@end
