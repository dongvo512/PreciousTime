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
@interface PointSummaryTableView()
{
    NSMutableArray *arrActivities;
    NSMutableArray *arrPromise;
    NSMutableArray *arrPointSummary;
    NSArray *arrGenPointSummaryGen;
}
@end
@implementation PointSummaryTableView
#define ITEM_ACTIVITY 5
#define ITEM_PROMISE 2
#define HEIGHT_CELL 30
#define HEIGHT_TITLE_FOR_HEADER 30
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(void) reSizeForTableView
{
    CGRect frameSelf = self.frame;
    frameSelf.size.height = HEIGHT_CELL * (ITEM_ACTIVITY + ITEM_PROMISE )+ arrGenPointSummaryGen.count *HEIGHT_TITLE_FOR_HEADER;
    self.frame = frameSelf;
}
-(void) setDataForTableView
{
    arrGenPointSummaryGen = [NSArray arrayWithObjects:@"Activity point",@"Promise", nil];
    arrPointSummary = [NSMutableArray array];
    [arrPointSummary addObject:[self allocDataActivity]];
    [arrPointSummary addObject:[self allocDataPromise]];
    self.delegate = self;
    self.dataSource = self;
    [self reSizeForTableView];
}
-(NSMutableArray *)allocDataActivity
{
    arrActivities = [NSMutableArray array];
    // Member data
    for(int i =0; i<ITEM_ACTIVITY; i++)
    {
        Activity *aActivity = [[Activity alloc] init];
        
        NSString *strImg = [NSString stringWithFormat:@"activity%d.jpg",i+1];
     
        aActivity.strAvatar = strImg;
        aActivity.dirty = 1;
        NSString *strName = [NSString stringWithFormat:@"Activity%d",i+1];
        aActivity.name = strName;
        aActivity.time = 5;
        aActivity.point = 20 + i;
        [arrActivities addObject:aActivity];
    }
    return arrActivities;
}
-(NSMutableArray *)allocDataPromise
{
    arrPromise = [NSMutableArray array];
    for(int i =0; i< ITEM_PROMISE; i++)
    {
        Promise *aPromise = [[Promise alloc] init];
        aPromise.name = [NSString stringWithFormat:@"Promise %d",i+1];
        NSString *strDate = [NSString stringWithFormat:@"June %i,2014",i+5];
        aPromise.dueDate = strDate;
        aPromise.description = [NSString stringWithFormat:@"Walking with my son %d",i +1];
        aPromise.isPick = NO;
        [arrPromise addObject:aPromise];
    }
    return arrPromise;
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
       Activity *aActivity = [arrActivities objectAtIndex:indexPath.row];
       NSString *strPointActivity = [NSString stringWithFormat:@"%d point/%d minutes for %@",aActivity.point,aActivity.time,aActivity.name];
       cell.textLabel.text = strPointActivity;
   }
    else
    {
        Promise *aPromise = [arrPromise objectAtIndex:indexPath.row];
        NSString *strPromise = [NSString stringWithFormat:@"%@ overdue",aPromise.name];
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
