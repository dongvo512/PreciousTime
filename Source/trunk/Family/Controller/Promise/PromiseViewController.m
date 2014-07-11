//
//  PromiseViewController.m
//  Family
//
//  Created by Admin on 7/2/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "PromiseViewController.h"
#import "Promise.h"
#import "PromiseTableViewCell.h"
#import "EditPromiseViewController.h"
@interface PromiseViewController ()
{
    NSMutableArray *arrPromise;
    IBOutlet UITableView *tblViewPromise;
}
- (IBAction)changeAddNewPrimiseViewController:(id)sender;

@end

@implementation PromiseViewController

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
    self.title = @"Promise";
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]]];
    [self createBarButtonDone];
    //Data
    [self createData];
}
-(void) createBarButtonDone
{
    // Button Member
    UIButton *btnDone = [UIButton buttonWithType:UIButtonTypeSystem];
    btnDone.frame = CGRectMake(0, 0, 60, 40);
    [btnDone setTitle:@"Done" forState:UIControlStateNormal];
    [btnDone addTarget:self action:@selector(donePromise) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc] initWithCustomView:btnDone];
    self.navigationItem.rightBarButtonItem = doneBarButton;
    
}
-(void) donePromise
{
    
}
#define ITEM 5
-(void) createData
{
    arrPromise = [NSMutableArray array];
    for(int i =0; i< ITEM; i++)
    {
        Promise *aPromise = [[Promise alloc] init];
        aPromise.name = [NSString stringWithFormat:@"Promise %d",i+1];
        NSString *strDate = [NSString stringWithFormat:@"June %i,2014",i+5];
        aPromise.dueDate = strDate;
        aPromise.description = [NSString stringWithFormat:@"Walking with my son %d",i +1];
        aPromise.isPick = NO;
        [arrPromise addObject:aPromise];
    }
}
#pragma mark - Table view data source - delegate
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
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.delegate = self;
    [cell setBackgroundColor:[UIColor clearColor]];
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
}

#define MARGIN 10
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.contentView.backgroundColor = [UIColor clearColor];
    UIView *whiteRoundedCornerView = [[UIView alloc] initWithFrame:CGRectMake(MARGIN,MARGIN,self.view.frame.size.width - MARGIN*2,cell.frame.size.height - MARGIN *2 )];
    whiteRoundedCornerView.layer.borderWidth = 0.2f;
    whiteRoundedCornerView.backgroundColor = [UIColor whiteColor];
    whiteRoundedCornerView.layer.masksToBounds = NO;
    whiteRoundedCornerView.layer.cornerRadius = 10.0f;
    [whiteRoundedCornerView setBackgroundColor:[UIColor clearColor]];
    [cell.contentView addSubview:whiteRoundedCornerView];
    [cell.contentView sendSubviewToBack:whiteRoundedCornerView];
}
#pragma mark - PromiseTableViewCell Delegate
-(void) reloadTableViewWithButtonCell
{
    [tblViewPromise reloadData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeAddNewPrimiseViewController:(id)sender
{
    EditPromiseViewController *vcEditPromise = [[EditPromiseViewController alloc] initWithNibName:@"EditPromiseViewController" bundle:nil];
    vcEditPromise.isEditPromiseViewController = NO;
    [self.navigationController pushViewController:vcEditPromise animated:YES];
}
@end
