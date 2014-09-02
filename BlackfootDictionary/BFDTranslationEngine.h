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

// C++ includes
#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <algorithm>
#include <string.h>
#include <sqlite3.h>

@interface BFDTranslationEngine : NSObject

- (NSString *) queryDatabase:(NSString *) word databasePath:(NSString *) dbPath;

@end

#endif
