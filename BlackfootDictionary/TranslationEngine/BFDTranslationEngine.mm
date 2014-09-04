//
//  BFDTranslationEngine.m
//  BlackfootDictionary
//
//  Created by Nicolas Langley on 8/28/14.
//  Copyright (c) 2014 Hierarchy. All rights reserved.
//

#import "BFDTranslationEngine.h"

// C++ includes
#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <algorithm>
#include <sstream>
#include <string.h>
#include <sqlite3.h>


@implementation BFDTranslationEngine

// This function takes a query and the path to the database and returns the result as a string
+ (NSString *) queryDatabase:(NSString *) sqlQuery databasePath:(NSString *) dbPath  {
    // Conversion from Objective-C to C++
    const char *db_path = [dbPath UTF8String];
    const char *input_query = [sqlQuery UTF8String];
    
    sqlite3 *db;
    int sql_result;
    std::string sql_query = std::string(input_query);
    std::string result_string = "";
    std::stringstream result_stream;
    
    // Check that the database path exists
    FILE *file = fopen(db_path, "r");
    if (file) {
        // File exists
        fclose(file);
    } else {
        // File does not exist
        result_string.append("Database does not exist!");
        // Objective-C
        return [NSString stringWithUTF8String:result_string.c_str()];
    }
    
    // Open (and if necessary create) database
    sql_result = sqlite3_open(db_path, &db);
    if (sql_result == 1) {
        // Database could not be opened
        result_stream.str("");
        result_stream << "The database could not be opened: %s" << sqlite3_errmsg(db);
        result_string = result_stream.str();
        // Objective-C
        return [NSString stringWithUTF8String:result_string.c_str()];
    }
    
    // Execute query
    sqlite3_stmt *statement;
    sql_result = sqlite3_prepare_v2(db, sql_query.c_str(), 100, &statement, NULL);
    
    // Iterate through results
    result_stream.str("");
    if (sql_result == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            result_stream << sqlite3_column_text(statement, 1) << " - " << sqlite3_column_text(statement, 2) << "\n\n";
        }
    } else {
        // Query could not be executed
        result_stream.str("");
        result_stream << "The query could not be executed: %s" << sqlite3_errmsg(db);
        result_string = result_stream.str();
        // Objective-C
        return [NSString stringWithUTF8String:result_string.c_str()];
    }
    
    result_string = result_stream.str();
    // Remove any $ characters
    result_string.erase(std::remove(result_string.begin(), result_string.end(), '$'), result_string.end());
    // Return result string
    // This is Objective-C
    return [NSString stringWithUTF8String:result_string.c_str()];
}

// This function returns the number of matches given by count and that have a phrase including the given word
+ (NSString *) queryMatches:(NSString *) word databasePath:(NSString *) dbPath itemsToReturn:(NSInteger) count {
    // Conversion from Objective-C to C++
    const char *input_word = [word UTF8String];
    // If count is 0, then all records are returned
    int record_count = (int)count;
    std::string count_string = "";
    
    // Compose the sql query based on the word and inputted count
    std::stringstream query_stream;
    query_stream << "SELECT * FROM words WHERE gloss LIKE \"% " << input_word << "%\" OR gloss LIKE \"%$" << input_word << "%\"";
    if (record_count != 0) {
        std::stringstream convert_stream;
        convert_stream << record_count;
        count_string = convert_stream.str();
        query_stream << " LIMIT " << count_string;
    }
    std::string sql_query = query_stream.str();
    
    // Query the database with the query and return the result
    return [BFDTranslationEngine queryDatabase:[NSString stringWithUTF8String:sql_query.c_str()] databasePath:dbPath];
}

// This function queries a random blackfoot word
+ (NSString *) queryRandomWord:(NSString *) dbPath {
    
    // Compose the sql query based on the word and inputted count
    std::stringstream query_stream;
    query_stream << "SELECT * FROM words ORDER BY RANDOM() LIMIT 1";
    std::string sql_query = query_stream.str();
    
    // Query the database with the query and return the result
    return [BFDTranslationEngine queryDatabase:[NSString stringWithUTF8String:sql_query.c_str()] databasePath:dbPath];
}

// This function will take a blackfoot word and convert it to IPA
// TODO: Finish implementing this function
+ (NSString *) convertToIPA:(NSString *) word {
    // Convert from Objective-C to C++
    const char *input_word = [word UTF8String];
    std::string ipa_string = std::string(input_word);
    ipa_string.replace(ipa_string.begin(), ipa_string.end(), "ai", "ə");
    return [NSString stringWithUTF8String:ipa_string.c_str()];
}


@end

