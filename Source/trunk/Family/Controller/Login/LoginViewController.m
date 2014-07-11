//
//  LoginViewController.m
//  Family
//
//  Created by Admin on 7/1/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "LoginViewController.h"
#import "MainViewController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController
- (IBAction)skipMainViewController:(id)sender
{
    MainViewController *vcMain = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    UINavigationController *nvg = [[UINavigationController alloc] initWithRootViewController:vcMain];
    
    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    if ([[ver objectAtIndex:0] intValue] >= 7) {
        nvg.navigationBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_navigationbar.png"]];
        nvg.navigationBar.translucent = NO;
    }else {
        nvg.navigationBar.tintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_navigationbar.png"]];
    }
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    
    [self presentViewController:nvg animated:YES completion:nil];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
