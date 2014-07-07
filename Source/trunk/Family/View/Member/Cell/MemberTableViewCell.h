//
//  MemberTableViewCell.h
//  Family
//
//  Created by Admin on 7/1/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemMemberView.h"
#import "Member.h"
@protocol MemberTableViewCellDelegate <NSObject>
-(void)itemMemberSelectedCell:(id)sender MemberCurrent:(Member*)aMember;
-(void)editMemberSelectedCell:(id)sender MemberCurrent:(Member*)aMember;
@end
@interface MemberTableViewCell : UITableViewCell<ItemMemberViewDelegate>
{
    id <MemberTableViewCellDelegate> _delegate;
}
-(void) setObjectForCell:(NSMutableArray *) arrCell;
@property (retain) id delegate;
@end
