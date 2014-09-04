//
//  DatabaseAccess.swift
//  Blackfoot Dictionary
//
//  Created by Nicolas Langley on 8/22/14.
//  Copyright (c) 2014 Hierarchy. All rights reserved.
//

import Foundation

class DatabaseUtility {
    
    // Retrieve the path to the database
    class func getDBPath() -> String {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        return documentsPath.stringByAppendingPathComponent("blkft-dictionary.db")
    }
    
    // Copy database into resources
    class func copyDatabase() {
        let fileManager = NSFileManager.defaultManager()
        let dbPath = DatabaseUtility.getDBPath()
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
    
}

