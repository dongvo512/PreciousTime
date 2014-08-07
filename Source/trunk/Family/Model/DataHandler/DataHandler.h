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
//- (BOOL)checkExistMemberWithId:(NSString*)idMember error:(NSError**)error;
- (BOOL)checkExistMemberWithName:(NSString*)nameMember error:(NSError**)error;
-(BOOL)insertMember:(Member*)aMember isSync:(BOOL)isSync idMember:(NSString**)idMember error:(NSError**)error;
//Use to update member info
-(BOOL)updateMemberInfo:(Member*)aMember isSync:(BOOL)isSync error:(NSError**)error;

//Use to delete member
-(BOOL)updateDeletedMember:(NSString*)idMember error:(NSError**)error;
- (Member*)allocMemberWithId:(NSString*)memberId error:(NSError**)error;

- (BOOL)removeDeletedMembersWithError:(NSError**)error;
-(NSMutableArray *)allocMemberDirtyTransformWithError:(NSError **) error;
-(NSMutableArray *) tranformJsonObjectWithMember:(NSMutableArray *) arrMember;
/*
 * get all Activity in databse
 */
- (NSMutableArray*)allocAcitivitiesWithError:(NSError**)error;
//- (BOOL)checkExistActivityWithId:(NSString*)idActivity error:(NSError**)error;
- (BOOL)checkExistActivityWithName:(NSString*)nameActivity error:(NSError**)error;
-(BOOL)insertActivity:(Activity*)anActivity isSync:(BOOL)isSync idActivity:(NSString**)idActivity error:(NSError**)error;
//Use to update activity info
-(BOOL)updateActivityInfo:(Activity*)anActivity isSync:(BOOL)isSync error:(NSError**)error;
//Use to delete activity
-(BOOL)updateDeletedActivity:(NSString*)idActivity error:(NSError**)error;
-(NSMutableArray *)allocActivityDirtyTransformWithError:(NSError **) error;
-(NSMutableArray *) tranformJsonObjectWithActivity:(NSMutableArray *) arrActivity;
/*
 * get all Promises in databse
 */
//- (NSMutableArray*)allocPromisesWithError:(NSError**)error;
- (NSMutableArray*)allocNotDonePromisesWithError:(NSError**)error idMember:(NSString*) idMember;
- (NSMutableArray*)allocDoneOverDuePromisesWithError:(NSError**)error idMember:(NSString*) idMember;
- (BOOL)checkExistPromiseWithId:(NSString*)idPromise error:(NSError**)error;
-(BOOL)insertPromise:(Promise*)aPromise idPromise:(NSString**)idPromise error:(NSError**)error;
//Use to update promise info
-(BOOL)updatePromiseInfo:(Promise*)aPromise error:(NSError**)error;
//Use to delete promise info
-(BOOL)updateDeletedPromise:(NSString*)idPromise idMember:(NSString*)idMember error:(NSError**)error;
-(BOOL)updatePromiseOverDue:(NSError**)error isMember:(NSString*) idMember DateCurrent:(NSString *)date;
-(NSMutableArray *) allocDonePromiseWeekMonthWithError:(NSError **) error idMember:(NSString *) idMember DayCurrent:(NSString *)today BeforeDate:(NSString *)beforDate;
-(NSMutableArray *) allocOverDuePromiseDayWithError:(NSError **) error idMember:(NSString *) idMember dateBeforeCurrentOneDay:(NSString *)date;
-(NSMutableArray *) allocDonePromiseDayWithError:(NSError **) error idMember:(NSString *) idMember dateCurrent:(NSString *)date;
-(NSMutableArray *)allocPromiseDirtyTransformWithError:(NSError **) error;
-(NSMutableArray *) tranformJsonObjectWithPromise:(NSMutableArray *) arrPromise;
/*
 * get all Histories in databse
 */
- (NSMutableArray*)allocHistoriesWithError:(NSError**)error idMember:(NSString*)idMember;
-(BOOL)insertHistory:(History*)aHistory idMember:(NSString*)idMember idActivity:(NSString*)idActivity error:(NSError**)error;
//-(NSMutableArray *) allocHistoryWithDay:(NSString*) idMember day:(NSString*)dateDay error:(NSError**)error;
-(NSMutableArray *) allocHistoryWithDay:(NSString*) idMember dayCurrent:(NSString*)date error:(NSError**)error;
-(NSMutableArray *) allocHistoryWithWeekAndMonth:(NSString*) idMember dayCurrent:(NSString*)dateCurr BeforeWeekandMonth:(NSString*)dateBefore error:(NSError**)error;
-(NSMutableArray *)allocHistoryDirtyTransformWithError:(NSError **) error;
-(NSMutableArray *) tranformJsonObjectWithHistory:(NSMutableArray *) arrHistory;
/*
 * synce data
 */
-(int)getTimestampLatest:(NSError**) error;
-(NSMutableArray *) tranformJosonObjectWithPromise:(NSMutableArray *) arrPromise;
@end

