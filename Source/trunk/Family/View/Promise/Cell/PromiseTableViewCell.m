//
//  PromiseTableViewCell.m
//  Family
//
//  Created by Admin on 7/3/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "PromiseTableViewCell.h"
#import "DataHandler.h"
@interface PromiseTableViewCell()
{
    IBOutlet UILabel *lblRank;
    IBOutlet UILabel *lblDate;
    IBOutlet UIButton *btnPick;
    Promise *aPromiseCurr;
}
- (IBAction)pickPromise:(id)sender;

@end
@implementation PromiseTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void) setObjectForCell:(Promise *) aPromise
{
    aPromiseCurr = aPromise;
    lblRank.text = aPromise.name;
    lblDate.text = aPromise.dueDate;
    
    
   if(aPromise.status == 0)
       [btnPick setImage:[UIImage imageNamed:@"btn_nonepick.png"] forState:UIControlStateNormal];
    else if (aPromise.status == 1)
        [btnPick setImage:[UIImage imageNamed:@"btn_pick.png"] forState:UIControlStateNormal];
}
- (IBAction)pickPromise:(id)sender
{
    //NSError *error = nil;
    if (aPromiseCurr.status!=2) {
        aPromiseCurr.status = !aPromiseCurr.status;
    }
    //BOOL isSuccess = [[DataHandler sharedManager] updatePromiseInfo:aPromiseCurr error:&error];
    //NSAssert(isSuccess, error.description);
    //if(isSuccess)
    [_delegate reloadTableViewWithButtonCell];
}
@end
