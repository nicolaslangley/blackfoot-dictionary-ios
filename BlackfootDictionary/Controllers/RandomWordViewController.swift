//
//  RandomWordViewController.swift
//  BlackfootDictionary
//
//  Created by Nicolas Langley on 9/2/14.
//  Copyright (c) 2014 Hierarchy. All rights reserved.
//

import UIKit
import Foundation

class RandomWordViewController: UIViewController {
    
    @IBOutlet weak var outputTextView: UITextView!
    var inputText: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Random Word"
        
        // Display the translated text
        outputTextView.scrollRangeToVisible(NSMakeRange(0, 1))
        outputTextView.scrollEnabled = true
        outputTextView.font = UIFont.systemFontOfSize(15)
        outputTextView.textAlignment = NSTextAlignment.Left
        randomWord()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Receive the input text value and store it
    func setInputText(input : String, _nonojbc: () = ()) {
        inputText = input
    }
    
    // Retrieve a random word and display it
    func randomWord() {
        let outputData = TranslationEngineWrapper.queryRandomWord()
        outputTextView.text = outputData 
    }
    
}

