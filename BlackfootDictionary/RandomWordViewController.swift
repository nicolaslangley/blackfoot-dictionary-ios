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
    
    @IBOutlet weak var outputTextLabel: UILabel!
    var inputText: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.title = "Random Word"
        
        // Display the translated text (in this case just a default placeholder)
        //outputTextLabel.textAlignment = NSTextAlignment.Center
        outputTextLabel.numberOfLines = 0
        outputTextLabel.adjustsFontSizeToFitWidth = true
        outputTextLabel.textAlignment = NSTextAlignment.Center
        randomWord()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Receive the input text value and store it
    func setInputText(input : String) {
        inputText = input
    }
    
    func randomWord() {
        let outputData = TranslationEngineWrapper.queryRandomWord()
        outputTextLabel.text = outputData
    }
    
}

