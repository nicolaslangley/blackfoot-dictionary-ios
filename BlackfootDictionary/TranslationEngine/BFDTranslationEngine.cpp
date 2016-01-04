//
//  BFDTranslationEngine.cpp
//  BlackfootDictionary
//
//  Created by Nicolas Langley on 1/3/16.
//  Copyright © 2016 Hierarchy. All rights reserved.
//

#include "BFDTranslationEngine.hpp"
#include <stdlib.h>
#include <iostream>
#include <algorithm>
#include <sstream>
#include <sqlite3.h>

using namespace std;

// This function takes a query and the path to the database and returns the result as a string
vector<string> queryDatabase(string sqlQuery, string databasePath) {
    // Conversion from Objective-C to C++
    const char *db_path = databasePath.c_str();
    const char *input_query = sqlQuery.c_str();
    
    sqlite3 *db;
    int sql_result;
    std::string sql_query = std::string(input_query);
    std::string result_string = "";
    std::vector<std::string> results;
    std::stringstream result_stream;
    
    // Check that the database path exists
    FILE *file = fopen(db_path, "r");
    if (file) {
        // File exists
        fclose(file);
    } else {
        // File does not exist
        result_string.append("Database does not exist!");
        cerr << result_string << endl;
        return vector<string>();
    }
    
    // Open (and if necessary create) database
    sql_result = sqlite3_open(db_path, &db);
    if (sql_result == 1) {
        // Database could not be opened
        result_stream.str("");
        result_stream << "The database could not be opened: %s" << sqlite3_errmsg(db);
        result_string = result_stream.str();
        cerr << result_string << endl;
        return vector<string>();
    }
    
    // Execute query
    sqlite3_stmt *statement;
    sql_result = sqlite3_prepare_v2(db, sql_query.c_str(), 100, &statement, NULL);
    
    // Iterate through results
    result_stream.str("");
    if (sql_result == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            result_stream.str("");
            result_stream << sqlite3_column_text(statement, 1) << " - " << sqlite3_column_text(statement, 2) << "\n\n";
            // Remove any $ characters
            result_string = result_stream.str();
            result_string.erase(std::remove(result_string.begin(), result_string.end(), '$'), result_string.end());
            results.push_back(result_string);
        }
    } else {
        // Query could not be executed
        result_stream.str("");
        result_stream << "The query could not be executed: %s" << sqlite3_errmsg(db);
        result_string = result_stream.str();
        cerr << result_string << endl;
        return vector<string>();;
    }
    
    return results;
}

// This function returns the number of matches given by count and that have a phrase including the given word
vector<string> queryMatches(string word, string databasePath, int count) {
    // Conversion from Objective-C to C++
    const char *input_word = word.c_str();
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
    return queryDatabase(sql_query, databasePath);
}

// This function queries a random blackfoot word
vector<string> queryRandomWord(string databasePath) {
    // Compose the sql query based on the word and inputted count
    std::stringstream query_stream;
    query_stream << "SELECT * FROM words ORDER BY RANDOM() LIMIT 1";
    std::string sql_query = query_stream.str();
    
    // Query the database with the query and return the result
    return queryDatabase(sql_query, databasePath);
}

// Function for find and replacing on a string
void replaceAll(std::string& str, const std::string& from, const std::string& to) {
    if(from.empty())
        return;
    size_t start_pos = 0;
    while((start_pos = str.find(from, start_pos)) != std::string::npos) {
        str.replace(start_pos, from.length(), to);
        start_pos += to.length(); // In case 'to' contains 'from', like replacing 'x' with 'yx'
    }
}

// This function will take a blackfoot word and convert it to IPA
string convertToIPA(string word) {
    std::string ipa_string = word;
    // Diphthong replacements
    replaceAll(ipa_string, "ai", "ə");
    replaceAll(ipa_string, "ao", "ɑʷ");
    replaceAll(ipa_string, "oi", "ɔɪ");
    
    // Long vowel replacements
    replaceAll(ipa_string, "aa", "ɑː");
    replaceAll(ipa_string, "ii", "ɪː");
    replaceAll(ipa_string, "oo", "ɘʊ");
    
    // Vowel replacements
    replaceAll(ipa_string, "a", "ɑ");
    replaceAll(ipa_string, "i", "ɪ");
    replaceAll(ipa_string, "o", "ɘʊ");
    
    // Long consonant replacements
    replaceAll(ipa_string, "nn", "nː");
    replaceAll(ipa_string, "mm", "mː");
    replaceAll(ipa_string, "ss", "sː");
    
    // Consonant replacements - NOTE: n, m, and s are unchanged
    replaceAll(ipa_string, "'", "?");
    replaceAll(ipa_string, "p", "b");
    replaceAll(ipa_string, "t", "d");
    replaceAll(ipa_string, "k", "g");
    
    return ipa_string;
}