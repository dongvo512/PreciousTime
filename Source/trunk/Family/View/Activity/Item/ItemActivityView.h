//
//  ItemActivityView.h
//  Family
//
//  Created by Admin on 7/2/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Activity.h"
@protocol ItemActivityViewDelegate <NSObject>
-(void)editItemMemberSelected:(id)sender;
@end
@interface ItemActivityView : UIView
{
    id <ItemActivityViewDelegate> _delegate;
}
-(void) setDataForItemView:(Activity *) aActivity;
@property (retain) id delegate;
@end
