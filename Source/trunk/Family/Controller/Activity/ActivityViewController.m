//
//  ActivityViewController.m
//  Family
//
//  Created by Admin on 7/2/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "ActivityViewController.h"
#import "Activity.h"
#import "ActivityTableViewCell.h"
#import "EditActivityViewController.h"
@interface ActivityViewController ()
{
    NSMutableArray *arrActivities;
}
- (IBAction)changeAddNewActivityViewController:(id)sender;
@end

@implementation ActivityViewController

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
    // Do any additional setup after loading the view from its nib.
    // Display
    self.title = @"Activities";
    [self createBarButtonDone];
    // Data
    [self createData];
}
-(void) createBarButtonDone
{
    // Button Member
    UIButton *btnDone = [UIButton buttonWithType:UIButtonTypeCustom];
    btnDone.frame = CGRectMake(0, 0, 60, 40);
    [btnDone setImage:[UIImage imageNamed:@"btn_done.png"] forState:UIControlStateNormal];
    [btnDone addTarget:self action:@selector(doneActivityPicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc] initWithCustomView:btnDone];
    self.navigationItem.rightBarButtonItem = doneBarButton;

}
-(void)doneActivityPicked
{
    
}
#define ITEMS 7
#define ITEM_CELL 2
-(void) createData
{
    arrActivities = [NSMutableArray array];
    // Member data
    for(int i =0; i<ITEMS; i++)
    {
        Activity *aActivity = [[Activity alloc] init];
        
        NSString *strImg = [NSString stringWithFormat:@"activity%d.jpg",i+1];
        UIImage *imgCurr = [UIImage imageNamed:strImg];
        aActivity.avatar = imgCurr;
        
        NSString *strName = [NSString stringWithFormat:@"Activity%d",i+1];
        aActivity.name = strName;
    
        [arrActivities addObject:aActivity];
    }
    
    
}
#pragma mark - Table view data source - delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    int numberOfRows = ceilf((float)arrActivities.count/ITEM_CELL);
    
    return numberOfRows;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *arrCell = [NSMutableArray array];
    int index = indexPath.row *ITEM_CELL;
    NSLog(@"%d",arrActivities.count);
    for(int i= index; i <= index +1; i++)
    {
        if(i < arrActivities.count)
        {
            Activity *aActivity = [arrActivities objectAtIndex:i];
            [arrCell addObject:aActivity];
        }
    }
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"CellActivity"];
    ActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil)
    {
        cell = [[ActivityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.delegate = self;
    [cell setObjectForCell:arrCell];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170;
}
#pragma mark - ActivityTableViewCell Delegate
-(void)itemMemberSelectedCell:(id)sender
{
    EditActivityViewController *vcEditActivity = [[EditActivityViewController alloc] initWithNibName:@"EditActivityViewController" bundle:nil];
    vcEditActivity.isEditActivityViewController = YES;
    [self.navigationController pushViewController:vcEditActivity animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeAddNewActivityViewController:(id)sender
{
    EditActivityViewController *vcEditActivity = [[EditActivityViewController alloc] initWithNibName:@"EditActivityViewController" bundle:nil];
    vcEditActivity.isEditActivityViewController = NO;
    [self.navigationController pushViewController:vcEditActivity animated:YES];

}
@end
