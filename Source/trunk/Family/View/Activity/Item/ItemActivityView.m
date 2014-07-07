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
}
- (IBAction)changeEditActivityViewController:(id)sender;

@end
@implementation ItemActivityView

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
    imgAvatar.image = aActivity.avatar;
    lblNameActivity.text = aActivity.name;
    [self radiusViewBackGround];
}
-(void)radiusViewBackGround
{
    // border radius
    [viewBackGround.layer setCornerRadius:20.0f];
    // border
    [viewBackGround.layer setBorderWidth:1.0f];
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
    [_delegate editItemMemberSelected:sender];
}
@end
