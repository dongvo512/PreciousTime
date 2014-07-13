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
@interface ActivityViewController ()
{
    NSMutableArray *arrActivities;
    IBOutlet UITableView *tblContent;
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
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]]];
    self.title = @"Activities";
    [self createBarButtonDone];
    // Data
    //[self createData];
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
    NSError *error = nil;
    /*Activity *activity = [[Activity alloc] init];
    activity.name = @"Bicycle";
    activity.unitTypeValue = 0;
    activity.strAvatar = @"http://www.picturesnew.com/media/images/images_of_nature.jpg";
    activity.point = 10;*/
    
    
  //  NSString *idActivity = nil;
   // BOOL isSuccess = [[DataHandler sharedManager] insertActivity:aActivity isSync:false idActivity:&idActivity error:&error];
   // aActivity.idActivity = idActivity;
   BOOL isSuccess = [[DataHandler sharedManager] updateActivityInfo:aActivity isSync:false error:&error];
    NSAssert(isSuccess, error.description);

    [tblContent reloadData];
}
-(void)longTagItemActivity
{
       [tblContent reloadData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)takePhoto:(id)sender
{
    ImagePickerViewController *vcImagePicker = [[ImagePickerViewController alloc] init];
    BlockActionSheet *blockActionSheet = [[BlockActionSheet alloc] initWithTitle:nil];
    [blockActionSheet setCancelButtonWithTitle:@"Cancel" block:^{
        NSLog(@"Cancel");
    }];
    [blockActionSheet addButtonWithTitle:@"Take a Picker" block:^{
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
