//
//  Utilities.h
//  Family
//
//  Created by Admin on 7/1/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Member;
@class Activity;
@class Promise;
@class FMResultSet;
@interface DataParser : NSObject
+ (Member*)allocMemberWithResults:(FMResultSet*)results;
+ (Activity*)allocAcitiviyWithResults:(FMResultSet*)results;
+ (Promise*)allocPromiseWithResults:(FMResultSet*)results;
@end
