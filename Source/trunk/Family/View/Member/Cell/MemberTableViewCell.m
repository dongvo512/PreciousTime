//
//  MemberTableViewCell.m
//  Family
//
//  Created by Admin on 7/1/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "MemberTableViewCell.h"
#import "Member.h"
#import "Utilities.h"
@implementation MemberTableViewCell
#define COUNT_ITEM 2
#define TAG_ITEM 200
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        //  add view
        
      
        for(int i=0; i< COUNT_ITEM; i++)
        {
            NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"ItemMemberView" owner:nil options:nil];
            UIView *aView = nil;
            for(UIView *viewCurr in views)
            {
                if([viewCurr isKindOfClass:[ItemMemberView class]])
                {
                    aView = viewCurr;
                }
            }
            
            [aView setTag:TAG_ITEM +i];
            CGRect frame = aView.frame;
            frame.origin.x = i*aView.frame.size.width;
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
                ItemMemberView *itemView = (ItemMemberView *) aView;
                itemView.delegate = self;
                Member *aMember = [arrCell objectAtIndex:i];
                [itemView setDataForItemView:aMember];
                [itemView displayForItemView];
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
#pragma marks - ItemMemberView Delegate
-(void) editItemMemberSelected:(id)sender MemberCurrent:(Member *)aMemberCurrent
{
    [_delegate editMemberSelectedCell:sender MemberCurrent:aMemberCurrent];
}
-(void) itemMemberSelected:(id)sender MemberCurrent:(Member *)aMemberCurrent
{
    [_delegate itemMemberSelectedCell:sender MemberCurrent:aMemberCurrent];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
