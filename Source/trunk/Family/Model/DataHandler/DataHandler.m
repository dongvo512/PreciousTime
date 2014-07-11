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
@implementation DataHandler

#pragma mark - Connection DB

static NSString *DATABASE_NAME = @"Database.sqlite";
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

- (NSMutableArray*)allocMembers{
    FMDatabase *db = [self database];
    if (![self openDB:db]) {
        return nil;
    }
    
    FMResultSet *results = [db executeQuery:@"select * from Member"];
    if ([db hadError]) {
        DLog(@"Select Error:%@",[[db lastError] localizedDescription]);
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
    return array;
}

- (BOOL)checkExistMemberWithId:(NSString*)idMember
{
    
    BOOL isExist = NO;
    
    FMDatabase *db = [self database];
    if (![self openDB:db]) {
        return NO;
    }
    
    
    FMResultSet *results = [db executeQuery:@"select * from Member where id=?",idMember];
    if ([db hadError]) {
        DLog(@"Select Error:%@",[[db lastError] localizedDescription]);
        [self closeDB:db];
        return NO;
    }
    
    while ([results next]) {
        isExist = YES;
    }
    [self closeDB:db];
    return isExist;
}


-(BOOL)insertMember:(Member*)aMember error:(NSError**)error
{
    
    if (aMember==nil) {
        *error = [NSError errorWithDomain:@"Member object is nil" code:121 userInfo:nil];
        return NO;
    }
    if (aMember.name.length == 0) {
        *error = [NSError errorWithDomain:@"Member name is nil" code:121 userInfo:nil];

    }
    FMDatabase *db = [self database];
    if (![self openDB:db]) {
        *error = [NSError errorWithDomain:@"Can't open database" code:122 userInfo:nil];

        return NO;
    }
    
    NSString *idString = [Utilities idWithName:aMember.name];
    BOOL isSuccess = [db executeUpdate:@"insert into Member(id, name, avatarUrl, birthday, gender,relationship,deleted,dirty) values(?,?,?,?,?,?,?,?)",idString,aMember.name,aMember.avatarUrl,aMember.bithday,[NSNumber numberWithInt:aMember.genderValue],aMember.relationship,[NSNumber numberWithBool:false],[NSNumber numberWithBool:true]];
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

-(BOOL)updateMemberInfo:(Member*)aMember error:(NSError**)error
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
     "set name = ?,avatarUrl=?,birthday=?,gender=?,timestamp=?,deleted=?,dirty=?"
     "where id = ?",aMember.name,aMember.avatarUrl,aMember.bithday,[NSNumber numberWithInt:1],aMember.timestamp,[NSNumber numberWithBool:aMember.deleted], [NSNumber numberWithBool:aMember.dirty]];
    
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

- (BOOL)deleteMemberWithId:(NSString*)memberId error:(NSError**)error
{
    FMDatabase *db = [self database];
    if (![self openDB:db]) {
        return NO;
    }
    
    BOOL isSuccess =  [db executeUpdate:@"delete from Member where id = ?;"
                       ,memberId];
    
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

#pragma mark Activities

- (NSMutableArray*)allocAcitivities{
    FMDatabase *db = [self database];
    if (![self openDB:db]) {
        return nil;
    }
    
    FMResultSet *results = [db executeQuery:@"select * from Activity"];
    if ([db hadError]) {
        DLog(@"Select Error:%@",[[db lastError] localizedDescription]);
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
    return array;
}
#pragma mark Promises

- (NSMutableArray*)allocPromises{
    FMDatabase *db = [self database];
    if (![self openDB:db]) {
        return nil;
    }
    
    FMResultSet *results = [db executeQuery:@"select * from Promise"];
    if ([db hadError]) {
        DLog(@"Select Error:%@",[[db lastError] localizedDescription]);
        [self closeDB:db];
        return nil;
    }
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    while ([results next])
    {
        Activity * item = [DataParser allocPromiseWithResults:results];
        if (item) {
            [array addObject:item];
        }
    }
    return array;
}

#pragma mark History

- (NSMutableArray*)allocHistories{
    FMDatabase *db = [self database];
    if (![self openDB:db]) {
        return nil;
    }
    
    FMResultSet *results = [db executeQuery:@"select * from History"];
    if ([db hadError]) {
        DLog(@"Select Error:%@",[[db lastError] localizedDescription]);
        [self closeDB:db];
        return nil;
    }
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    while ([results next])
    {
        
    }
    return array;
}

@end
