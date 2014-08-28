//
//  DatabaseAccess.swift
//  Blackfoot Dictionary
//
//  Created by Nicolas Langley on 8/22/14.
//  Copyright (c) 2014 Hierarchy. All rights reserved.
//

import Foundation

class DatabaseAccess {
    
    // Retrieve the path to the database
    class func getDBPath() -> String {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        return documentsPath.stringByAppendingPathComponent("blkft-dictionary.db")
    }
    
    class func copyDatabase() {
        let fileManager = NSFileManager.defaultManager()
        let dbPath = DatabaseAccess.getDBPath()
        var success = fileManager.fileExistsAtPath(dbPath)
        if !success {
            let defaultDBPath = NSBundle.mainBundle().resourcePath?.stringByAppendingPathComponent("blkft-dictionary.db")
            success = fileManager.copyItemAtPath(defaultDBPath!, toPath: dbPath, error: nil)
            if !success {
                print("Failed to create writable database")
                exit(1)
            }
        }
    }
    
    // Return the result of the query to the database in the form of a string
    class func queryDatabase(sql_query: String) -> String {
        
        var resultString: String = ""
        // Create database and open it
        let dbPath = DatabaseAccess.getDBPath()
        // Check that database exists at path otherwise fail
        if !NSFileManager.defaultManager().fileExistsAtPath(dbPath) {
            // Database does not exist
            println("Database not found")
            exit(1)
        }
        let database: FMDatabase = FMDatabase(path: dbPath)
        if !database.open() {
            // The database could not be opened
            println("The database could not be opened")
            exit(1)
        }
        
        // Execute the query and store results
        let result = database.executeQuery(sql_query, withArgumentsInArray: nil)
        // Check that query succeeded
        if result == nil {
            // The query was not successful so display error output
            let err = database.lastError()
            let errCode = database.lastErrorCode()
            let errMessage = database.lastErrorMessage()
            exit(1)
        }
        
        // Iterate through results
        while result.next() {
            resultString = resultString + result.stringForColumn("stem") + " - " + result.stringForColumn("gloss") + "\n\n"
        }
        
        // Remove any $ characters
        resultString = resultString.stringByReplacingOccurrencesOfString("$", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
        return resultString
    }
    
}

