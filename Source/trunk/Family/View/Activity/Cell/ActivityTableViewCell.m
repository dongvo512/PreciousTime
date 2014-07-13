//
//  ActivityTableViewCell.m
//  Family
//
//  Created by Admin on 7/2/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "ActivityTableViewCell.h"
#import "ItemActivityView.h"
#import "Activity.h"
@implementation ActivityTableViewCell
#define COUNT_ITEM 2
#define TAG_ITEM 300
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        //  To Do :add view
        
        for(int i=0; i< COUNT_ITEM; i++)
        {
            NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"ItemActivityView" owner:nil options:nil];
            UIView *aView = nil;
            for(UIView *viewCurr in views)
            {
                if([viewCurr isKindOfClass:[ItemActivityView class]])
                {
                    aView = viewCurr;
                }
            }
                [aView setTag:TAG_ITEM +i];
                CGRect frame = aView.frame;
                frame.origin.x = i* aView.frame.size.width;
                aView.frame = frame;
                [self.contentView addSubview:aView];
        }

    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}
-(void) setObjectForCell:(NSMutableArray *) arrCell
{
    
    //  Get view for tag, set content if object exist, otherwise hide that view
    
    UIView *aView = nil;
    
    for(int i=0 ; i< COUNT_ITEM; i++)
    {
        aView = [self.contentView viewWithTag:TAG_ITEM +i];
        
        @try {
            if([arrCell objectAtIndex:i] != nil)
            {
                ItemActivityView *itemView = (ItemActivityView *) aView;
                itemView.delegate = self;
                Activity *aActivity = [arrCell objectAtIndex:i];
                [itemView setDataForItemView:aActivity];
                [itemView displayforView];
                [aView setHidden:NO];
            }
            else
                [aView setHidden:YES];
        }
        @catch (NSException * e) {
            [aView setHidden:YES];
            NSLog(@"Exception: %@", e);
        }
        
    }
}
#pragma mark - ItemActivityView Delegate
-(void)editItemActivityrSelectedView:(Activity *)aActivity
{
    [_delegate editActivitySelectedCell:aActivity];
}
-(void)singleTagItemActivityView:(Activity *)aActivity
{
    [_delegate singleTagItemActivity:aActivity];
}
-(void)longTagItemActivityView
{
    [_delegate longTagItemActivity];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
