//
//  MemberViewController.m
//  Family
//
//  Created by Admin on 7/1/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "MemberViewController.h"
#import "AddMemberViewController.h"
#import "Member.h"
#import "MemberTableViewCell.h"
#import "MainViewController.h"
@interface MemberViewController ()
{
    NSMutableArray *arrMembers;
    
}
@end

@implementation MemberViewController

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
    // Display
    self.title = @"Member";
    [self customizeBackButton];
    [self createAddNewMember];
    // Data
    [self createData];

    // Do any additional setup after loading the view from its nib.
}
-(void)createAddNewMember
{
    UIButton *btnAddMember = [UIButton buttonWithType:UIButtonTypeCustom];
    btnAddMember.frame = CGRectMake(0, 0, 30, 30);
    [btnAddMember setImage:[UIImage imageNamed:@"add_user.png"] forState:UIControlStateNormal];
    [btnAddMember addTarget:self action:@selector(addNewMember) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *memberAddBarButton = [[UIBarButtonItem alloc] initWithCustomView:btnAddMember];
    
    self.navigationItem.rightBarButtonItem = memberAddBarButton;

}
-(void)addNewMember
{
    AddMemberViewController *vcAddMember = [[AddMemberViewController alloc] initWithNibName:@"AddMemberViewController" bundle:nil];
    vcAddMember.isAddNewMember = YES;
    [self.navigationController pushViewController:vcAddMember animated:YES];
}
-(void)customizeBackButton
{
    // Button Member
    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    btnBack.frame = CGRectMake(0, 0, 30, 30);
    [btnBack setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc] initWithCustomView:btnBack];

    self.navigationItem.leftBarButtonItem = backBarButton;
}
-(void) popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}
// Data
#define ITEMS 7
#define ITEM_CELL 2
-(void) createData
{
    arrMembers = [NSMutableArray array];
    // Member data
    for(int i =0; i<ITEMS; i++)
    {
        Member *aMember = [[Member alloc] init];
        
        NSString *strImg = [NSString stringWithFormat:@"hinh%d.jpg",i+1];
        UIImage *imgCurr = [UIImage imageNamed:strImg];
        aMember.avatar = imgCurr;
        
        NSString *strName = [NSString stringWithFormat:@"Member%d",i+1];
        aMember.name = strName;
        
        aMember.gender = @"Male";
        aMember.bithday = @"05/12/1989";
        aMember.relationship = @"Brother";
        
        [arrMembers addObject:aMember];
    }
    
    
}
#pragma mark - Table view data source - delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    int numberOfRows = ceilf((float)arrMembers.count/ITEM_CELL);
   
    return numberOfRows;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *arrCell = [NSMutableArray array];
    int index = indexPath.row *ITEM_CELL;
    NSLog(@"%d",arrMembers.count);
    for(int i= index; i <= index +1; i++)
    {
        if(i < arrMembers.count)
        {
            Member *aMember = [arrMembers objectAtIndex:i];
            [arrCell addObject:aMember];
        }
    }
    
   NSString *CellIdentifier = [NSString stringWithFormat:@"CellMember"];
    MemberTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil)
    {
        cell = [[MemberTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.delegate = self;
    [cell setObjectForCell:arrCell];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170;
}
#pragma marks - Delegate
-(void)editMemberSelectedCell:(id)sender MemberCurrent:(Member *)aMember
{
    AddMemberViewController *vcAddMemViewController = [[AddMemberViewController alloc] init];
    vcAddMemViewController.isAddNewMember = NO;
    [self.navigationController pushViewController:vcAddMemViewController animated:YES];
}
-(void)itemMemberSelectedCell:(id)sender MemberCurrent:(Member *)aMember
{
     NSArray *arrViewController = [self.navigationController viewControllers];
    MainViewController *vcMain = [arrViewController objectAtIndex:0];
    vcMain.aMemberCurr = aMember;
    [vcMain createViewMemberInfo];
    [self.navigationController popToViewController:vcMain animated:YES];
   
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
