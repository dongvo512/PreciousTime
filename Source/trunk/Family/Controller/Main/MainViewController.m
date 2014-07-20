//
//  MainViewController.m
//  Family
//
//  Created by Admin on 7/1/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "MainViewController.h"
#import "MemberViewController.h"
#import "HistoryViewController.h"
#import "PromiseViewController.h"
#import "FriendViewController.h"
#import "ActivityViewController.h"
#import "SettingViewController.h"
#import "PointSummaryTableView.h"
#import "CircleView.h"
#import "Utilities.h"
#import "MemberInfoView.h"
#import "DataHandler.h"
#import "contant.h"
@interface MainViewController ()
{
    IBOutlet UIScrollView *scrollViewContant;
    NSMutableArray *arrSlices;
    NSArray *arrSlicesColor;
    NSArray *arrSlicesName;
    int totalSlices;
    
    IBOutlet UIView *viewChartCircle;
    IBOutlet UIView *viewPointSummary;
    IBOutlet UIView *viewMemberInfo;
    IBOutlet UILabel *lbNotice;
    IBOutlet UIToolbar *toolBarMenu;
    IBOutlet UILabel *lblToday;
    IBOutlet UILabel *lblMonth;
    IBOutlet UILabel *lblWeek;
    IBOutlet UIButton *btnMonth;
    IBOutlet UIButton *btnToday;
    IBOutlet UIButton *btnWeek;
    
    NSArray *arrButton;
    NSArray *arrLabel;
}

@end

@implementation MainViewController

#define NAVIGATION_BAR 44
#define TAG_OF_VIEW_CIRCLE 400
#define TAG_OF_VIEW_MEMBER_INFO 500
#define TAG_OF_TABLE_VIEW_POINTSUMMARY 600
#define MARGIN_BETWEEN_VIEW 5
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
    self.title = @"Home";
    // Display
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]]];
    [self createButtonOnNavigationBar];
    arrButton = [NSArray arrayWithObjects:btnToday,btnMonth,btnWeek, nil];
    arrLabel = [NSArray arrayWithObjects:lblToday,lblMonth,lblWeek, nil];
    [btnToday setSelected:YES];
  
}

- (void)viewWillAppear:(BOOL)animated{
    [self getCurrentMember];
    [self updateOverDuePromise];
    for(UIButton *abtnCurr in arrButton)
    {
        if([abtnCurr isSelected])
        {
            if (self.aMemberCurr) {
                
                // Member Info
                [self createViewMemberInfo];
                // charting circle
                [abtnCurr setSelected:YES];
                [self createViewChartCircle:abtnCurr.tag];
                
                // Point Summary
                [self createViewPointSummary:btnToday.tag];
                [abtnCurr setUserInteractionEnabled:NO];
                scrollViewContant.hidden = NO;
                lbNotice.hidden = YES;
                toolBarMenu.hidden = NO;
            }else{
                scrollViewContant.hidden = YES;
                lbNotice.hidden = NO;
                toolBarMenu.hidden = YES;
            }

        }
    }
    
}
-(void) createButtonOnNavigationBar
{
    // Button Setting
    UIButton *btnSetting = [UIButton buttonWithType:UIButtonTypeCustom];
    btnSetting.frame = CGRectMake(0, 0, 30, 30);
    [btnSetting setImage:[UIImage imageNamed:@"setting_icon.png"] forState:UIControlStateNormal];
    [btnSetting addTarget:self action:@selector(changeSettingViewController) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *settingBarButton = [[UIBarButtonItem alloc] initWithCustomView:btnSetting];
    self.navigationItem.leftBarButtonItem = settingBarButton;
    
    // Button Member
    UIButton *btnMember = [UIButton buttonWithType:UIButtonTypeCustom];
    btnMember.frame = CGRectMake(0, 0, 30, 30);
    [btnMember setImage:[UIImage imageNamed:@"customer_service.png"] forState:UIControlStateNormal];
    [btnMember addTarget:self action:@selector(changeMemberViewController) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *memberBarButton = [[UIBarButtonItem alloc] initWithCustomView:btnMember];
    self.navigationItem.rightBarButtonItem = memberBarButton;
    
}
-(void) updateOverDuePromise
{
    NSError *error = nil;
    BOOL isUpdatePromise = [[DataHandler sharedManager] updatePromiseOverDue:&error isMember:self.aMemberCurr.idMember DateCurrent:[Utilities getStringCurrentWithDateMMddyyyy]];
    
}
- (void)getCurrentMember{
    NSString *currentIdMember = [Utilities getCurrentUserNameFromUserDefault];
    NSError *error = nil;
    self.aMemberCurr = [[DataHandler sharedManager] allocMemberWithId:currentIdMember error:&error];
}
-(void)createViewMemberInfo
{
    [viewMemberInfo.layer setCornerRadius:10.0f];
    [viewMemberInfo.layer setBorderWidth:1.0f];
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"MemberInfoView" owner:nil options:nil];
    
    MemberInfoView *memberInfoView = (MemberInfoView*)[viewMemberInfo viewWithTag:TAG_OF_VIEW_MEMBER_INFO];
    if (memberInfoView) {
        [memberInfoView removeFromSuperview];
    }
    UIView *aView = nil;
    for(UIView *viewCurr in views)
    {
        if([viewCurr isKindOfClass:[MemberInfoView class]])
        {
            aView = viewCurr;
            [aView setTag:TAG_OF_VIEW_MEMBER_INFO];
            [viewMemberInfo addSubview:aView];
        }
    }
    self.aMemberInfoCurr = (MemberInfoView *) aView;
    [self.aMemberInfoCurr setObjectForView:self.aMemberCurr];

    
}
-(void)createViewChartCircle:(int) index
{
    [viewChartCircle.layer setCornerRadius:10.0f];
    [viewChartCircle.layer setBorderWidth:1.0f];

    CircleView *circleView = (CircleView*)[viewChartCircle viewWithTag:TAG_OF_VIEW_CIRCLE];
    if (circleView) {
        [circleView removeFromSuperview];
    }
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"CircleView" owner:nil options:nil];
        UIView *aView = nil;
        for(UIView *viewCurr in views)
        {
            if([viewCurr isKindOfClass:[CircleView class]])
            {
                aView = viewCurr;
                [aView setTag:TAG_OF_VIEW_CIRCLE];
                [viewChartCircle addSubview:aView];
            }
        }
         CircleView *itemView = (CircleView *) aView;
        itemView.idMemberCurr = self.aMemberCurr.idMember;
        [itemView createCircleSlices:index];

}
-(void)createViewPointSummary:(int) tagOfButton
{
    [viewPointSummary.layer setCornerRadius:10.0f];
    [viewPointSummary.layer setBorderWidth:1.0f];
    
    //TO DO: Remove old Point summary table view
    PointSummaryTableView *pointSummaryTableView = (PointSummaryTableView*)[viewPointSummary viewWithTag:TAG_OF_TABLE_VIEW_POINTSUMMARY];
    if (pointSummaryTableView) {
        [pointSummaryTableView removeFromSuperview];
        pointSummaryTableView = nil;
    }
    
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"PointSummaryTableView" owner:nil options:nil];
    UIView *aView = nil;
    for(UITableView *viewCurr in views)
    {
        if([viewCurr isKindOfClass:[PointSummaryTableView class]])
        {
            aView = viewCurr;
            [aView setTag:TAG_OF_TABLE_VIEW_POINTSUMMARY];
            [viewPointSummary addSubview:aView];
        }
    }
     PointSummaryTableView *aTableView = (PointSummaryTableView *) aView;
    aTableView.idMember = self.aMemberCurr.idMember;
    [aTableView setDataForTableView:tagOfButton];
    
    CGRect framePointSummary = viewPointSummary.frame;
    framePointSummary.size.height = aTableView.frame.size.height + MARGIN_BETWEEN_VIEW;
    viewPointSummary.frame = framePointSummary;
     [scrollViewContant setContentSize:CGSizeMake([Utilities getScreenSize].size.width, viewPointSummary.frame.origin.y + viewPointSummary.frame.size.height + NAVIGATION_BAR)];
}


-(void)changeSettingViewController
{
    SettingViewController *vcSetting = [[SettingViewController alloc] initWithNibName:@"SettingViewController" bundle:nil];
    [self.navigationController pushViewController:vcSetting animated:YES];
}
-(void)changeMemberViewController
{
    MemberViewController *vcMember = [[MemberViewController alloc] initWithNibName:@"MemberViewController" bundle:nil];
    [self.navigationController pushViewController:vcMember animated:YES];
}
// action ToolBar
- (IBAction)changeActivityViewController:(id)sender
{
    ActivityViewController *vcActivity = [[ActivityViewController alloc] initWithNibName:@"ActivityViewController" bundle:nil];
    vcActivity.member = self.aMemberCurr;
    [self.navigationController pushViewController:vcActivity animated:YES];
}
- (IBAction)changePromiseViewController:(id)sender
{
    PromiseViewController *vcPromise = [[PromiseViewController alloc] initWithNibName:@"PromiseViewController" bundle:nil withIdMember:self.aMemberCurr.idMember];
    [self.navigationController   pushViewController:vcPromise animated:YES];
}
- (IBAction)changeFriendViewController:(id)sender
{
    FriendViewController *vcFriend = [[FriendViewController alloc] initWithNibName:@"FriendViewController" bundle:nil];
    [self.navigationController pushViewController:vcFriend animated:YES];
}
- (IBAction)changeHistoryViewController:(id)sender
{
    HistoryViewController *vcHistory = [[HistoryViewController alloc] initWithNibName:@"HistoryViewController" bundle:nil];
    vcHistory.idMember = self.aMemberCurr.idMember;
    [self.navigationController pushViewController:vcHistory animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)getActivity:(id)sender
{
    UIButton *btnCurr = (UIButton *) sender;
    
    for(int i=0; i< [arrButton count]; i++)
    {
        UIButton *aBtn = [arrButton objectAtIndex:i];
        UILabel *aLbl = [arrLabel objectAtIndex:i];
        if([aBtn isEqual:btnCurr])
        {
            [aBtn setSelected:YES];
            [aBtn setUserInteractionEnabled:NO];
            [aLbl setTextColor:[UIColor blackColor]];
            [self createViewChartCircle:aBtn.tag];
            [self createViewPointSummary:aBtn.tag];
        }
        else
        {
            [aBtn setUserInteractionEnabled:YES];
            [aBtn setSelected:NO];
            [aLbl setTextColor:[UIColor whiteColor]];
        }
    }
}


@end
