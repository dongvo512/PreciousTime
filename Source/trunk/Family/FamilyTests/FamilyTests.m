//
//  FamilyTests.m
//  FamilyTests
//
//  Created by Admin on 7/1/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DataHandler.h"
#import "Member.h"
#import "Activity.h"
#import "Promise.h"
#import "History.h"
#import "Utilities.h"
@interface FamilyTests : XCTestCase

@end

@implementation FamilyTests

- (void)setUp
{
    [super setUp];
    NSError *error = nil;
    [[DataHandler sharedManager] copyDatabaseToDocumentWithError:&error];
    
    NSAssert((error==nil), error.description);
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
   

    [super tearDown];
}

/*
 * Member
 */

- (void)testInsertMember
{
    //XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
    
    NSError *error = nil;
    Member *member = [[Member alloc] init];
    member.name = @"Kim Sa";
    member.avatarUrl = @"http://www.picturesnew.com/media/images/images_of_nature.jpg";
    member.bithday = @"04/02/1986";
    member.genderValue = 0;
    member.relationship = @"Sister";
    
    NSString *idMember = nil;
    BOOL isSuccess = [[DataHandler sharedManager] insertMember:member isSync:false idMember:&idMember error:&error];
    DLog(@"%@",idMember);
    NSAssert(isSuccess, error.description);


}

- (void)testGetAllMember{
    NSError *error = nil;
    
    NSMutableArray *array = [[DataHandler sharedManager] allocMembersWithError:&error];
    NSAssert((array !=nil), error.description);
}

- (void)testUpdateInfoMember{
   
    NSError *error = nil;
    Member *member = [[Member alloc] init];
    member.idMember = @"kimsa";
    member.name = @"Kim Sa";
    member.avatarUrl = @"http://www.picturesnew.com/media/images/images_of_nature.jpg";
    member.bithday = @"04/02/1989";
    member.genderValue = 0;
    member.relationship = @"Daddy";
    
    NSString *idMember = nil;
    BOOL isSuccess = [[DataHandler sharedManager] insertMember:member isSync:false idMember:&idMember error:&error];
    member.idMember = idMember;
    isSuccess = [[DataHandler sharedManager] updateMemberInfo:member isSync:false  error:&error];
    NSAssert(isSuccess, error.description);
}
-(void) testGetAllMemberTransform
{
    NSError *error = nil;
    
    NSMutableArray *array = [[DataHandler sharedManager] allocMemberDirtyTransformWithError:&error];
    NSAssert((array !=nil), error.description);
}
/*
 * Activity
 */
- (void)testInsertActivity{
    NSError *error = nil;
    Activity *activity = [[Activity alloc] init];
    activity.name = @"Bicycle";
    activity.unitTypeValue = 0;
    activity.strAvatar = @"http://www.picturesnew.com/media/images/images_of_nature.jpg";
    activity.point = 10;
    
    NSString *idActivity = nil;
    BOOL isSuccess = [[DataHandler sharedManager] insertActivity:activity isSync:false idActivity:&idActivity error:&error];
    DLog(@"%@",idActivity);
    NSAssert(isSuccess, error.description);

}

- (void)testGetAllActivity{
    NSError *error = nil;
    
    NSMutableArray *array = [[DataHandler sharedManager] allocAcitivitiesWithError:&error];
    NSAssert((array !=nil), error.description);
}

- (void)testUpdateInfoActivity{
    
    NSError *error = nil;
    Activity *activity = [[Activity alloc] init];
    activity.name = @"Bicycle";
    activity.unitTypeValue = 0;
    activity.strAvatar = @"http://www.picturesnew.com/media/images/images_of_nature.jpg";
    activity.point = 10;

    
    NSString *idActivity = nil;
    BOOL isSuccess = [[DataHandler sharedManager] insertActivity:activity isSync:false idActivity:&idActivity error:&error];
    activity.idActivity = idActivity;
    isSuccess = [[DataHandler sharedManager] updateActivityInfo:activity isSync:false error:&error];
    NSAssert(isSuccess, error.description);
}
-(void) testGetAllActivityTransform
{
    NSError *error = nil;
    
    NSMutableArray *array = [[DataHandler sharedManager] allocActivityDirtyTransformWithError:&error];
    NSAssert((array !=nil), error.description);
}
/*
 * Promise
 */

- (void)testInsertPromise{
    NSError *error = nil;
    Promise *promise = [[Promise alloc] init];
    promise.name = @"Give a gift for son";
    promise.idMember = @"kimsa";
    promise.description = @"give a gift for the children";
    promise.dueDate = @"14/2/2014";
    promise.status = 1;
    
    NSString *idPromise = nil;
    BOOL isSuccess = [[DataHandler sharedManager] insertPromise:promise idPromise:&idPromise error:&error];
    
    NSAssert(isSuccess, error.description);
    
}

/*- (void)testGetAllPromise{
    NSError *error = nil;
    
    NSMutableArray *array = [[DataHandler sharedManager] allocPromisesWithError:&error];
    NSAssert((array !=nil), error.description);
}*/

- (void)testUpdateInfoPromise{
    NSError *error = nil;
    Promise *promise = [[Promise alloc] init];
    promise.name = @"Give a gift for son";
    promise.description = @"give a gift for the children";
    promise.dueDate = @"14/2/2014";
    promise.status = 1;
    
    
    NSString *idPromise = nil;
    BOOL isSuccess = [[DataHandler sharedManager] insertPromise:promise idPromise:&idPromise error:&error];
    promise.idPromise = idPromise;
    isSuccess = [[DataHandler sharedManager] updatePromiseInfo:promise error:&error];
    NSAssert(isSuccess, error.description);
}
-(void) testGetPromiseTransform
{
    NSError *error = nil;
    
    NSMutableArray *array = [[DataHandler sharedManager] allocPromiseDirtyTransformWithError:&error];
    NSAssert((array !=nil), error.description);
}
/*
 * History
 */
/*- (void)testGetAllHistory{
    NSError *error = nil;
    
    NSMutableArray *array = [[DataHandler sharedManager] allocHistoriesWithError:&error];
    NSAssert((array !=nil), error.description);

}*/

/*- (void)testInsertHistory{
    NSError *error = nil;
    History *history = [[History alloc] init];
   
    BOOL isSuccess = [[DataHandler sharedManager] insertHistory:history idMember:@"kimsa" idActivity:@"bicycle" error:&error];
    
    NSAssert(isSuccess, error.description);
    
}*/
-(void) testGetHistoryTransform
{
    NSError *error = nil;
    
    NSMutableArray *array = [[DataHandler sharedManager] allocHistoryDirtyTransformWithError:&error];
    NSAssert((array !=nil), error.description);
}
/*
 * Synce Data
 */
-(void) testGetTimestampLatest
{
    NSError *error = nil;
   
    int timestampLatest = [[DataHandler sharedManager] getTimestampLatest:&error];
    
     NSAssert(timestampLatest != -1, error.description);
}
-(void) testGetStringJsonObjectWithPromise
{
    NSError *error = nil;
    NSMutableArray *arrPromiseTranform = [[DataHandler sharedManager] allocPromiseDirtyTransformWithError:&error];
    
    NSMutableArray *arrPromiseTranformWithDic =[[DataHandler sharedManager] tranformJsonObjectWithPromise:arrPromiseTranform];
    NSString *stringJsonObject = [Utilities convertNSmutableToJsonObjectWithKey:arrPromiseTranformWithDic keyName:@"ListPromise"];
    NSAssert(stringJsonObject != nil, error.description);
}
-(void) testGetStringJsonObjectWithMember
{
    NSError *error = nil;
    NSMutableArray *arrMemberTranform = [[DataHandler sharedManager] allocMemberDirtyTransformWithError:&error];
    
    NSMutableArray *arrMemberTranformWithDic =[[DataHandler sharedManager] tranformJsonObjectWithMember:arrMemberTranform];
    NSString *stringJsonObject = [Utilities convertNSmutableToJsonObjectWithKey:arrMemberTranformWithDic keyName:@"ListMember"];
    NSAssert(stringJsonObject != nil, error.description);

}
-(void) testGetStringJsonObjectWithActivity
{
    NSError *error = nil;
    NSMutableArray *arrActivityTranform = [[DataHandler sharedManager] allocActivityDirtyTransformWithError:&error];
    
    NSMutableArray *arrMemberTranformWithDic =[[DataHandler sharedManager] tranformJsonObjectWithActivity:arrActivityTranform];
    NSString *stringJsonObject = [Utilities convertNSmutableToJsonObjectWithKey:arrMemberTranformWithDic keyName:@"ListActivity"];
    NSAssert(stringJsonObject != nil, error.description);
    
}
-(void) testGetStringJsonObjectWithHistory
{
    NSError *error = nil;
    NSMutableArray *arrHistoryTranform = [[DataHandler sharedManager] allocHistoryDirtyTransformWithError:&error];
    
    NSMutableArray *arrHistoryTranformWithDic =[[DataHandler sharedManager] tranformJsonObjectWithHistory:arrHistoryTranform];
    NSString *stringJsonObject = [Utilities convertNSmutableToJsonObjectWithKey:arrHistoryTranformWithDic keyName:@"ListHistory"];
    NSAssert(stringJsonObject != nil, error.description);
    
}

@end
