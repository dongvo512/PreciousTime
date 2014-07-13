//
//  ItemMemberView.m
//  Family
//
//  Created by Admin on 7/1/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "ItemMemberView.h"
#import "Utilities.h"
@interface ItemMemberView()
{
    IBOutlet UIImageView *imgAvatar;
    IBOutlet UILabel *lblName;
    IBOutlet UIView *viewBackGround;
    Member *memberCurr;
}

- (IBAction)editMember:(id)sender;
@end
@implementation ItemMemberView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)displayForItemView
{
    [self radiusViewBackGround];
    [self addGestureForViewBackGround];
}

-(void) setDataForItemView:(Member *) aMember
{
    memberCurr = aMember;
    NSLog(@"%@",aMember.avatarUrl);
    NSData *data = [[NSFileManager defaultManager] contentsAtPath:aMember.avatarUrl];
    imgAvatar.image = [UIImage imageWithData:data];

    lblName.text = aMember.name;
   
}
-(void)addGestureForViewBackGround
{
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [viewBackGround addGestureRecognizer:singleFingerTap];
    
}
-(void)handleSingleTap:(id)sender
{
    [_delegate itemMemberSelected:sender MemberCurrent:memberCurr];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(void)radiusViewBackGround
{
    // border radius
    [viewBackGround.layer setCornerRadius:20.0f];
    // border
    [viewBackGround.layer setBorderWidth:1.0f];
    
  
}
- (IBAction)editMember:(id)sender
{
    [_delegate editItemMemberSelected:sender MemberCurrent:memberCurr];
}
@end
