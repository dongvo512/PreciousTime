//
//  CircleView.m
//  Family
//
//  Created by Admin on 7/6/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "CircleView.h"
#import "Activity.h"
#import "SlicesActivityTableViewCell.h"
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
-(void) createCircleSlices
{
    [self createListSlicesName];
    [self createListSlicesColor];
    [self createSlices];
    //[tblViewSliceActivity reloadData];
    tblViewSliceActivity.delegate = self;
    tblViewSliceActivity.dataSource = self;
}

-(void) createSlices
{
    
    arrSlices = [NSMutableArray arrayWithCapacity:10];
    
    for(int i = 0; i < 5; i ++)
    {
        Activity *itemActivity = [[Activity alloc] init];
        //itemActivity.point = [NSNumber numberWithInt:rand()%60+20];
        itemActivity.point = rand()%60 +20;
        itemActivity.name = [arrSlicesName objectAtIndex:i];
        itemActivity.color = [arrSlicesColor objectAtIndex:i];
        [arrSlices addObject:itemActivity];
    }
    
    [pieChart setDataSource:self];
    [pieChart setStartPieAngle:M_PI_2];
    [pieChart setAnimationSpeed:1.0];
    [pieChart setLabelFont:[UIFont fontWithName:@"DBLCDTempBlack" size:14]];
    [pieChart setLabelRadius:pieChart.frame.size.height/4];
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
                     [UIColor colorWithRed:129/255.0 green:195/255.0 blue:29/255.0 alpha:1],
                     [UIColor colorWithRed:62/255.0 green:173/255.0 blue:219/255.0 alpha:1],
                     [UIColor colorWithRed:229/255.0 green:66/255.0 blue:115/255.0 alpha:1],
                     [UIColor colorWithRed:148/255.0 green:141/255.0 blue:139/255.0 alpha:1],nil];
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
    int aItemSlice = [[arrSlices objectAtIndex:index] point];
    totalSlices += aItemSlice;
    lblPercentagel.text = [NSString stringWithFormat:@"%d",totalSlices];
    return aItemSlice;
}

- (UIColor *)pieChart:(XYPieChart *)pieChart colorForSliceAtIndex:(NSUInteger)index
{
    return [[arrSlices objectAtIndex:index] color];
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
    Activity *aActivity = [arrSlices objectAtIndex:indexPath.row];
    [cell setObjectForCell:aActivity];
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
