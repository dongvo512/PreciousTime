//
//  Activity.m
//  Family
//
//  Created by Admin on 7/2/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "Activity.h"

@implementation Activity
@synthesize time = _time;
- (id)init{
    self = [super init];
    if (self) {
        _time = 0;
    }
    return self;
}
@end
