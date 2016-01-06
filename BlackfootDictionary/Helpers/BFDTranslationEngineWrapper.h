//
//  BFDTranslationEngine.h
//  BlackfootDictionary
//
//  Created by Nicolas Langley on 8/28/14.
//  Copyright (c) 2014 Hierarchy. All rights reserved.
//

#ifndef BlackfootDictionary_BFDTranslationEngine_h
#define BlackfootDictionary_BFDTranslationEngine_h

#import <Foundation/Foundation.h>

@interface BFDTranslationEngine : NSObject

+ (NSMutableArray *) queryMatches:(NSString *) word databasePath:(NSString *) dbPath itemsToReturn:(NSInteger) count;
+ (NSMutableArray *) queryRandomWord:(NSString *) dbPath;
+ (NSMutableArray *) queryDatabase:(NSString *) sqlQuery databasePath:(NSString *) dbPath;
+ (NSString *) convertToIPA:(NSString *) word;

@end

#endif