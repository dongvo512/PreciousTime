//
//  ActivityTableViewCell.h
//  Family
//
//  Created by Admin on 7/2/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemActivityView.h"
#import "Activity.h"
@protocol ActivityTableViewDelegate <NSObject>
-(void)editActivitySelectedCell:(Activity*)aActivity;
-(void)singleTagItemActivity:(Activity*)aActivity;
-(void)longTagItemActivity;
@end
@interface ActivityTableViewCell : UITableViewCell<ItemActivityViewDelegate>
{
    id <ActivityTableViewDelegate> _delegate;
}
-(void) setObjectForCell:(NSMutableArray *) arrCell;

@property (retain) id delegate;
@end
