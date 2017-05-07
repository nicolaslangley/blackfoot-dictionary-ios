//
//  DatabaseAccess.swift
//  Blackfoot Dictionary
//
//  Created by Nicolas Langley on 8/22/14.
//  Copyright (c) 2014 Hierarchy. All rights reserved.
//

import Foundation

class DatabaseUtility {
    
    /**
     Retrieve the dictionary database path
     
     - returns: DB path location
     */
    class func getDBPath() -> String {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documentsURL.appendingPathComponent("blkft-dictionary.db").path
    }
    
    /**
     Copy database from app bundle to database path
     */
    class func copyDatabase() {
        let fileManager = FileManager.default
        let dbPath = DatabaseUtility.getDBPath()
        let success = fileManager.fileExists(atPath: dbPath)
        if !success {
            let defaultDBURL = Bundle.main.resourceURL?.appendingPathComponent("blkft-dictionary.db")
            do {
                try fileManager.copyItem(atPath: defaultDBURL!.path, toPath: dbPath)
            } catch let error as NSError {
                print(error.localizedDescription)
                exit(1)
            }
        }
    }

}
