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
#import "GoogleOpenSource/GoogleOpenSource.h"

@interface InitialLandingViewController ()
{
    AppDelegate *appDelegate;
    GPPSignIn *signIn;
}
- (IBAction)signUpUser:(id)sender;
- (IBAction)loginUser:(id)sender;
- (IBAction)SigninWithFacebook:(id)sender;
- (IBAction)signInWithGoogle:(id)sender;


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
    // google login
    [self setupSignInGoogle];
  
}
-(void)setupSignInGoogle
{
    signIn = [GPPSignIn sharedInstance];
    signIn.shouldFetchGooglePlusUser = YES;
    signIn.shouldFetchGoogleUserEmail = YES;  // Uncomment to get the user's email
    
    // You previously set kClientId in the "Initialize the Google+ client" step
    //signIn.clientID = @"516933277800-8kk3rgm85uqccdonh5ataka68o7sihfe.apps.googleusercontent.com";
    // Uncomment one of these two statements for the scope you chose in the previous step
    signIn.scopes = @[ kGTLAuthScopePlusLogin ];  // "https://www.googleapis.com/auth/plus.login" scope
    signIn.scopes = @[ @"profile" ];            // "profile" scope
    
    // Optional: declare signIn.actions, see "app activities"
    signIn.delegate = self;

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

- (IBAction)signInWithGoogle:(id)sender
{
    [signIn authenticate];
}
#pragma mark - GPPSignIn Delegate
- (void)finishedWithAuth: (GTMOAuth2Authentication *)auth
                   error: (NSError *) error {
    if (error) {
        // Do some error handling here.
    } else {
        [self refreshInterfaceBasedOnSignIn];
        NSLog(@"%@",auth.userID);
        NSLog(@"%@",auth.userEmail);
        NSLog(@"%@",auth.userEmailIsVerified);
        NSLog(@"%@",auth.userAgent);
          NSLog(@"%@",signIn.userID);
         NSLog(@"%@",signIn.userEmail);
     
        
    }
    
}

- (void)presentSignInViewController:(UIViewController *)viewController {
    // This is an example of how you can implement it if your app is navigation-based.
    [[self navigationController] pushViewController:viewController animated:YES];
}
-(void)refreshInterfaceBasedOnSignIn {
    if ([[GPPSignIn sharedInstance] authentication]) {
        // The user is signed in.
        //self.signInButton.hidden = YES;
        // Perform other actions here, such as showing a sign-out button
    } else {
        //self.signInButton.hidden = NO;
        // Perform other actions here
    }
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
