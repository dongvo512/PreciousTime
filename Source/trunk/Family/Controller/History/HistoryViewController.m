//
//  HistoryViewController.m
//  Family
//
//  Created by Admin on 7/2/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "HistoryViewController.h"
#import "DataHandler.h"
#import "History.h"
@interface HistoryViewController ()
{
    NSMutableArray *arrHistories;
    IBOutlet UITableView *tblContent;
}
@end

@implementation HistoryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#define ITEM 5
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Display
     [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]]];
    self.title = @"History";
    // Data
    [self getDataHistory];
}
-(void) getDataHistory
{
    NSError *error = nil;
    arrHistories = [[DataHandler sharedManager] allocHistoriesWithError:&error idMember:self.idMember];
    [tblContent reloadData];

}
#pragma mark - Table view data source - delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return arrHistories.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"HistoryCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    [cell setBackgroundColor:[UIColor clearColor]];
    
    // don't know to get point history about.
    History *aHistory = [arrHistories objectAtIndex:indexPath.row];
    NSString *strDate = aHistory.date;
    NSString *strActivity = aHistory.activityName;
    NSString *strMemberName = aHistory.memberName;
    NSString *strTime = aHistory.time;
    NSString *strUnitType = [self getUnitType:aHistory.unitType];
    
    [cell.textLabel setFont:[UIFont systemFontOfSize:13]];
    cell.textLabel.text = [NSString stringWithFormat:@"%@:%@ - %@ - %@ %@",strDate,strActivity,strMemberName,strTime,strUnitType];
    cell.imageView.image = [UIImage imageNamed:aHistory.imageUrl];
    return cell;
}
-(NSString *) getUnitType:(int) unitType
{
    NSString *strUnittype = nil;
    switch (unitType) {
        case 0:
            strUnittype = @"Second";
            break;
        case 1:
            strUnittype = @"Minute";
            break;
        case 2:
            strUnittype = @"Hour";
            break;
        default:
            break;
    }
    return strUnittype;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
