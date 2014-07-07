//
//  ItemMemberView.h
//  Family
//
//  Created by Admin on 7/1/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Member.h"
@protocol ItemMemberViewDelegate <NSObject>
-(void)editItemMemberSelected:(id)sender MemberCurrent:(Member *)aMemberCurrent;
-(void)itemMemberSelected:(id) sender MemberCurrent:(Member *)aMemberCurrent;
@end
@interface ItemMemberView : UIView
{
    id <ItemMemberViewDelegate> _delegate;
}
-(void) setDataForItemView:(Member *) aMember;
-(void)displayForItemView;
@property (retain) id delegate;
@end
