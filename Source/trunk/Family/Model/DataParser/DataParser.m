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
#import "History.h"
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
    item.relationship = [results stringForColumn:@"relationship"];

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
    item.completeDate = [results stringForColumn:@"completeDate"];
    item.idPromise = [results stringForColumn:@"id"];
    item.idMember =[results stringForColumn:@"idMember"];
    item.name = [results stringForColumn:@"name"];
    item.description = [results stringForColumn:@"description"];
    item.dueDate = [results stringForColumn:@"duedate"];
    item.status = [results intForColumn:@"status"];

    return item;
}

+(History*)allocHistoryWithResultsGroupByActivityName:(FMResultSet*)results
{
    History *item = [[History alloc] init];
    item.activityName =[results stringForColumn:@"activityName"];
    item.totalPoint = [results intForColumn:@"totalPoint"];
    return item;

}
+ (History*)allocHistoryWithResults:(FMResultSet*)results{
    History *item = [[History alloc] init];
    item.memberName = [results stringForColumn:@"memberName"];
    item.unitType = [results intForColumn:@"unitType"];
    item.date = [results stringForColumn:@"date"];
    item.activityName =[results stringForColumn:@"activityName"];
    item.imageUrl = [results stringForColumn:@"imageUrl"];
    item.totalPoint = [results intForColumn:@"point"];
    item.time = [results stringForColumn:@"time"];
    return item;
}
@end
