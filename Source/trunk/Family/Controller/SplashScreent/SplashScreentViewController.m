//
//  SplashScreentViewController.m
//  Family
//
//  Created by Admin on 7/8/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "SplashScreentViewController.h"
#import "InitialLandingViewController.h"
@interface SplashScreentViewController ()
{
    IBOutlet UIProgressView *progressView;
    NSTimer *timerProgress;
    int timeCurr;
}
@end

@implementation SplashScreentViewController

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
     progressView.progress = 0.0f;
    timeCurr = 0;
    timerProgress = [NSTimer scheduledTimerWithTimeInterval: 1.0
                                                     target: self
                                                   selector:@selector(onTick:)
                                                   userInfo: nil repeats:YES];
    
    
    // Do any additional setup after loading the view from its nib.
}
#define FINAL_VALUE_PROGRESS 4
-(void)onTick:(NSTimer *)timer
{
   // NSLog(@"%f",timer.timeInterval);
    timeCurr ++;
   if(timeCurr > FINAL_VALUE_PROGRESS)
   {
       [timer invalidate];
       /*LoginViewController *vcLogin = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
       [self presentViewController:vcLogin animated:YES completion:nil];*/
       InitialLandingViewController *vcLogin = [[InitialLandingViewController alloc] initWithNibName:@"InitialLandingViewController" bundle:nil];
       UINavigationController *nvg = [[UINavigationController alloc] initWithRootViewController:vcLogin];
       [nvg setNavigationBarHidden:YES animated:NO];
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
    else
        progressView.progress += 0.25;
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
