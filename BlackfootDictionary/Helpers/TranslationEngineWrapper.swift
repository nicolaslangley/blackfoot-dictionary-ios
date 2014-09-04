//
//  TranslationEngine.swift
//  BlackfootDictionary
//
//  Created by Nicolas Langley on 8/29/14.
//  Copyright (c) 2014 Hierarchy. All rights reserved.
//

import Foundation


class TranslationEngineWrapper {
    
    // Wrapper for query database function in BFDTranslationEngine
    class func queryMatches(inputWord: String) -> String {
        // Get path to database and then call BFDTranslationEngine function
        let dbPath = DatabaseUtility.getDBPath()
        let resultString = BFDTranslationEngine.queryMatches(inputWord, databasePath: dbPath, itemsToReturn: 0)
        return resultString!
    }
    
    // Wrapper for random word function in BFDTranslationEngine
    class func queryRandomWord() -> String {
        // Get path to database and then call BFDTranslationEngine function
        let dbPath = DatabaseUtility.getDBPath()
        let resultString = BFDTranslationEngine.queryRandomWord(dbPath)
        return resultString!
    }
    
    // Wrapper function for converting to IPA
    class func convertToIPA(inputWord: String) -> String {
        let resultString = BFDTranslationEngine.convertToIPA(inputWord)
        return resultString
    }
    
}