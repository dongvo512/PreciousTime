//
//  Member.h
//  Family
//
//  Created by Admin on 7/1/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Member : NSObject
@property (nonatomic, retain) NSString *idMember;
@property (nonatomic, retain) UIImage *avatar;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *bithday;
@property (nonatomic, retain) NSString *gender;
@property (nonatomic, retain) NSString *relationship;
@property (nonatomic, retain) NSString *avatarUrl;
@property (nonatomic, retain) NSString *timestamp;
@property (nonatomic, assign) int genderValue;
//@property (nonatomic, assign) BOOL deleted;
//@property (nonatomic, assign) BOOL dirty;


@end
