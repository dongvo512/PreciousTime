//
//  CircleView.m
//  Family
//
//  Created by Admin on 7/6/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "CircleView.h"
#import "Activity.h"
#import "DataHandler.h"
#import "contant.h"
#import "History.h"
#import "SlicesActivityTableViewCell.h"
#import "Utilities.h"
@interface CircleView()
{
    IBOutlet XYPieChart *pieChart;
    IBOutlet UILabel *lblPercentagel;
    NSMutableArray *arrSlices;
    NSArray *arrSlicesColor;
    NSArray *arrSlicesName;
    int totalSlices;
    IBOutlet UITableView *tblViewSliceActivity;

}
@end
@implementation CircleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void) createCircleSlices:(int) index
{
    [self createListSlicesName];
    [self createListSlicesColor];
    [self createSlices:index];
    //[tblViewSliceActivity reloadData];
    tblViewSliceActivity.delegate = self;
    tblViewSliceActivity.dataSource = self;
}

-(void) createSlices:(int) index
{
    arrSlices = [NSMutableArray array];
    NSMutableArray *arrData = nil;
    
    if (self.idMemberCurr)
    {
        NSError *error = nil;
        switch (index) {
            case TAG_OF_BUTON_DAY:
            {
                arrData = [[DataHandler sharedManager] allocHistoryWithDay:self.idMemberCurr dayCurrent:[Utilities getStringCurrentWithDateMMddyyyy] error:&error];
                break;
            }
            case TAG_OF_BUTTON_WEEK:
            {
                NSString *strBeforeDate = [Utilities getDateBefore:-7];
                arrData = [[DataHandler sharedManager] allocHistoryWithWeekAndMonth:self.idMemberCurr dayCurrent:[Utilities getStringCurrentWithDateMMddyyyy] BeforeWeekandMonth:strBeforeDate error:&error];
                break;
            }
            case TAG_OF_BUTTON_MONTH:
            {
                NSString *strBeforeDate = [Utilities getDateBefore:-30];
                arrData = [[DataHandler sharedManager] allocHistoryWithWeekAndMonth:self.idMemberCurr dayCurrent:[Utilities getStringCurrentWithDateMMddyyyy] BeforeWeekandMonth:strBeforeDate error:&error];
                break;
            }
   
            default:
                break;
        }
    }
    int totalPointOther = 0;
    if(arrData.count > 0)
    {
        for(int i =0; i< [arrData count]; i++)
        {
            History *aHistory = [arrData objectAtIndex:i];
            if(i >= MAX_ITEM_CHART_CIRCLE -1)
            {
                totalPointOther += aHistory.totalPoint;
                if(i == [arrData count]- 1)
                {
                    History *aHistoryOther = [[History alloc] init];
                    aHistoryOther.activityName = @"Other";
                    aHistoryOther.totalPoint = totalPointOther;
                    [arrSlices addObject:aHistoryOther];
                }
            }
            else
            {
                [arrSlices addObject:aHistory];
            }
        }
        [self setupForPieChart];
    }
    else
    {
        [lblPercentagel setHidden:YES];
        [tblViewSliceActivity setHidden:YES];
    }
   
}
-(void)setupForPieChart
{
    [pieChart setDataSource:self];
    [pieChart setStartPieAngle:M_PI_2];
    [pieChart setAnimationSpeed:1.0];
    [pieChart setLabelFont:[UIFont fontWithName:@"DBLCDTempBlack" size:12]];
    [pieChart setLabelRadius:pieChart.frame.size.height/3];
    [pieChart setShowPercentage:YES];
    [lblPercentagel.layer setCornerRadius:lblPercentagel.frame.size.width/2];
    //[pieChart setPieBackgroundColor:[UIColor colorWithWhite:0.95 alpha:1]];
    [pieChart setPieBackgroundColor:[UIColor clearColor]];
    [pieChart setUserInteractionEnabled:YES];
    [pieChart setLabelShadowColor:[UIColor blackColor]];
    [pieChart reloadData];

}
-(void) createListSlicesColor
{
    arrSlicesColor =[NSArray arrayWithObjects:
                     [UIColor colorWithRed:246/255.0 green:155/255.0 blue:0/255.0 alpha:1],
                     [UIColor colorWithRed:248/255.0 green:8/255.0 blue:36/255.0 alpha:1],
                      [UIColor colorWithRed:138/255.0 green:15/255.0 blue:242/255.0 alpha:1],
                     [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1],
                     [UIColor colorWithRed:129/255.0 green:195/255.0 blue:29/255.0 alpha:1],
                     [UIColor colorWithRed:62/255.0 green:173/255.0 blue:219/255.0 alpha:1],
                     [UIColor colorWithRed:245/255.0 green:133/255.0 blue:238/255.0 alpha:1],
                     [UIColor colorWithRed:10/255.0 green:38/255.0 blue:243/255.0 alpha:1],
                     [UIColor colorWithRed:228/255.0 green:242/255.0 blue:67/255.0 alpha:1],
                     [UIColor colorWithRed:120/255.0 green:120/255.0 blue:110/255.0 alpha:1],nil];
    
}
-(void) createListSlicesName
{
    arrSlicesName = [NSArray arrayWithObjects:@"WatchTV",@"Bicycle",@"Swim",@"Soccer",@"Video Game", nil];
}
#pragma mark - XYPieChart Data Source

- (NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart
{
    NSLog(@"%d", arrSlices.count);
    return arrSlices.count;
}

- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index
{
    //return [[self.slices objectAtIndex:index] intValue];
    int aItemSlice = [[arrSlices objectAtIndex:index] totalPoint];
    totalSlices += aItemSlice;
    lblPercentagel.text = [NSString stringWithFormat:@"%d",totalSlices];
    return aItemSlice;
}

- (UIColor *)pieChart:(XYPieChart *)pieChart colorForSliceAtIndex:(NSUInteger)index
{
    return [arrSlicesColor objectAtIndex:index];
}
#pragma mark TableView DataSource - Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [arrSlices count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SliceActivity";
    SlicesActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSArray *arrObj = [[NSBundle mainBundle] loadNibNamed:@"SlicesActivityTableViewCell" owner:nil options:nil];
    
    for(id curObject in arrObj)
    {
        if([curObject isKindOfClass:[UITableViewCell class]])
        {
            cell = (SlicesActivityTableViewCell *)curObject;
            break;
        }
    }
    // Configure the cell...
    [cell setBackgroundColor:[UIColor clearColor]];
    History *aHistory = [arrSlices objectAtIndex:indexPath.row];
    cell.colorCurr = [arrSlicesColor objectAtIndex:indexPath.row];
    [cell setObjectForCell:aHistory];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 25;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
