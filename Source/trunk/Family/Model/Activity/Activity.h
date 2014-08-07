//
//  Activity.h
//  Family
//
//  Created by Admin on 7/2/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Activity : NSObject
{
    int _time;
}
@property (nonatomic, retain) NSString *idActivity;
@property (nonatomic, retain) NSString *name;
@property (nonatomic) int time;
@property (nonatomic, assign) int deleted;
@property (nonatomic, retain) NSString *strAvatar;
@property (nonatomic) int point;
@property (nonatomic, assign) int unitTypeValue;
@property (nonatomic, retain) UIColor *color;
@property (nonatomic, retain) NSString *timestamp;
@property (nonatomic) int dirty;
@property (nonatomic, assign) BOOL isSelected;
@end
