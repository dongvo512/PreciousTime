//
//  MemberInfoView.m
//  Family
//
//  Created by Admin on 7/6/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "MemberInfoView.h"

@interface MemberInfoView()
{
    IBOutlet UIImageView *imgAvatar;
    IBOutlet UILabel *lblAge;
    IBOutlet UILabel *lblBirthDay;
}
@end
@implementation MemberInfoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void) setObjectForView:(Member *) aMember
{
    imgAvatar.image = aMember.avatar;
    lblBirthDay.text = aMember.bithday;
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