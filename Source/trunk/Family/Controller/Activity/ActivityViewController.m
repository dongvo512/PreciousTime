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
#import "BlockActionSheet.h"
#import "ImagePickerViewController.h"
#import "DataHandler.h"
#import "History.h"
#import "Utilities.h"
#import "Member.h"
@interface ActivityViewController ()
{
    NSMutableArray *arrActivities;
    IBOutlet UITableView *tblContent;
    ImagePickerViewController *vcImagePicker;
    IBOutlet UIButton *btnTakePhoto;
    NSMutableArray *arrChosenActivity;
}
- (IBAction)takePhoto:(id)sender;

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
   // [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]]];
    [Utilities setBackGroundForViewWithVersion:self.view];
    self.title = @"Activities";
    [self createBarButtonDone];
    // Data
    //[self createData];
    arrChosenActivity = [NSMutableArray array];
    [self getAllDataForActivity];
}
-(void) createBarButtonDone
{
    // Button Member
    UIButton *btnDone = [UIButton buttonWithType:UIButtonTypeSystem];
    btnDone.frame = CGRectMake(0, 0, 60, 40);
    [btnDone setTitle:@"Done" forState:UIControlStateNormal];
    [btnDone addTarget:self action:@selector(doneActivityPicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc] initWithCustomView:btnDone];
    self.navigationItem.rightBarButtonItem = doneBarButton;

}
-(void)doneActivityPicked
{
    for (Activity *item in arrActivities) {
        if (item.isSelected) {
            NSError *error = nil;
            History *historyItem = [[History alloc] init];
            historyItem.memberName = self.member.name;
            historyItem.activityName = item.name;
            
            if (vcImagePicker.nameImageChosenCurr != nil)
            {
                NSString *documentsDirectory = [Utilities getPathOfDocument];
                NSString *avatarPath = [documentsDirectory stringByAppendingPathComponent:vcImagePicker.nameImageChosenCurr];
                historyItem.imageUrl = avatarPath;
            }
            historyItem.totalPoint = item.point * item.time;
            historyItem.time = [NSString stringWithFormat:@"%d",item.time];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"MM/dd/yyyy"];
            NSString *dateCurr = [formatter stringFromDate:[NSDate date]];
            historyItem.date = dateCurr;
            historyItem.unitType = item.unitTypeValue;
            BOOL isSuccess = [[DataHandler sharedManager] insertHistory:historyItem idMember:self.member.idMember idActivity:item.idActivity error:&error];
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}
//#define ITEMS 7
#define ITEM_CELL 2
/*-(void) createData
{
    arrActivities = [NSMutableArray array];
    // Member data
    for(int i =0; i<ITEMS; i++)
    {
        Activity *aActivity = [[Activity alloc] init];
        
        NSString *strImg = [NSString stringWithFormat:@"activity%d.jpg",i+1];
        aActivity.strAvatar = strImg;
        aActivity.isSelected = NO;
        NSString *strName = [NSString stringWithFormat:@"Activity%d",i+1];
        aActivity.name = strName;
        aActivity.time = 0;
        [arrActivities addObject:aActivity];
    }
    
    
}*/
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
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell setObjectForCell:arrCell];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170;
}
#pragma mark - ActivityTableViewCell Delegate
-(void)editActivitySelectedCell:(Activity *)aActivity
{
    EditActivityViewController *vcEditActivity = [[EditActivityViewController alloc] initWithNibName:@"EditActivityViewController" bundle:nil];
    vcEditActivity.isEditActivityViewController = YES;
    vcEditActivity.aActivityCurr = aActivity;
    vcEditActivity.delegate = self;
    [self.navigationController pushViewController:vcEditActivity animated:YES];
}
-(void)singleTagItemActivity:(Activity *)aActivity
{
    [arrChosenActivity addObject:aActivity];
    [btnTakePhoto setUserInteractionEnabled:YES];
    [tblContent reloadData];
}
-(void)longTagItemActivity:(Activity *)aActivity
{
   if(arrChosenActivity.count >0)
   {
    [arrChosenActivity removeObject:aActivity];
    if([arrChosenActivity count] == 0)
        [btnTakePhoto setUserInteractionEnabled:NO];
    [tblContent reloadData];
   }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - take photo
- (IBAction)takePhoto:(id)sender
{
    vcImagePicker = [[ImagePickerViewController alloc] init];
    BlockActionSheet *blockActionSheet = [[BlockActionSheet alloc] initWithTitle:nil];
    [blockActionSheet setCancelButtonWithTitle:@"Cancel" block:^{
        NSLog(@"Cancel");
    }];
    [blockActionSheet addButtonWithTitle:@"Take Photo" block:^{
        //NSLog(@"Take a Picture");
        [vcImagePicker takeAPickture:self];
    }];
    [blockActionSheet addButtonWithTitle:@"Camera Roll" block:^{
        // NSLog(@"Camera Roll");
        [vcImagePicker cameraRoll:self];
    }];
    [blockActionSheet showInView:self.view];

}


- (IBAction)changeAddNewActivityViewController:(id)sender
{
    EditActivityViewController *vcEditActivity = [[EditActivityViewController alloc] initWithNibName:@"EditActivityViewController" bundle:nil];
    vcEditActivity.isEditActivityViewController = NO;
    vcEditActivity.delegate = self;
    [self.navigationController pushViewController:vcEditActivity animated:YES];

}
#pragma mark - EditActivityViewController Delete
-(void)reloadDataActivity
{
    [self getAllDataForActivity];
}
#pragma mark - get Data Activity
-(void) getAllDataForActivity
{
    [arrActivities removeAllObjects];
    NSError *error = nil;
    arrActivities = [[DataHandler sharedManager] allocAcitivitiesWithError:&error];
    [tblContent reloadData];
}
@end
