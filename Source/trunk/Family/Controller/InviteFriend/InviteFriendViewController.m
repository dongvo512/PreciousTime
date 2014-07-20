//
//  InviteFriendViewController.m
//  Family
//
//  Created by Admin on 7/16/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "InviteFriendViewController.h"
#import "Friend.h"
#import "AppDelegate.h"
@interface InviteFriendViewController ()
{
    IBOutlet UITableView *tblContent;
    NSMutableArray *arrFriend;
    AppDelegate *appDelegate;
}
@end

@implementation InviteFriendViewController

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
    [self checkSession];
    // Do any additional setup after loading the view from its nib.
}
-(void) createSendInviteToFriend
{
    UIButton *btnSend = [UIButton buttonWithType:UIButtonTypeSystem];
    btnSend.frame = CGRectMake(0, 0, 60, 40);
    [btnSend setTitle:@"Invite" forState:UIControlStateNormal];
    [btnSend addTarget:self action:@selector(sendInvite) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *sendBarButton = [[UIBarButtonItem alloc] initWithCustomView:btnSend];
    self.navigationItem.rightBarButtonItem = sendBarButton;
    
}
- (void) checkSession
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
                                              
                                              [self getFacebookFriend];
                                          }
                                      }];
    }
    else
        [self getFacebookFriend];

   }
-(void) getFacebookFriend
{
  
    
  /*  // NSLog(@"%@",[FBSession activeSession].accessTokenData);
    NSString *accessTK = (NSString *)[FBSession activeSession].accessTokenData;
    NSString *strAPIFriend = [NSString stringWithFormat:@"https://graph.facebook.com/me/friends?access_token=%@",accessTK];
   // NSURL *urlFriendList = [NSURL URLWithString:[@"https://graph.facebook.com/me/friends?access_token=" stringByAppendingString:accessTK]];
    NSURL *urlFriendList = [NSURL URLWithString:strAPIFriend];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:urlFriendList];
    [request setDelegate:self];
    [request startAsynchronous];*/
}


-(void)sendInvite
{
}
#define Friend_COUNT 10
-(void)createDataListFriend
{
   }
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
