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
@class Activity;
@class Promise;
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
- (NSMutableArray*)allocMembersWithError:(NSError**)error;
- (BOOL)checkExistMemberWithId:(NSString*)idMember error:(NSError**)error;
-(BOOL)insertMember:(Member*)aMember idMember:(NSString**)idMember error:(NSError**)error;

//Use to update member info
-(BOOL)updateMemberInfo:(Member*)aMember error:(NSError**)error;
-(BOOL)updateDeletedMember:(NSString*)idMember error:(NSError**)error;

//- (BOOL)deleteMemberWithId:(NSString*)memberId error:(NSError**)error;
/*
 * get all Activity in databse
 */
- (NSMutableArray*)allocAcitivitiesWithError:(NSError**)error;
- (BOOL)checkExistActivityWithId:(NSString*)idActivity error:(NSError**)error;
-(BOOL)insertActivity:(Activity*)anActivity idActivity:(NSString**)idActivity error:(NSError**)error;
-(BOOL)updateActivityInfo:(Activity*)anActivity error:(NSError**)error;
-(BOOL)updateDeletedActivity:(NSString*)idActivity error:(NSError**)error;
/*
 * get all Promises in databse
 */
- (NSMutableArray*)allocPromisesWithError:(NSError**)error;
- (BOOL)checkExistPromiseWithId:(NSString*)idPromise error:(NSError**)error;
-(BOOL)insertPromise:(Promise*)aPromise idPromise:(NSString**)idPromise error:(NSError**)error;
-(BOOL)updatePromiseInfo:(Promise*)aPromise error:(NSError**)error;
-(BOOL)updateDeletedPromise:(NSString*)idPromise error:(NSError**)error;
/*
 * get all Histories in databse
 */
- (NSMutableArray*)allocHistories;
@end

