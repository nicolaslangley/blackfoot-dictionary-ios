//
//  TranslationResult.swift
//  BlackfootDictionary
//
//  Created by Nicolas Langley on 1/4/16.
//  Copyright © 2016 Hierarchy. All rights reserved.
//

import Foundation

class TranslationResult: NSObject {

    // MARK: properties
    var blackfootWord: String
    var englishGloss: String
    
    // MARK: initialization
    init(blackfootWord: String, englishGloss: String) {
        self.blackfootWord = blackfootWord
        self.englishGloss = englishGloss
    }
}
