//
//  BFDDatabaseAccess.h
//  Blackfoot Dictionary
//
//  Created by Nicolas Langley on 8/21/14.
//  Copyright (c) 2014 Hierarchy. All rights reserved.
//

#ifndef Blackfoot_Dictionary_BFDDatabaseAccess_h
#define Blackfoot_Dictionary_BFDDatabaseAccess_h

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface BFDDatabaseAccess : NSObject

+ (NSString *) getDBPath;
+ (void) copyDatabase;
+ (NSString *) queryDatabase:(NSString *)input inputLang:(NSString*)inputLang;

@end

#endif
