//
//  BFDDatabase.m
//  Blackfoot Dictionary
//
//  Created by Nicolas Langley on 8/21/14.
//  Copyright (c) 2014 Hierarchy. All rights reserved.
//

#import "BFDDatabaseAccess.h"

@implementation BFDDatabaseAccess

+ (NSString *) getDBPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    return [documentsDir stringByAppendingPathComponent:@"DictionaryDatabase.db"];
}

+ (void) copyDatabase {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSString *dbPath = [BFDDatabaseAccess getDBPath];
    BOOL success = [fileManager fileExistsAtPath:dbPath];
    if (!success) {
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"DictionaryDatabase.db"];
        success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
        if (!success) {
            NSAssert1(0, @"Failed to create writable database with message '%@'.", [error localizedDescription]);
        }
        
    }
    
}

+ (NSString *) queryDatabase:(NSString *)input inputLang:(NSString *)inputLang {
    
    NSString *result;
    sqlite3 *database;
    sqlite3_open([[BFDDatabaseAccess getDBPath] UTF8String], &database);
    
    NSString *queryLang;
    if ([inputLang caseInsensitiveCompare:@"Blackfoot"] == NSOrderedSame) {
        queryLang = @"English";
    } else {
        queryLang = @"Blackfoot";
    }
    NSString *sql = [NSString stringWithFormat:@"select %@ from Words where %@=\"%@\"",queryLang, inputLang, input];
    sqlite3_stmt *statement;
    int sqlResult = sqlite3_prepare_v2(database, [sql UTF8String], 100, &statement, NULL);
    if (sqlResult == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            result = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
        }
    }
    sqlite3_reset(statement);
    sqlite3_finalize(statement);
    sqlite3_close(database);
    return result;
}

@end