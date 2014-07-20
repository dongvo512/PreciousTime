//
//  Friend.h
//  Family
//
//  Created by Admin on 7/16/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Friend : NSObject
@property (nonatomic, retain) NSString *fbID;
@property (nonatomic, retain) NSString *nameFB;
@property (nonatomic, retain) NSString *urlAvatar;
@property (assign) BOOL isSelected;@end
