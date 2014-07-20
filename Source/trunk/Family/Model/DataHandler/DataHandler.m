//
//  DataHandle.m
//  Tablet
//
//  Created by Nguyen Thi Thuy Trang on 8/23/12.
//
//

#import "DataHandler.h"
#import "FMDatabase.h"
#import "Member.h"
#import "DataParser.h"
#import "Utilities.h"
#import "Activity.h"
#import "Promise.h"
#import "History.h"
@implementation DataHandler

#pragma mark - Connection DB

static NSString *DATABASE_NAME = @"Database";
static DataHandler *sharedDataHandler = nil;

/*
 * Name : sharedManager
 * Description : this function use for initaling this class/
 * Param in : void
 * Param out : (id)self.
 */

+(id)sharedManager
{
	@synchronized(self)
    {
		if (sharedDataHandler == nil)
        {
			sharedDataHandler = [[self alloc] init];
		}
	}
	return sharedDataHandler;
}

- (FMDatabase*)database
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    if ([paths count]==0)
    {
        return nil;
    }
    NSString *librarysDirectory = [paths objectAtIndex:0];
    
    NSString *pathDB = [librarysDirectory stringByAppendingPathComponent:DATABASE_NAME];
    
    FMDatabase* db = [FMDatabase databaseWithPath:pathDB];
    return db;
}

- (void)copyDatabaseToDocumentWithError:(NSError**)error {
    
	BOOL success;
	NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    if ([paths count]==0)
    {
        *error = [NSError errorWithDomain:@"Can't find database file" code:1 userInfo:nil];
        return;
    }

    NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *databaseFileName = DATABASE_NAME;
        
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:databaseFileName];

	success = [fileManager fileExistsAtPath:writableDBPath];
    
	if (!success) {
		NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseFileName];
		[fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:error];
	}
     
}

- (BOOL)openDB:(FMDatabase*)database
{
    
    if(![database open])
    {
        DLog(@"Database Error:%@",[[database lastError] localizedDescription]);
        return NO;
    }

    return YES;
     
}

- (void)closeDB:(FMDatabase*)database
{
    [database close];
}

#pragma mark - Method
#pragma mark Members

- (NSMutableArray*)allocMembersWithError:(NSError**)error{
    
    FMDatabase *db = [self database];
    if (![self openDB:db]) {
        *error = [NSError errorWithDomain:@"Can't open database" code:123 userInfo:nil];
        return nil;
    }
    
    FMResultSet *results = [db executeQuery:@"select * from Member where deleted = ?",[NSNumber numberWithBool:false]];
    if ([db hadError]) {
        DLog(@"Select Error:%@",[[db lastError] localizedDescription]);
        *error = [db lastError];
        [self closeDB:db];
        return nil;
    }
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    while ([results next])
    {
        Member * item = [DataParser allocMemberWithResults:results];
        if (item) {
            [array addObject:item];
        }
    }
    [self closeDB:db];

    return array;
     
}

/*- (BOOL)checkExistMemberWithId:(NSString*)idMember error:(NSError**)error
{
    
    BOOL isExist = NO;
    
    FMDatabase *db = [self database];
    if (![self openDB:db]) {
        *error = [db lastError];
        return NO;
    }
    
    
    FMResultSet *results = [db executeQuery:@"select * from Member where id=? and deleted = ?",idMember,[NSNumber numberWithBool:false]];
    if ([db hadError]) {
        DLog(@"Select Error:%@",[[db lastError] localizedDescription]);
        *error = [db lastError];
        [self closeDB:db];
        return NO;
    }
    
    while ([results next]) {
        isExist = YES;
    }
    [self closeDB:db];
    return isExist;
}
*/
- (BOOL)checkExistMemberWithName:(NSString*)nameMember error:(NSError**)error
{
    
    BOOL isExist = NO;
    
    FMDatabase *db = [self database];
    if (![self openDB:db]) {
        *error = [db lastError];
        return NO;
    }
    
    
    FMResultSet *results = [db executeQuery:@"select * from Member where name=? and deleted = ?",nameMember,[NSNumber numberWithBool:false]];
    if ([db hadError]) {
        DLog(@"Select Error:%@",[[db lastError] localizedDescription]);
        *error = [db lastError];
        [self closeDB:db];
        return NO;
    }
    
    while ([results next]) {
        isExist = YES;
    }
    [self closeDB:db];
    return isExist;
}
-(BOOL)insertMember:(Member*)aMember isSync:(BOOL)isSync idMember:(NSString**)idMember error:(NSError**)error
{
    
    if (aMember==nil) {
        *error = [NSError errorWithDomain:@"Member object is nil" code:121 userInfo:nil];
        return NO;
    }
    if (aMember.name.length == 0) {
        *error = [NSError errorWithDomain:@"Member name is nil" code:121 userInfo:nil];
        return NO;

    }
    FMDatabase *db = [self database];
    if (![self openDB:db]) {
        *error = [NSError errorWithDomain:@"Can't open database" code:122 userInfo:nil];

        return NO;
    }
    NSString *idString = [ Utilities idWithDate];
   // NSString *idString = [Utilities idWithName:aMember.name];
    BOOL isDirty = true;
    if (isSync) {
        isDirty = false;
    }
    *idMember = idString;
    BOOL isSuccess = [db executeUpdate:@"insert into Member(id, name, avatarUrl, birthday, gender,relationship,deleted,dirty) values(?,?,?,?,?,?,?,?)",idString,aMember.name,aMember.avatarUrl,aMember.bithday,[NSNumber numberWithInt:aMember.genderValue],aMember.relationship,[NSNumber numberWithBool:false],[NSNumber numberWithBool:isDirty]];
    if (!isSuccess) {
        if (error!=NULL) {
            *error = [db lastError];
        }
        [self closeDB:db];
        
        return NO;
        
    }
    
    [self closeDB:db];
    return YES;
     

}

-(BOOL)updateMemberInfo:(Member*)aMember isSync:(BOOL)isSync error:(NSError**)error
{
    
    FMDatabase *db = [self database];
    if (![self openDB:db]) {
        if (error!=NULL) {
            *error = [db lastError];
            
        }
        DLog(@"Update Error:%@",[[db lastError] localizedDescription]);
        return NO;
    }
    BOOL isDirty = true;
    if (isSync) {
        isDirty = false;
    }
    
    [db executeUpdate:@"update Member"
     " set name = ?,avatarUrl=?,birthday=?,gender=?,timestamp=?,deleted=?,dirty=?"
     " where id = ?",aMember.name,aMember.avatarUrl,aMember.bithday,[NSNumber numberWithInt:aMember.genderValue],aMember.timestamp,[NSNumber numberWithBool:false], [NSNumber numberWithBool:isDirty],aMember.idMember];
    
    
    if ([db hadError]) {
        if (error!=NULL) {
            *error = [db lastError];
            
        }
        DLog(@"update Error:%@",[[db lastError] localizedDescription]);
        [self closeDB:db];

        return NO;
    }
    [self closeDB:db];
     
    return YES;

    
    
}

-(BOOL)updateDeletedMember:(NSString*)idMember error:(NSError**)error
{
    
    FMDatabase *db = [self database];
    if (![self openDB:db]) {
        if (error!=NULL) {
            *error = [db lastError];
            
        }
        DLog(@"Update Error:%@",[[db lastError] localizedDescription]);
        return NO;
    }
    
    
    [db executeUpdate:@"update Member"
     " set deleted=?,dirty=?"
     " where id = ?",[NSNumber numberWithBool:true], [NSNumber numberWithBool:true],idMember];
    
    
    if ([db hadError]) {
        if (error!=NULL) {
            *error = [db lastError];
            
        }
        DLog(@"update Error:%@",[[db lastError] localizedDescription]);
        [self closeDB:db];

        return NO;
    }
    [self closeDB:db];
    
    return YES;
    
    
    
}

- (BOOL)removeDeletedMembersWithError:(NSError**)error
{
    FMDatabase *db = [self database];
    if (![self openDB:db]) {
        return NO;
    }
    
    BOOL isSuccess =  [db executeUpdate:@"delete from Member where deleted = ?;"
                       ,[NSNumber numberWithBool:false]];
    
    if (!isSuccess) {
        if (error!=NULL) {
            *error = [db lastError];
        }
        [self closeDB:db];
        
        return NO;
        
    }
    [self closeDB:db];
    
    return isSuccess;
}

- (Member*)allocMemberWithId:(NSString*)memberId error:(NSError**)error{
    FMDatabase *db = [self database];
    if (![self openDB:db]) {
        *error = [NSError errorWithDomain:@"Can't open database" code:123 userInfo:nil];
        return nil;
    }
    
    FMResultSet *results = [db executeQuery:@"select * from Member where id = ? and deleted=?",memberId,[NSNumber numberWithBool:false]];
    if ([db hadError]) {
        DLog(@"Select Error:%@",[[db lastError] localizedDescription]);
        *error = [db lastError];
        [self closeDB:db];
        return nil;
    }
    
    
    while ([results next])
    {
        Member * item = [DataParser allocMemberWithResults:results];
        if (item) {
            [self closeDB:db];
            return item;
        }
    }
    [self closeDB:db];

    return nil;
}
#pragma mark Activities

- (NSMutableArray*)allocAcitivitiesWithError:(NSError**)error{
    FMDatabase *db = [self database];
    if (![self openDB:db]) {
        *error = [NSError errorWithDomain:@"Can't open database" code:123 userInfo:nil];
        return nil;
    }
    
    FMResultSet *results = [db executeQuery:@"select * from Activity where deleted=?",[NSNumber numberWithBool:false]];
    if ([db hadError]) {
        DLog(@"Select Error:%@",[[db lastError] localizedDescription]);
        *error = [db lastError];
        [self closeDB:db];
        return nil;
    }
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    while ([results next])
    {
        Activity * item = [DataParser allocAcitiviyWithResults:results];
        if (item) {
            [array addObject:item];
        }
    }
    [self closeDB:db];

    return array;
}


-(BOOL)insertActivity:(Activity*)anActivity isSync:(BOOL)isSync idActivity:(NSString**)idActivity error:(NSError**)error
{
    
    if (anActivity==nil) {
        *error = [NSError errorWithDomain:@"Activity object is nil" code:121 userInfo:nil];

        return NO;
    }
    if (anActivity.name.length == 0) {
        *error = [NSError errorWithDomain:@"Activity name is nil" code:121 userInfo:nil];

        return NO;

    }
    FMDatabase *db = [self database];
    if (![self openDB:db]) {
        *error = [NSError errorWithDomain:@"Can't open database" code:122 userInfo:nil];
        [self closeDB:db];

        
        return NO;
    }
    
   // NSString *idString = [Utilities idWithName:anActivity.name];
     NSString *idString = [ Utilities idWithDate];
    *idActivity = idString;
    BOOL isDirty = true;
    if (isSync) {
        isDirty = false;
    }
    BOOL isSuccess = [db executeUpdate:@"insert into Activity(id, name, unitType, logoUrl, pointPerUnit,deleted,dirty) values(?,?,?,?,?,?,?)",idString,anActivity.name,[NSNumber numberWithInt:anActivity.unitTypeValue],anActivity.strAvatar,[NSNumber numberWithInt:anActivity.point],[NSNumber numberWithBool:false],[NSNumber numberWithBool:isDirty]];
    if (!isSuccess) {
        if (error!=NULL) {
            *error = [db lastError];
        }
        [self closeDB:db];
        
        return NO;
        
    }
    
    [self closeDB:db];
    return YES;
    
}

/*- (BOOL)checkExistActivityWithId:(NSString*)idActivity error:(NSError**)error
{
    
    BOOL isExist = NO;
    
    FMDatabase *db = [self database];
    if (![self openDB:db]) {
        *error = [db lastError];
        return NO;
    }
    
    
    FMResultSet *results = [db executeQuery:@"select * from Activity where id=? and deleted = ?",idActivity,[NSNumber numberWithBool:false]];
    if ([db hadError]) {
        DLog(@"Select Error:%@",[[db lastError] localizedDescription]);
        *error = [db lastError];
        [self closeDB:db];
        return NO;
    }
    
    while ([results next]) {
        isExist = YES;
    }
    [self closeDB:db];
    return isExist;
}*/
- (BOOL)checkExistActivityWithName:(NSString*)nameActivity error:(NSError**)error
{
    
    BOOL isExist = NO;
    
    FMDatabase *db = [self database];
    if (![self openDB:db]) {
        *error = [db lastError];
        return NO;
    }
    
    
    FMResultSet *results = [db executeQuery:@"select * from Activity where name=? and deleted = ?",nameActivity,[NSNumber numberWithBool:false]];
    if ([db hadError]) {
        DLog(@"Select Error:%@",[[db lastError] localizedDescription]);
        *error = [db lastError];
        [self closeDB:db];
        return NO;
    }
    
    while ([results next]) {
        isExist = YES;
    }
    [self closeDB:db];
    return isExist;
}


-(BOOL)updateActivityInfo:(Activity*)anActivity isSync:(BOOL)isSync error:(NSError**)error
{
    
    FMDatabase *db = [self database];
    if (![self openDB:db]) {
        if (error!=NULL) {
            *error = [db lastError];
            
        }
        DLog(@"Update Error:%@",[[db lastError] localizedDescription]);
        return NO;
    }
    BOOL isDirty = true;
    if (isSync) {
        isDirty = false;
    }
    
    [db executeUpdate:@"update Activity"
     " set name = ?,unitType=?,logoUrl=?,pointPerUnit=?,timestamp=?,deleted=?,dirty=?"
     " where id = ?",anActivity.name,[NSNumber numberWithInt:anActivity.unitTypeValue],anActivity.strAvatar,[NSNumber numberWithInt:anActivity.point],anActivity.timestamp,[NSNumber numberWithBool:false], [NSNumber numberWithBool:isDirty],anActivity.idActivity];
    
    
    if ([db hadError]) {
        if (error!=NULL) {
            *error = [db lastError];
            
        }
        DLog(@"update Error:%@",[[db lastError] localizedDescription]);
        [self closeDB:db];

        return NO;
    }
    [self closeDB:db];
    
    return YES;
    
    
    
}

-(BOOL)updateDeletedActivity:(NSString*)idActivity error:(NSError**)error
{
    
    FMDatabase *db = [self database];
    if (![self openDB:db]) {
        if (error!=NULL) {
            *error = [db lastError];
            
        }
        DLog(@"Update Error:%@",[[db lastError] localizedDescription]);
        return NO;
    }
    
    
    [db executeUpdate:@"update Activity"
     " set deleted=?,dirty=?"
     " where id = ?",[NSNumber numberWithBool:true], [NSNumber numberWithBool:true],idActivity];
    
    
    if ([db hadError]) {
        if (error!=NULL) {
            *error = [db lastError];
            
        }
        DLog(@"update Error:%@",[[db lastError] localizedDescription]);
        [self closeDB:db];
        return NO;
    }
    [self closeDB:db];
    
    return YES;
    
    
    
}
#pragma mark Promises

/*- (NSMutableArray*)allocPromisesWithError:(NSError**)error{
    FMDatabase *db = [self database];
    if (![self openDB:db]) {
        *error = [NSError errorWithDomain:@"Can't open database" code:123 userInfo:nil];
        return nil;
    }
    
    FMResultSet *results = [db executeQuery:@"select * from Promise where deleted=? ",[NSNumber numberWithBool:false]];
    if ([db hadError]) {
        DLog(@"Select Error:%@",[[db lastError] localizedDescription]);
        *error = [db lastError];
        [self closeDB:db];
        return nil;
    }
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    while ([results next])
    {
        Promise * item = [DataParser allocPromiseWithResults:results];
        if (item) {
            [array addObject:item];
        }
    }
    return array;
}*/
- (NSMutableArray*)allocNotDonePromisesWithError:(NSError**)error idMember:(NSString*) idMember{
    FMDatabase *db = [self database];
    if (![self openDB:db]) {
        *error = [NSError errorWithDomain:@"Can't open database" code:123 userInfo:nil];
        return nil;
    }
    
    FMResultSet *results = [db executeQuery:@"select * from Promise where idMember = ? and status = 0 and deleted=? ",idMember,[NSNumber numberWithInt:0],[NSNumber numberWithBool:false]];
    if ([db hadError]) {
        DLog(@"Select Error:%@",[[db lastError] localizedDescription]);
        *error = [db lastError];
        [self closeDB:db];
        return nil;
    }
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    while ([results next])
    {
        Promise * item = [DataParser allocPromiseWithResults:results];
        if (item) {
            [array addObject:item];
        }
    }
    [self closeDB:db];
    return array;
}

- (NSMutableArray*)allocDoneOverDuePromisesWithError:(NSError**)error idMember:(NSString*) idMember{
    FMDatabase *db = [self database];
    if (![self openDB:db]) {
        *error = [NSError errorWithDomain:@"Can't open database" code:123 userInfo:nil];
        return nil;
    }
    
    FMResultSet *results = [db executeQuery:@"select * from Promise where idMember = ? and status = 1 or status = 2 and deleted=? ",idMember,[NSNumber numberWithInt:0],[NSNumber numberWithBool:false]];
    if ([db hadError]) {
        DLog(@"Select Error:%@",[[db lastError] localizedDescription]);
        *error = [db lastError];
        [self closeDB:db];
        return nil;
    }
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    while ([results next])
    {
        Promise * item = [DataParser allocPromiseWithResults:results];
        if (item) {
            [array addObject:item];
        }
    }
    [self closeDB:db];
    return array;
}


- (BOOL)checkExistPromiseWithId:(NSString*)idPromise error:(NSError**)error
{
    
    BOOL isExist = NO;
    
    FMDatabase *db = [self database];
    if (![self openDB:db]) {
        *error = [db lastError];
        return NO;
    }
    
    FMResultSet *results = [db executeQuery:@"select * from Promise where id=? and deleted = ?",idPromise,[NSNumber numberWithBool:false]];
    if ([db hadError]) {
        DLog(@"Select Error:%@",[[db lastError] localizedDescription]);
        *error = [db lastError];
        [self closeDB:db];
        return NO;
    }
    
    while ([results next]) {
        isExist = YES;
    }
    [self closeDB:db];
    return isExist;
}

-(BOOL)insertPromise:(Promise*)aPromise idPromise:(NSString**)idPromise error:(NSError**)error
{
    
    if (aPromise==nil) {
        *error = [NSError errorWithDomain:@"Promise object is nil" code:121 userInfo:nil];
        return NO;
    }
    if (aPromise.name.length == 0) {
        *error = [NSError errorWithDomain:@"Promise name is nil" code:121 userInfo:nil];
        return NO;
        
    }
    FMDatabase *db = [self database];
    if (![self openDB:db]) {
        *error = [NSError errorWithDomain:@"Can't open database" code:122 userInfo:nil];
        
        return NO;
    }
     NSString *idString = [ Utilities idWithDate];
   // NSString *idString = [Utilities idWithName:aPromise.name];
    BOOL isSuccess = [db executeUpdate:@"insert into Promise(id, idMember,name, description, duedate, status,deleted,dirty) values(?,?,?,?,?,?,?,?)",idString,aPromise.idMember, aPromise.name,aPromise.description,aPromise.dueDate,[NSNumber numberWithInt:0],[NSNumber numberWithBool:false],[NSNumber numberWithBool:true]];
    if (!isSuccess) {
        if (error!=NULL) {
            *error = [db lastError];
        }
        [self closeDB:db];
        
        return NO;
        
    }
    
    [self closeDB:db];
    return YES;
    
    
}
-(BOOL)updatePromiseOverDue:(NSError**)error isMember:(NSString*) idMember DateCurrent:(NSString *)date
{
    
    FMDatabase *db = [self database];
    if (![self openDB:db]) {
        if (error!=NULL) {
            *error = [db lastError];
            
        }
        DLog(@"Update Error:%@",[[db lastError] localizedDescription]);
        return NO;
    }
    
    
    [db executeUpdate:@"update Promise set status = '2' where idMember = ? and status = '0' and duedate < ? and deleted= ?",idMember,date,[NSNumber numberWithBool:false]];
    
     /*[db executeUpdate:@"update Promise set status = '2'"];*/
    
    if ([db hadError]) {
        if (error!=NULL) {
            *error = [db lastError];
            
        }
        DLog(@"update Error:%@",[[db lastError] localizedDescription]);
        return NO;
    }
    [self closeDB:db];
    
    return YES;
    
}
-(BOOL)updatePromiseInfo:(Promise*)aPromise error:(NSError**)error
{
    
    FMDatabase *db = [self database];
    if (![self openDB:db]) {
        if (error!=NULL) {
            *error = [db lastError];
            
        }
        DLog(@"Update Error:%@",[[db lastError] localizedDescription]);
        return NO;
    }
    
    [db executeUpdate:@"update Promise"
     " set name = ?,description=?,duedate=?,status=?,deleted=?,dirty=?"
     " where id = ? and idMember = ?",aPromise.name,aPromise.description,aPromise.dueDate,[NSNumber numberWithInt:aPromise.status],[NSNumber numberWithBool:false], [NSNumber numberWithBool:true],aPromise.idPromise, aPromise.idMember];

    if ([db hadError]) {
        if (error!=NULL) {
            *error = [db lastError];
            
        }
        DLog(@"update Error:%@",[[db lastError] localizedDescription]);
        return NO;
    }
    [self closeDB:db];
    
    return YES;
    
}

-(BOOL)updateDeletedPromise:(NSString*)idPromise idMember:(NSString*)idMember error:(NSError**)error
{
    
    FMDatabase *db = [self database];
    if (![self openDB:db]) {
        if (error!=NULL) {
            *error = [db lastError];
            
        }
        DLog(@"Update Error:%@",[[db lastError] localizedDescription]);
        return NO;
    }
    
    
    [db executeUpdate:@"update Promise"
     " set deleted=?,dirty=?"
     " where id = ? and idMember = ?",[NSNumber numberWithBool:true], [NSNumber numberWithBool:true],idPromise,idMember];
    
    
    if ([db hadError]) {
        if (error!=NULL) {
            *error = [db lastError];
            
        }
        DLog(@"update Error:%@",[[db lastError] localizedDescription]);
        return NO;
    }
    [self closeDB:db];
    
    return YES;
    
    
    
}


#pragma mark History

- (NSMutableArray*)allocHistoriesWithError:(NSError**)error idMember:(NSString*)idMember{
    FMDatabase *db = [self database];
    if (![self openDB:db]) {
        *error = [db lastError];
        return nil;
    }
    
    FMResultSet *results = [db executeQuery:@"select m.name as memberName, a.unitType as unitType,a.name as activityName, h.imageUrl,h.point,h.time,h.date from History h, Member m, Activity a where h.idMember=m.id and h.idActivity=a.id and m.id = ?",idMember];
    if ([db hadError]) {
        DLog(@"Select Error:%@",[[db lastError] localizedDescription]);
        *error = [db lastError];
        [self closeDB:db];
        return nil;
    }
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    while ([results next])
    {
        History * item = [DataParser allocHistoryWithResults:results];
        if (item) {
            [array addObject:item];
        }
    }
    [self closeDB:db];
    return array;
}
-(NSMutableArray *) allocHistoryWithWeekAndMonth:(NSString*) idMember dayCurrent:(NSString*)dateCurr BeforeWeekandMonth:(NSString*)dateBefore error:(NSError**)error
{
    FMDatabase *db = [self database];
    if (![self openDB:db]) {
        *error = [db lastError];
        return nil;
    }
    
    /* FMResultSet *results = [db executeQuery:@"select m.name as memberName,a.name as activityName, h.imageUrl,h.point from History h, Member m, Activity a where h.idMember=m.id and h.idActivity=a.id and m.id = ?",idMember];*/
    FMResultSet *results = [db executeQuery:@"select a.name as activityName,h.date, SUM (h.point) as totalPoint from History h,Activity a where idMember =? and h.idActivity=a.id AND (h.date BETWEEN ? AND ?) Group by idActivity Order by totalPoint DESC",idMember,dateBefore,dateCurr];
    if ([db hadError]) {
        DLog(@"Select Error:%@",[[db lastError] localizedDescription]);
        *error = [db lastError];
        [self closeDB:db];
        return nil;
    }
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    while ([results next])
    {
        History * item = [DataParser allocHistoryWithResultsGroupByIdActivity:results];
        if (item) {
            [array addObject:item];
        }
    }
    
    [self closeDB:db];
    return array;
    
}

-(NSMutableArray *) allocHistoryWithDay:(NSString*) idMember day:(NSString*)dateDay error:(NSError**)error
{
    FMDatabase *db = [self database];
    if (![self openDB:db]) {
        *error = [db lastError];
        return nil;
    }
    
   /* FMResultSet *results = [db executeQuery:@"select m.name as memberName,a.name as activityName, h.imageUrl,h.point from History h, Member m, Activity a where h.idMember=m.id and h.idActivity=a.id and m.id = ?",idMember];*/
    FMResultSet *results = [db executeQuery:@"select a.name as activityName, SUM (h.point) as totalPoint from History h,Activity a where idMember = ? and h.idActivity=a.id and h.date=? Group by idActivity Order by totalPoint DESC",idMember,dateDay ];
    if ([db hadError]) {
        DLog(@"Select Error:%@",[[db lastError] localizedDescription]);
        *error = [db lastError];
        [self closeDB:db];
        return nil;
    }
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    while ([results next])
    {
        History * item = [DataParser allocHistoryWithResultsGroupByIdActivity:results];
        if (item) {
            [array addObject:item];
        }
    }
    [self closeDB:db];

    return array;

}

-(BOOL)insertHistory:(History*)aHistory idMember:(NSString*)idMember idActivity:(NSString*)idActivity error:(NSError**)error
{
    
    
    if (aHistory==nil) {
        *error = [NSError errorWithDomain:@"History object is nil" code:121 userInfo:nil];
        return NO;
    }

    FMDatabase *db = [self database];
    if (![self openDB:db]) {
        *error = [NSError errorWithDomain:@"Can't open database" code:122 userInfo:nil];
        
        return NO;
    }
    
    BOOL isSuccess = [db executeUpdate:@"insert into History(idMember,idActivity, imageUrl, point, deleted,dirty,date,time) values(?,?,?,?,?,?,?,?)",idMember, idActivity,aHistory.imageUrl,[NSNumber numberWithInt:aHistory.totalPoint],[NSNumber numberWithBool:false],[NSNumber numberWithBool:true],aHistory.date,aHistory.time];
    if (!isSuccess) {
        if (error!=NULL) {
            *error = [db lastError];
        }
        [self closeDB:db];
        
        return NO;
        
    }
    
    [self closeDB:db];
    return YES;
}


@end
