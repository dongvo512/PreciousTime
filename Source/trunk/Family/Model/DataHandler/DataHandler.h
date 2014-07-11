//
//  DataHandle.h
//  Tablet
//
//  Created by Nguyen Thi Thuy Trang on 8/23/12.
//
//

#import <Foundation/Foundation.h>

@class FMDatabase;
@class NSError;
@class Member;
@interface DataHandler : NSObject
{
}

+(id)sharedManager;
#pragma mark - Connection DB
- (void)copyDatabaseToDocumentWithError:(NSError**)error;
- (BOOL)openDB:(FMDatabase*)database;
- (void)closeDB:(FMDatabase*)database;

#pragma mark - Files & Group
/*
 * get all Member in database
 */
- (NSMutableArray*)allocMembers;
- (BOOL)checkExistMemberWithId:(NSString*)idMember;
-(BOOL)insertMember:(Member*)aMember error:(NSError**)error;
-(BOOL)updateMember:(Member*)aMember error:(NSError**)error;
- (BOOL)deleteMemberWithId:(NSString*)memberId error:(NSError**)error;
/*
 * get all Activity in databse
 */
- (NSMutableArray*)allocAcitivities;
/*
 * get all Promises in databse
 */
- (NSMutableArray*)allocPromises;
/*
 * get all Histories in databse
 */
- (NSMutableArray*)allocHistories;
@end

