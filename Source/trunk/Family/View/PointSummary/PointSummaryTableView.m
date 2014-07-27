//
//  PointSummaryTableView.m
//  Family
//
//  Created by Admin on 7/10/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "PointSummaryTableView.h"
#import "Activity.h"
#import "Promise.h"
#import "DataHandler.h"
#import "History.h"
#import "contant.h"
#import "Utilities.h"
@interface PointSummaryTableView()
{
    NSMutableArray *arrPointSummary;
    NSArray *arrGenPointSummaryGen;
}
@end
@implementation PointSummaryTableView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void) setDataForTableView:(int) index
{
    arrGenPointSummaryGen = [NSArray arrayWithObjects:@"Activity point",@"Promise", nil];
    //arrPointSummary = [NSMutableArray array];
    arrPointSummary = [NSMutableArray array];
    
    [arrPointSummary addObject:[self allocDataActivity:index]];
    [arrPointSummary addObject:[self allocDataPromise:index]];
    
    self.delegate = self;
    self.dataSource = self;
    [self reloadData];
   // [self reSizeForTableViewContent];
}
-(NSMutableArray *)allocDataActivity:(int) index
{
    NSMutableArray *arrHistoryCurr = nil;
    if (self.idMember)
    {
        NSError *error = nil;
        
        switch (index) {
            case TAG_OF_BUTON_DAY:
            {
                arrHistoryCurr = [[DataHandler sharedManager] allocHistoryWithDay:self.idMember dayCurrent:[Utilities getStringCurrentWithDateMMddyyyy] error:&error];
                break;
            }
            case TAG_OF_BUTTON_WEEK:
            {
                 NSString *strBeforeDate = [Utilities getDateBefore:-7];
                arrHistoryCurr = [[DataHandler sharedManager] allocHistoryWithWeekAndMonth:self.idMember dayCurrent:[Utilities getStringCurrentWithDateMMddyyyy] BeforeWeekandMonth:strBeforeDate error:&error];
                break;
            }
            case TAG_OF_BUTTON_MONTH:
            {
                NSString *strBeforeDate = [Utilities getDateBefore:-30];
                arrHistoryCurr = [[DataHandler sharedManager] allocHistoryWithWeekAndMonth:self.idMember dayCurrent:[Utilities getStringCurrentWithDateMMddyyyy] BeforeWeekandMonth:strBeforeDate error:&error];
                break;
            }
                
            default:
                break;
        }
         return arrHistoryCurr;
    }
    else
        return nil;
}
-(NSMutableArray *)allocDataPromise:(int) index
{
    NSMutableArray *arrPromiseCurr = nil;
    if (self.idMember)
    {
        NSError *error = nil;
        switch (index) {
            case TAG_OF_BUTON_DAY:
            {
                NSMutableArray *arrData = [NSMutableArray array];
                NSMutableArray *arrayPromiseWithDone = nil;
                NSMutableArray *arrayPromiseWithOverDue = nil;
                
                arrayPromiseWithDone = [[DataHandler sharedManager] allocDonePromiseDayWithError:&error idMember:self.idMember dateCurrent:[Utilities getStringCurrentWithDateMMddyyyy]];
                if(arrayPromiseWithDone != nil)
                   [arrData addObjectsFromArray:arrayPromiseWithDone];
                
                arrayPromiseWithOverDue = [[DataHandler sharedManager] allocOverDuePromiseDayWithError:&error idMember:self.idMember dateCurrent:[Utilities getStringCurrentWithDateMMddyyyy]];
                if(arrayPromiseWithOverDue != nil)
                    [arrData addObjectsFromArray:arrayPromiseWithOverDue];
                arrPromiseCurr = arrData;
                break;
            }
            case TAG_OF_BUTTON_WEEK:
            {
                NSString *strBeforeDate = [Utilities getDateBefore:-7];
                arrPromiseCurr = [[DataHandler sharedManager] allocDoneOverDuePromiseWeekMonthWithError:&error idMember:self.idMember DayCurrent:[Utilities getStringCurrentWithDateMMddyyyy] BeforeDate:strBeforeDate];
                break;
            }
            case TAG_OF_BUTTON_MONTH:
            {
                NSString *strBeforeDate = [Utilities getDateBefore:-30];
                arrPromiseCurr = [[DataHandler sharedManager] allocDoneOverDuePromiseWeekMonthWithError:&error idMember:self.idMember DayCurrent:[Utilities getStringCurrentWithDateMMddyyyy] BeforeDate:strBeforeDate];
                break;
            }
                
            default:
                break;
        }
        return arrPromiseCurr;
    }
    else
        return nil;

}
#pragma mark - Table view data source - delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return arrPointSummary.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [[arrPointSummary objectAtIndex:section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"PointSummary"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    [cell setBackgroundColor:[UIColor clearColor]];
    
   if(indexPath.section == 0)
   {
       History *history = [[arrPointSummary objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
       NSString *strPointActivity = [NSString stringWithFormat:@"%d point for %@",history.totalPoint,history.activityName];
       cell.textLabel.text = strPointActivity;
   }
    else
    {
        Promise *aPromise = [[arrPointSummary objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        NSString *strPromise = @"";
        if (aPromise.status == 1) {
            strPromise = [NSString stringWithFormat:@"%@ Done",aPromise.name];

        }else if(aPromise.status == 2){
            strPromise = [NSString stringWithFormat:@"%@ Overdue",aPromise.name];

        }
        cell.textLabel.text = strPromise;
    }
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HEIGHT_CELL;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return HEIGHT_TITLE_FOR_HEADER;
}
/*-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [arrGenPointSummaryGen objectAtIndex:section];
}*/
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = nil;
    headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, HEIGHT_TITLE_FOR_HEADER)];
    headerView.layer.masksToBounds = NO;
    headerView.layer.shadowColor = [UIColor blackColor].CGColor;
    headerView.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    headerView.layer.shadowOpacity = 0.5f;
   // headerView.layer.shadowPath = shadowPath.CGPath;
    
    UILabel *tempLabel=[[UILabel alloc]initWithFrame:CGRectMake(8,5,300,25)];
    tempLabel.numberOfLines = 2;
    tempLabel.backgroundColor=[UIColor clearColor];
    tempLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    tempLabel.textColor = [UIColor whiteColor];
    
    NSString * headerText = [arrGenPointSummaryGen objectAtIndex:section];
    tempLabel.text= headerText;
    [headerView addSubview:tempLabel];
    return headerView;
  }
@end
