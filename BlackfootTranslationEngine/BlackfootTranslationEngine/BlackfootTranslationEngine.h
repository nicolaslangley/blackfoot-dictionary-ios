//
//  Blackfoot_Translation_Engine.h
//  Blackfoot Translation Engine
//
//  Created by Nicolas Langley on 8/27/14.
//  Copyright (c) 2014 Hierarchy. All rights reserved.
//

#import <Foundation/Foundation.h>

// C++ includes
#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <algorithm>
#include <string.h>
#include <sqlite3.h>

@interface BlackfootTranslationEngine : NSObject {}

- (NSString *) queryDatabase:(NSString *) word databasePath:(NSString *) dbPath;

@end
