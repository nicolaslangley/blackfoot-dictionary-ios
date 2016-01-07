//
//  BFDTranslationEngine.hpp
//  BlackfootDictionary
//
//  Created by Nicolas Langley on 1/3/16.
//  Copyright © 2016 Hierarchy. All rights reserved.
//

#ifndef BFDTranslationEngine_hpp
#define BFDTranslationEngine_hpp

#include <stdio.h>
#include <vector>
#include <string>
std::vector<std::string> queryDatabase(std::string sqlQuery, std::string databasePath);
std::vector<std::string> queryAllMatches(std::string word, std::string databasePath, int count);
std::vector<std::string> queryWordMatches(std::string word, std::string databasePath, int count);
std::vector<std::string> queryPhraseMatches(std::string word, std::string databasePath, int count);
std::vector<std::string> queryRandomWord(std::string databasePath);
std::string convertToIPA(std::string word);

#endif /* BFDTranslationEngine_hpp */
