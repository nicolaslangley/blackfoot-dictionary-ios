//
//  Blackfoot_Translation_Engine.m
//  Blackfoot Translation Engine
//
//  Created by Nicolas Langley on 8/27/14.
//  Copyright (c) 2014 Hierarchy. All rights reserved.
//

#import "BlackfootTranslationEngine.h"

@implementation BlackfootTranslationEngine

- (NSString *) queryDatabase:(NSString *)word databasePath:(NSString *)dbPath  {
    // Conversion from Objective-C to C++
    const char *db_path = [dbPath UTF8String];
    const char *input_word = [word UTF8String];
    
    sqlite3 *db;
    int sql_result;
    std::string result_string = "";
    
    // Check that the database path exists
    FILE *file = fopen(db_path, "r");
    if (file) {
        // File exists
        fclose(file);
    } else {
        // File does not exist
        exit(1);
    }
    
    // Open (and if necessary create) database
    sql_result = sqlite3_open(db_path, &db);
    if (sql_result == 1) {
        // Database could not be opened
        exit(1);
    }
    
    // Compose the sql query based on the word
    std::string sql_query_1 = "SELECT * FROM words WHERE gloss LIKE \"% ";
    std::string sql_query_2 = "%\" OR gloss LIKE \"%$";
    std::string sql_query_3 = "%\"";
    std::string sql_word = std::string(input_word);
    std::string sql_query = sql_query_1 + sql_word + sql_query_2 + sql_word + sql_query_3;
    
    // Execute query
    sqlite3_stmt *statement;
    sql_result = sqlite3_prepare_v2(db, sql_query.c_str(), 100, &statement, NULL);
    
    // Iterate through results
    if (sql_result == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            result_string.append((const char*)sqlite3_column_text(statement, 1));
            result_string.append(" - ");
            result_string.append((const char*)sqlite3_column_text(statement, 2));
            result_string.append("\n\n");
        }
    } else {
        // Query could not be executed
        exit(1);
    }
    
    // Remove any $ characters
    result_string.erase(std::remove(result_string.begin(), result_string.end(), '$'), result_string.end());
    // Return result string
    // This is Objective-C
    return [NSString stringWithUTF8String:result_string.c_str()];
    
}

@end
