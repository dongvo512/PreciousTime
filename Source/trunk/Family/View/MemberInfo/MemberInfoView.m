//
//  MemberInfoView.m
//  Family
//
//  Created by Admin on 7/6/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "MemberInfoView.h"
#import "Utilities.h"
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
 
    NSLog(@"%@",aMember.avatarUrl);
    NSData *data = [[NSFileManager defaultManager] contentsAtPath:aMember.avatarUrl];
    if(data != nil)
    imgAvatar.image = [UIImage imageWithData:data];
    NSString *yearCurr = [Utilities getYear:[NSDate date]];
     NSArray *arrDate = [aMember.bithday componentsSeparatedByString:@"/"];
    NSString *birthYear = [arrDate objectAtIndex:2];
    int yearold =  yearCurr.intValue - birthYear.intValue;
    lblAge.text = [NSString stringWithFormat:@"%d years old",yearold];
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
