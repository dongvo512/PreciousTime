//
//  Promise.h
//  Family
//
//  Created by Admin on 7/3/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Promise : NSObject
@property (nonatomic) NSString* name;
@property (nonatomic, retain) NSString* dueDate;
@property (nonatomic) Boolean isPick;
@property (nonatomic, retain) NSString* description;
@end
