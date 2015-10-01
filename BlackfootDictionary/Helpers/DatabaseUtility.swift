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
        let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        return documentsURL.URLByAppendingPathComponent("blkft-dictionary.db").path!
    }
    
    // Copy database into resources
    class func copyDatabase() {
        let fileManager = NSFileManager.defaultManager()
        let dbPath = DatabaseUtility.getDBPath()
        let success = fileManager.fileExistsAtPath(dbPath)
        if !success {
            let defaultDBURL = NSBundle.mainBundle().resourceURL?.URLByAppendingPathComponent("blkft-dictionary.db")
            do {
                try fileManager.copyItemAtPath(defaultDBURL!.path!, toPath: dbPath)
            } catch let error as NSError {
                print(error.localizedDescription)
                exit(1)
            }
        }
    }
    
}

