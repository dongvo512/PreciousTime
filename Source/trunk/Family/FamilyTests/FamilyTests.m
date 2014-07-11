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
@interface FamilyTests : XCTestCase

@end

@implementation FamilyTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    NSError *error = nil;
    [[DataHandler sharedManager] copyDatabaseToDocumentWithError:&error];
    NSAssert((error==nil), error.description);

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
    
    BOOL isSuccess = [[DataHandler sharedManager] insertMember:member error:&error];
    NSAssert(isSuccess, error.description);


}

/*
 * Activity
 */
- (void)testInsertActivity{
    NSError *error = nil;
    Activity *activity = [[Activity alloc] init];
    activity.name = @"Bicycle";
    activity.unitType = @"minute";
    activity.strAvatar = @"http://www.picturesnew.com/media/images/images_of_nature.jpg";
    activity.point = 10;
    BOOL isSuccess = [[DataHandler sharedManager] insertActivity:activity error:&error];

    NSAssert(isSuccess, error.description);

}

/*
 * Promise
 */

- (void)testInsertPromise{
    NSError *error = nil;
    Activity *activity = [[Activity alloc] init];
    activity.name = @"Bicycle";
    activity.unitType = @"minute";
    activity.strAvatar = @"http://www.picturesnew.com/media/images/images_of_nature.jpg";
    activity.point = 10;
    BOOL isSuccess = [[DataHandler sharedManager] insertActivity:activity error:&error];
    
    NSAssert(isSuccess, error.description);
    
}

@end
