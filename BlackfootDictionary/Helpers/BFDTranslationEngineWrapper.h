//
//  BFDTranslationEngine.h
//  BlackfootDictionary
//
//  Created by Nicolas Langley on 8/28/14.
//  Copyright (c) 2014 Hierarchy. All rights reserved.
//

#ifndef BlackfootDictionary_BFDTranslationEngineWrapper_h
#define BlackfootDictionary_BFDTranslationEngineWrapper_h

#import <Foundation/Foundation.h>

@interface BFDTranslationEngine : NSObject

+ (NSMutableArray *) queryAllMatches:(NSString *) word databasePath:(NSString *) dbPath itemsToReturn:(NSInteger) count;
+ (NSMutableArray *) queryWordMatches:(NSString *) word databasePath:(NSString *) dbPath itemsToReturn:(NSInteger) count;
+ (NSMutableArray *) queryPhraseMatches:(NSString *) word databasePath:(NSString *) dbPath itemsToReturn:(NSInteger) count;
+ (NSMutableArray *) queryRandomWord:(NSString *) dbPath;
+ (NSMutableArray *) queryDatabase:(NSString *) sqlQuery databasePath:(NSString *) dbPath;
+ (NSString *) convertToIPA:(NSString *) word;

@end

#endif
