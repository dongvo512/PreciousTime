//
//  FriendViewController.m
//  Family
//
//  Created by Admin on 7/2/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "FriendViewController.h"
#import "InviteFriendViewController.h"
#import "Utilities.h"
@interface FriendViewController ()

@end

@implementation FriendViewController

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
    // [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]]];
    [Utilities setBackGroundForViewWithVersion:self.view];
    self.title = @"Your Friend's Activities";
    [self createInviteFriendBarButton];
}
-(void) createInviteFriendBarButton
{
    UIButton *btnInvite = [UIButton buttonWithType:UIButtonTypeSystem];
    btnInvite.frame = CGRectMake(0, 0, 60, 40);
    [btnInvite setTitle:@"Invite" forState:UIControlStateNormal];
    [btnInvite addTarget:self action:@selector(inviteFriend) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *inviteBarButton = [[UIBarButtonItem alloc] initWithCustomView:btnInvite];
    self.navigationItem.rightBarButtonItem = inviteBarButton;

}
-(void)inviteFriend
{
    InviteFriendViewController *vcInvite = [[InviteFriendViewController alloc] initWithNibName:@"InviteFriendViewController" bundle:nil];
    [self.navigationController pushViewController:vcInvite animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
