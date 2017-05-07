//
//  ResultViewController.swift
//  BlackfootDictionary
//
//  Created by Nicolas Langley on 1/4/16.
//  Copyright © 2016 Hierarchy. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var blackfootWordLabel: UILabel!
    @IBOutlet weak var englishGlossTextView: UITextView!
    @IBOutlet weak var ipaStringTextView: UITextView!
    
    var blackfootWord: String = ""
    var englishGloss: String = ""
    var ipaString: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ipaString = TranslationEngineWrapper.convertToIPA(blackfootWord)
        englishGlossTextView.text = englishGloss
        ipaStringTextView.text = ipaString
        blackfootWordLabel.text = blackfootWord
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        // Action to perform for moving to another view
    }
}
