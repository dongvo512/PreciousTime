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
#import "HistoryTableViewCell.h"
#import "Utilities.h"
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
    HistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSArray *arrObj = [[NSBundle mainBundle] loadNibNamed:@"HistoryTableViewCell" owner:nil options:nil];
    
    for(id curObject in arrObj)
    {
        if([curObject isKindOfClass:[UITableViewCell class]])
        {
            cell = (HistoryTableViewCell *)curObject;
            break;
        }
    }
    [cell setBackgroundColor:[UIColor clearColor]];
    
    History *aHistory = [arrHistories objectAtIndex:indexPath.row];
    [cell setObjectForCell:aHistory];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
