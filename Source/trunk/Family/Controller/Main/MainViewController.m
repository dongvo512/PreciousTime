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
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]]];
    [self createButtonOnNavigationBar];
    // Member Info
    [self createViewMemberInfo];
    // charting circle
    [self createViewChartCircle];
    // Point Summary
    [self createViewPointSummary];
    
    [scrollViewContant setContentSize:CGSizeMake([Utilities getScreenSize].size.width, viewPointSummary.frame.origin.y + viewPointSummary.frame.size.height + NAVIGATION_BAR)];
    
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

-(void) createViewMemberInfo
{
    [viewMemberInfo.layer setCornerRadius:10.0f];
    [viewMemberInfo.layer setBorderWidth:1.0f];
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"MemberInfoView" owner:nil options:nil];
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
-(void)createViewChartCircle
{
    [viewChartCircle.layer setCornerRadius:10.0f];
    [viewChartCircle.layer setBorderWidth:1.0f];
    
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
        [itemView createCircleSlices];

}
-(void)createViewPointSummary
{
    [viewPointSummary.layer setCornerRadius:10.0f];
    [viewPointSummary.layer setBorderWidth:1.0f];
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
    [aTableView setDataForTableView];
    
    CGRect framePointSummary = viewPointSummary.frame;
    framePointSummary.size.height = aTableView.frame.size.height + MARGIN_BETWEEN_VIEW;
    viewPointSummary.frame = framePointSummary;
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
    [self.navigationController pushViewController:vcActivity animated:YES];
}
- (IBAction)changePromiseViewController:(id)sender
{
    PromiseViewController *vcPromise = [[PromiseViewController alloc] initWithNibName:@"PromiseViewController" bundle:nil];
    vcPromise.idMemberCurr = self.aMemberCurr.idMember;
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
    [self.navigationController pushViewController:vcHistory animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
