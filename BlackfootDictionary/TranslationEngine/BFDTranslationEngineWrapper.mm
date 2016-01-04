//
//  BFDTranslationEngine.m
//  BlackfootDictionary
//
//  Created by Nicolas Langley on 8/28/14.
//  Copyright (c) 2014 Hierarchy. All rights reserved.
//

#import "BFDTranslationEngineWrapper.h"

// C++ includes
#include "BFDTranslationEngine.hpp"
#include <string.h>
#include <vector>


@implementation BFDTranslationEngine

// This function takes a query and the path to the database and returns the result as a string
+ (NSMutableArray *) queryDatabase:(NSString *) sqlQuery databasePath:(NSString *) dbPath  {
    // Conversion from Objective-C to C++
    const char *db_path = [dbPath UTF8String];
    const char *input_query = [sqlQuery UTF8String];
    // Call into C++
    std::vector<std::string> results = queryDatabase(std::string(input_query), std::string(db_path));
    // Return array of results
    id nsstrings = [NSMutableArray new];
    [nsstrings removeAllObjects];
    for (auto str : results) {
        id nsstr = [NSString stringWithUTF8String:str.c_str()];
        [nsstrings addObject:nsstr];
    }
    return nsstrings;
}

// This function returns the number of matches given by count and that have a phrase including the given word
+ (NSMutableArray *) queryMatches:(NSString *) word databasePath:(NSString *) dbPath itemsToReturn:(NSInteger) count {
    // Conversion from Objective-C to C++
    const char *input_word = [word UTF8String];
    const char *db_path = [dbPath UTF8String];
    // Call into C++
    std::vector<std::string> results = queryMatches(std::string(input_word), std::string(db_path), (int)count);
    // Return array of results
    id nsstrings = [NSMutableArray new];
    [nsstrings removeAllObjects];
    for (auto str : results) {
        id nsstr = [NSString stringWithUTF8String:str.c_str()];
        [nsstrings addObject:nsstr];
    }
    return nsstrings;
}

// This function queries a random blackfoot word
+ (NSString *) queryRandomWord:(NSString *) dbPath {
    // Conversion from Objective-C to C++
    const char *db_path = [dbPath UTF8String];
    // Call into C++
    std::vector<std::string> results = queryRandomWord(std::string(db_path));
    return [NSString stringWithUTF8String:results[0].c_str()];
}

// This function will take a blackfoot word and convert it to IPA
+ (NSString *) convertToIPA:(NSString *) word {
    // Convert from Objective-C to C++
    const char *input_word = [word UTF8String];
    // Call into C++
    std::string ipa_string = convertToIPA(std::string(input_word));
    return [NSString stringWithUTF8String:ipa_string.c_str()];
}


@end

