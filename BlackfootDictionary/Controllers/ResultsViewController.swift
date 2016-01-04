//
//  TranslateViewController.swift
//  Blackfoot Dictionary
//
//  Created by Nicolas Langley on 8/21/14.
//  Copyright (c) 2014 Hierarchy. All rights reserved.
//

import UIKit
import Foundation

class ResultsViewController: UIViewController {
    
    @IBOutlet weak var outputTextView: UITextView!
    var inputText: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Display the translated words
        outputTextView.scrollRangeToVisible(NSMakeRange(0, 1))
        outputTextView.scrollEnabled = true
        outputTextView.font = UIFont.systemFontOfSize(15)
        outputTextView.textAlignment = NSTextAlignment.Left
        translateWord(inputText)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Receive the input text value and store it
    func setInputText(input : String, _nonojbc: () = ()) {
        inputText = input
    }
    
    func translateWord(word: String) {
        let outputData = TranslationEngineWrapper.queryMatches(word)
        outputTextView.text = outputData
    }
    
}

