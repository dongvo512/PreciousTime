//
//  HistoryTableViewCell.m
//  Family
//
//  Created by Admin on 7/21/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "HistoryTableViewCell.h"
#import "Utilities.h"
@interface HistoryTableViewCell ()
{
    IBOutlet UIImageView *imgActivity;
    IBOutlet UILabel *lblDetailActivity;

}
@end
@implementation HistoryTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setObjectForCell:(History *) aHistory
{
    NSString *strDate = aHistory.date;
    NSString *strActivity = aHistory.activityName;
    NSString *strMemberName = aHistory.memberName;
    NSString *strTime = aHistory.time;
    NSString *strUnitType = [Utilities getUnitType:aHistory.unitType];
    
    NSString *detailActivity = [NSString stringWithFormat:@"%@:%@ - %@ - %@ %@",strDate,strActivity,strMemberName,strTime,strUnitType];
    lblDetailActivity.text = detailActivity;
    
    UIImage *imgAvatarCurr = [UIImage imageNamed:aHistory.imageUrl];
    NSData *data = [[NSFileManager defaultManager] contentsAtPath:aHistory.imageUrl];
    
    if(data != nil)
        imgActivity.image = [UIImage imageWithData:data];
    else if (imgAvatarCurr != nil)
        imgActivity.image = imgAvatarCurr;
    else
        imgActivity.image = [UIImage imageNamed:@"icon_FamLink2.png"];
}
@end
