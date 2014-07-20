//
//  History.h
//  Family
//
//  Created by Sa Vo on 7/12/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Member;
@class Activity;
@interface History : NSObject
@property (nonatomic, retain) NSString* memberName;
@property (nonatomic, retain) NSString* activityName;
@property (nonatomic, retain) NSString* imageUrl;
@property (nonatomic, retain) NSString *timeTamp;
@property (nonatomic, retain) NSString *date;
@property (nonatomic, assign) int totalPoint;
@property (nonatomic, retain) NSString *time;

@end
