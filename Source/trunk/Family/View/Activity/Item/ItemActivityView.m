//
//  ItemActivityView.m
//  Family
//
//  Created by Admin on 7/2/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "ItemActivityView.h"
#import "EditActivityViewController.h"
@interface ItemActivityView()
{
    IBOutlet UIImageView *imgAvatar;
    IBOutlet UILabel *lblNameActivity;

    IBOutlet UIView *viewBackGround;
    IBOutlet UILabel *lblTime;
    Activity *aActivityCurrent;
}
- (IBAction)changeEditActivityViewController:(id)sender;

@end
@implementation ItemActivityView
#define TIME_DEFAULT 0
#define TIME_UP 5
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void) setDataForItemView:(Activity *) aActivity
{
    aActivityCurrent = aActivity;
    if(aActivity.isSelected)
       [viewBackGround setBackgroundColor:[UIColor yellowColor]];
    else
        [viewBackGround setBackgroundColor:[UIColor clearColor]];
    
        NSData *data = [[NSFileManager defaultManager] contentsAtPath:aActivity.strAvatar];
       UIImage *imgCurr = [UIImage imageNamed:aActivity.strAvatar];
    //imgAvatar.image = [UIImage imageNamed:aActivity.strAvatar];
    if(data != nil)
    {
        imgAvatar.image = [UIImage imageWithData:data];
    }
    else if(imgCurr != nil)
    {
         imgAvatar.image = imgCurr;
    }
    else
        imgAvatar.image = [UIImage imageNamed:@"icon_FamLink2.png"];
    
    lblNameActivity.text = aActivity.name;
    [self loadDataTime:aActivity];
      [self radiusViewBackGround];
   }
-(void) loadDataTime :(Activity *) aActivity
{
    if(aActivity.time == 0)
        [lblTime setHidden:YES];
    else
    {
        [lblTime setHidden:NO];
        switch (aActivity.unitTypeValue) {
            case 0:
                lblTime.text = [NSString stringWithFormat:@"%ds",aActivity.time];
                break;
            case 1:
                lblTime.text = [NSString stringWithFormat:@"%dm",aActivity.time];
                break;
            case 2:
                lblTime.text = [NSString stringWithFormat:@"%dh",aActivity.time];
                break;

            default:
                break;
        }
    }
  

}
-(void)radiusViewBackGround
{
    // border radius
    [viewBackGround.layer setCornerRadius:20.0f];
    // border
    [viewBackGround.layer setBorderWidth:1.0f];
}
-(void)displayforView
{
    [self radiusViewBackGround];
    [self addGestureSingleTag];
    [self addGestureLongTag];
}
-(void)addGestureSingleTag
{
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [viewBackGround addGestureRecognizer:singleFingerTap];
    
}
-(void)addGestureLongTag
{
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    longPress.minimumPressDuration=1.0;
    [viewBackGround addGestureRecognizer:longPress];
}
-(void)handleSingleTap:(id)sender
{
    aActivityCurrent.isSelected = YES;
    NSLog(@"%d",aActivityCurrent.time);
    aActivityCurrent.time = aActivityCurrent.time + TIME_UP;
    [_delegate singleTagItemActivityView:aActivityCurrent];
    
}
-(void)handleLongPress:(id)sender
{
    aActivityCurrent.isSelected = NO;
    aActivityCurrent.time = TIME_DEFAULT;
    [_delegate longTagItemActivityView:aActivityCurrent];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)changeEditActivityViewController:(id)sender
{
    [_delegate editItemActivityrSelectedView:aActivityCurrent];
}
@end
