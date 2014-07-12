//
//  Activity.h
//  Family
//
//  Created by Admin on 7/2/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Activity : NSObject
@property (nonatomic, retain) NSString *idActivity;
@property (nonatomic, retain) NSString *name;
@property (nonatomic) int time;
@property (nonatomic, retain) NSString *strAvatar;
@property (nonatomic) int point;
@property (nonatomic, retain) NSString *unitType;
@property (nonatomic, assign) int unitTypeValue;
@property (nonatomic, retain) UIColor *color;
@property (nonatomic, retain) NSString *timestamp;
@property (nonatomic) Boolean isSelected;
@end
