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
    class func queryAllMatches(_ inputWord: String) -> [String] {
        // Get path to database and then call BFDTranslationEngine function
        let dbPath = DatabaseUtility.getDBPath()
        let resultArray = BFDTranslationEngine.queryAllMatches(inputWord, databasePath: dbPath, itemsToReturn: 0) as NSArray as! [String]
        return resultArray
    }
    
    // Wrapper for query database function in BFDTranslationEngine
    class func queryWordMatches(_ inputWord: String) -> [String] {
        // Get path to database and then call BFDTranslationEngine function
        let dbPath = DatabaseUtility.getDBPath()
        let resultArray = BFDTranslationEngine.queryWordMatches(inputWord, databasePath: dbPath, itemsToReturn: 0) as NSArray as! [String]
        return resultArray
    }
    
    // Wrapper for query database function in BFDTranslationEngine
    class func queryPhraseMatches(_ inputWord: String) -> [String] {
        // Get path to database and then call BFDTranslationEngine function
        let dbPath = DatabaseUtility.getDBPath()
        let resultArray = BFDTranslationEngine.queryPhraseMatches(inputWord, databasePath: dbPath, itemsToReturn: 0) as NSArray as! [String]
        return resultArray
    }
    
    // Wrapper for random word function in BFDTranslationEngine
    class func queryRandomWord() -> [String] {
        // Get path to database and then call BFDTranslationEngine function
        let dbPath = DatabaseUtility.getDBPath()
        let resultArray = BFDTranslationEngine.queryRandomWord(dbPath) as NSArray as! [String]
        return resultArray
    }
    
    // Wrapper for IPA conversion function in BFDTranslationEngine
    class func convertToIPA(_ inputWord: String) -> String {
        let resultString = BFDTranslationEngine.convert(toIPA: inputWord)
        return resultString!
    }
    
}
