//
//  TranslateViewController.swift
//  Blackfoot Dictionary
//
//  Created by Nicolas Langley on 8/21/14.
//  Copyright (c) 2014 Hierarchy. All rights reserved.
//

import UIKit
import Foundation

class TranslatedOutputViewController: UIViewController {
    
    @IBOutlet weak var outputTextLabel: UILabel!
    var inputText: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.title = "Translate"
        
        // Display the translated text (in this case just a default placeholder)
        //outputTextLabel.textAlignment = NSTextAlignment.Center
        outputTextLabel.numberOfLines = 0
        outputTextLabel.adjustsFontSizeToFitWidth = true
        outputTextLabel.textAlignment = NSTextAlignment.Center
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
        outputTextLabel.text = outputData
    }
    
}

