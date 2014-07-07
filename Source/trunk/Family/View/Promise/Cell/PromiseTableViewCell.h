//
//  PromiseTableViewCell.h
//  Family
//
//  Created by Admin on 7/3/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Promise.h"
@protocol PromiseTableViewCellDelegate<NSObject>
-(void) reloadTableViewWithButtonCell;
@end
@interface PromiseTableViewCell : UITableViewCell
{
    id <PromiseTableViewCellDelegate> _delegate;
}
-(void) setObjectForCell:(Promise *) aPromise;
@property (retain) id delegate;
@end
