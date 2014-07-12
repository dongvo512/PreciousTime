//
//  Utilities.m
//  Family
//
//  Created by Admin on 7/1/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "DataParser.h"
#import "Member.h"
#import "Activity.h"
#import "Promise.h"
#import "FMDatabase.h"

@implementation DataParser

+ (Member*)allocMemberWithResults:(FMResultSet*)results{
    Member *item = [[Member alloc] init];
    item.idMember = [results stringForColumn:@"id"];
    item.name = [results stringForColumn:@"name"];
    item.avatarUrl = [results stringForColumn:@"avatarUrl"];
    item.bithday = [results stringForColumn:@"birthday"];
    item.genderValue = [results intForColumn:@"gender"];
    item.timestamp = [results stringForColumn:@"timestamp"];

    return item;
}

+ (Activity*)allocAcitiviyWithResults:(FMResultSet*)results{
    Activity *item = [[Activity alloc] init];
    item.idActivity = [results stringForColumn:@"id"];
    item.name = [results stringForColumn:@"name"];
    item.strAvatar = [results stringForColumn:@"logoUrl"];
    item.point = [results intForColumn:@"pointPerUnit"];
    item.unitTypeValue = [results intForColumn:@"unitType"];
    return item;
}

+ (Promise*)allocPromiseWithResults:(FMResultSet*)results{
    Promise *item = [[Promise alloc] init];
    item.idPromise = [results stringForColumn:@"id"];
    item.name = [results stringForColumn:@"name"];
    item.description = [results stringForColumn:@"description"];
    item.dueDate = [results stringForColumn:@"duedate"];
    item.status = [results intForColumn:@"status"];

    return item;
}
@end
