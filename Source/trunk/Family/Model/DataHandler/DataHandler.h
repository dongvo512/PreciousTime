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
@class History;
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
-(BOOL)insertMember:(Member*)aMember isSync:(BOOL)isSync idMember:(NSString**)idMember error:(NSError**)error;
//Use to update member info
-(BOOL)updateMemberInfo:(Member*)aMember isSync:(BOOL)isSync error:(NSError**)error;

//Use to delete member
-(BOOL)updateDeletedMember:(NSString*)idMember error:(NSError**)error;

- (BOOL)removeDeletedMembersWithError:(NSError**)error;
/*
 * get all Activity in databse
 */
- (NSMutableArray*)allocAcitivitiesWithError:(NSError**)error;
- (BOOL)checkExistActivityWithId:(NSString*)idActivity error:(NSError**)error;
-(BOOL)insertActivity:(Activity*)anActivity isSync:(BOOL)isSync idActivity:(NSString**)idActivity error:(NSError**)error;
//Use to update activity info
-(BOOL)updateActivityInfo:(Activity*)anActivity isSync:(BOOL)isSync error:(NSError**)error;
//Use to delete activity
-(BOOL)updateDeletedActivity:(NSString*)idActivity error:(NSError**)error;
/*
 * get all Promises in databse
 */
- (NSMutableArray*)allocPromisesWithError:(NSError**)error;
- (BOOL)checkExistPromiseWithId:(NSString*)idPromise error:(NSError**)error;
-(BOOL)insertPromise:(Promise*)aPromise idPromise:(NSString**)idPromise error:(NSError**)error;
//Use to update promise info
-(BOOL)updatePromiseInfo:(Promise*)aPromise error:(NSError**)error;
//Use to delete promise info
-(BOOL)updateDeletedPromise:(NSString*)idPromise error:(NSError**)error;
/*
 * get all Histories in databse
 */
- (NSMutableArray*)allocHistoriesWithError:(NSError**)error;
-(BOOL)insertHistory:(History*)aHistory idMember:(NSString*)idMember idActivity:(NSString*)idActivity error:(NSError**)error;

@end

