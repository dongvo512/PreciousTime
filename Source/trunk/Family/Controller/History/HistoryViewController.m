//
//  HistoryViewController.m
//  Family
//
//  Created by Admin on 7/2/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()

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
    self.title = @"History";
    // Do any additional setup after loading the view from its nib.
}
-(void) createData
{
}
/*#pragma mark - Table view data source - delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return arrPromise.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PromiseCell";
    PromiseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSArray *arrObj = [[NSBundle mainBundle] loadNibNamed:@"PromiseTableViewCell" owner:nil options:nil];
    
    for(id curObject in arrObj)
    {
        if([curObject isKindOfClass:[UITableViewCell class]])
        {
            cell = (PromiseTableViewCell *)curObject;
            break;
        }
    }
    Promise *aPromise = [arrPromise objectAtIndex:indexPath.row];
    cell.delegate = self;
    [cell setObjectForCell:aPromise];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EditPromiseViewController *vcEditPromise = [[EditPromiseViewController alloc] initWithNibName:@"EditPromiseViewController" bundle:nil];
    vcEditPromise.aPromise = [arrPromise objectAtIndex:indexPath.row];
    vcEditPromise.isEditPromiseViewController = YES;
    [self.navigationController pushViewController:vcEditPromise animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}*/
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
