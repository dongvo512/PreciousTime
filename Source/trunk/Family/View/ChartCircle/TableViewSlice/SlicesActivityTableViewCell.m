//
//  SlicesActivityTableViewCell.m
//  Family
//
//  Created by Admin on 7/6/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "SlicesActivityTableViewCell.h"
@interface SlicesActivityTableViewCell()
{
    IBOutlet UIImageView *imgColor;
    IBOutlet UILabel *lblName;

}
@end
@implementation SlicesActivityTableViewCell

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
    [imgColor setBackgroundColor:self.colorCurr];
    lblName.text = aHistory.activityName;
    
}
@end
