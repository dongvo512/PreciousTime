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
-(void)editItemActivityrSelectedView:(Activity*)aActivity;
-(void)singleTagItemActivityView:(Activity *)aActivity;
-(void)longTagItemActivityView;
@end
@interface ItemActivityView : UIView
{
    id <ItemActivityViewDelegate> _delegate;
}
-(void) setDataForItemView:(Activity *) aActivity;
@property (retain) id delegate;
-(void)displayforView;

@end
